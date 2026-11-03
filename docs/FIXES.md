# Hardmode Mobile 1.1.0 / build 14

This release synchronizes the maintained NTT v100.034 Hardmode content with mobile 1.0.12. Mobile input, translations, storage, platform timing, compact wall renderer and mutation selector are retained through host adapters.

## Gameplay and balance

- Native loop enemy pools, special enemy variants, radiation and pickup policies, including pre-cap raven/snow-robot base drops of 1, crystal reductions, ordinary green-rat rewards at the cap, and bonefish rewards.
- Optional player boost: +2 maximum HP and one additional level/mutation; repeat initialization and continue-game do not stack it.
- Extra bosses use their normal combat behavior without loop attack upgrades or the first-loop 30% HP bonus. They retain 5% HP per loop, random eligible map placement and a one-second room-entry grace period. Their configured count can be zero and its upper bound grows every two loops. They do not replace the ordinary stage boss, play boss music or summon extra ravens.
- The native changes to boss HP, self-rocket immunity, crystal half-health splitting, raven summon cap, turtle weapon rendering, Rogue attacks and Gun God off-world combat are included.
- Off-world sewer Rat spawns in a real mask-fitting water pool on existing complete floor tiles. It is vulnerable, has no tentacles and uses a raised submerged renderer. Gun God's off-world terrain restrictions, first-phase projectile policy and L3 YV phase are retained.
- Boss health bars support Hardmode bosses, overhead extra-boss bars and selected top-of-screen bars. Throne-ball deflection and player boost have persistent touch-accessible switches.

## Police, portals and progression

- Animated police robot charge/warning, particles and timed emergence; separate gates avoid recurring van requests. Native loop police/freak weights and infantry limits are included.
- Police portal transitions are blue from the first prewarmed ring. Van wreckage does not replace the last combat death as the exit location.
- Extended Throne hall: player at bottom center, boss at upper center, complete generator annexes generated on the boss side before wall construction.
- 7-4 crown-vault round trip resumes at Throne without spending an extra visit or changing the loop.
- Jungle entrance, fish skull and golden-car clear gates, guaranteed 3-1 access tool, HQ rules, cave exits and native music routing are synchronized.
- Native Venus retry/progression, carried-weapon cleanup, authored terrain and stage cleanup are retained with mobile interaction adapters. The pause-menu restart uses the synchronized retry request, including secret stages.

## Terrain, rendering and performance

- Preserve compact outer-wall collision/rendering, native edge/transition layer selection and cave palette restoration without recreating all detailed walls.
- The host uses five-point actual-water support with immediate bank recovery. Native pool creation is converted to the host's water material ID, keeping swimming and movement friction separate.
- Retain 30 Hz AI and manually moved MOD entities with smooth optional 60 Hz presentation, including submerged actors and layered crystals.
- Native bounded beam queries, staggered entity work, effect budgets, corpse/particle lifetimes, cached wall/effect work and audio limits are included. Performance remains scene- and device-dependent.

## Scope and verification

The implementation ledger accounts for 543 historical native transformations: 509 imported, 8 mobile equivalents, 25 changes in upstream files that neither active loader references, and 1 Grillskills change excluded at the user's request. These counts describe source coverage, not 543 independently exercised runtime features. See [migration ledger](migration-1.1.0.json).

Compiled desktop tests run silently on a private desktop, without foreground window control or input automation. Package verification checks fresh platform resources, Android signing and pacing, iOS runner compatibility and storage metadata. Exact cases and hashes are retained in the local delivery receipt. This is targeted regression testing, not exhaustive manual gameplay or physical Android/iPhone validation. IPA requires resigning; no native Mac rebuild or universal high-loop 60 FPS guarantee is claimed.
