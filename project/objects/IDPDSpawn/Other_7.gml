if sprite_index = sprIDPDPortalStart sprite_index = sprIDPDPortalCharge

if sprite_index = sprIDPDPortalClose {
    // Keep the last visible close frame until the native unit alarm fires.
    if alarm[1] >= 0 {image_index=sprite_get_number(sprite_index)-1;image_speed=0;}
    else instance_destroy()
}
