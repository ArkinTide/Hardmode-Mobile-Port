"""Add missing Chinese glyphs using the project's own fonts, keeping old pixels."""
from pathlib import Path
import argparse,hashlib,json,math
from PIL import Image,ImageFont,ImageDraw
from create_project import load,save

ROOT=Path(__file__).resolve().parent
FONTS={'fntCJK':'Silver.ttf','fntCJKBig':'Noto-Sans-CJK-Bold.otf'}


def raster(font,text):
    mask=font.getmask(text,mode='1')
    image=Image.frombytes('L',mask.size,bytes(mask))
    return image.crop(image.getbbox())


def calibrate(name,filename,data,image):
    refs=['中','文','王']
    results=[]
    for size in range(10,65):
        font=ImageFont.truetype(str(filename),size)
        score=0;matches=0;baselines=[]
        for ref in refs:
            g=data['glyphs'][str(ord(ref))]
            original=image.crop((g['x'],g['y'],g['x']+g['w'],g['y']+g['h'])).getchannel('A')
            bounds=original.getbbox();a=original.crop(bounds)
            b=raster(font,ref)
            exact=a.size==b.size and a.tobytes()==b.tobytes()
            matches+=exact
            score+=abs(a.width-b.width)+abs(a.height-b.height)+abs(g['shift']-font.getlength(ref))
            baselines.append(bounds[1]-font.getbbox(ref,anchor='ls')[1])
        results.append((score,-matches,size,baselines))
    best=min(results)
    print(name,'best calibration',best)
    return best


def main(probe=False):
    catalog=json.loads((ROOT/'localization/zh-CN.json').read_text(encoding='utf8'))
    chars={ord(c) for text in catalog.values() for c in text if ord(c)>127}
    report=[]
    for name,file in FONTS.items():
        folder=ROOT/'project/fonts'/name
        data=load(folder/(name+'.yy'))
        image=Image.open(folder/(name+'.png')).convert('RGBA')
        missing=sorted(chars-{int(k) for k in data['glyphs']})
        score,negative_matches,size,baselines=calibrate(name,folder/file,data,image)
        print(name,'missing codepoints',missing,'bottom',max(g['y']+g['h'] for g in data['glyphs'].values()),'atlas',image.size)
        if probe or not missing:continue
        # Match the original glyph widths and baseline before extending the
        # unused part of the existing atlas; never rerasterize old characters.
        assert score<3 and len(set(baselines))==1,(name,score,baselines)
        font=ImageFont.truetype(str(folder/file),size)
        old=image.copy();old_glyphs=dict(data['glyphs'])
        top=max(g['y']+g['h'] for g in old_glyphs.values())+2
        height=old_glyphs[str(ord('中'))]['h'];x=2
        assert top+height<=image.height,(name,top,height)
        added=[]
        for code in missing:
            text=chr(code);bbox=font.getbbox(text,anchor='ls')
            advance=round(font.getlength(text));width=bbox[2]-bbox[0]
            assert x+width+2<=image.width
            tile=Image.new('L',(width,height))
            ImageDraw.Draw(tile).text((-bbox[0],baselines[0]),text,font=font,fill=255,anchor='ls',stroke_width=0)
            # Match the source's non-antialiased raster setting.
            tile=tile.point(lambda v:255 if v>=128 else 0)
            assert tile.getbbox() and tile.getbbox()[3]<height
            rgba=Image.new('RGBA',tile.size,(255,255,255,0));rgba.putalpha(tile)
            image.paste(rgba,(x,top))
            data['glyphs'][str(code)]={'character':code,'h':height,'offset':bbox[0],
                                      'shift':advance,'w':width,'x':x,'y':top}
            data['ranges'].append({'lower':code,'upper':code})
            added.append(code);x+=width+2
        for g in old_glyphs.values():
            box=(g['x'],g['y'],g['x']+g['w'],g['y']+g['h'])
            assert old.crop(box).tobytes()==image.crop(box).tobytes()
        image.save(folder/(name+'.png'));save(folder/(name+'.yy'),data)
        report.append({'font':name,'added_codepoints':added,'calibrated_size':size,
                       'baseline':baselines[0],'existing_glyph_pixels_unchanged':True,
                       'png_sha256':hashlib.sha256((folder/(name+'.png')).read_bytes()).hexdigest()})
    if not probe and report:
        (ROOT/'release101/font-extension.json').write_text(json.dumps(report,indent=2)+'\n')


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--probe',action='store_true')
    main(parser.parse_args().probe)
