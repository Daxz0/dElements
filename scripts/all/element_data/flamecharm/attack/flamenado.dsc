flamenado_item:
    type: item
    display name: <&color[#fb8b23]>Flamenado <red>✯✯✯
    material: sunflower
    lore:
    - <&8>A tornado of fire.
    - <&3>20s Cooldown
    - <&e>600 Flux


flamenad_trigger:
    type: world
    debug: true
    events:
        on player right clicks block with:flamenado_item:
        - determine passively cancelled
        - inject elementcheck_fire
        - if <player.item_in_hand.has_flag[cooldown]>:
                - narrate "<&c>This ability is on cooldown for <player.item_in_hand.flag_expiration[cooldown].from_now.formatted>"
                - stop
        - if <player.flag[flux]> < 600:
            - narrate "<&c>You do not have enough <&e>Flux<&c> to use this!"
            - stop
        - flag player flux:-:600
        - inventory flag slot:hand cooldown expire:20s
        - playeffect effect:flame at:<player.eye_location> effect:5,2,5 quantity:100
        - playsound <player> sound:block_lava_extinguish
        - wait 1s
        - repeat 5:
            - hurt 15 <player.location.up[0.8].find_entities.within[2].exclude[<player>]> source:<player>
            - burn <player.location.up[0.8].find_entities.within[2].exclude[<player>]> d:5s
            - playsound <player> sound:entity_blaze_shoot
            - playeffect effect:sweep_attack at:<player.eye_location> effect:3,2,3 quantity:100
            - playeffect effect:sweep_attack at:<player.eye_location.up[2]> effect:3,2,3 quantity:100
            - playeffect effect:sweep_attack at:<player.eye_location.up[4]> effect:3,2,3 quantity:100
            - playeffect effect:flame at:<player.eye_location> effect:5,2,5 quantity:100
            - playeffect effect:flame at:<player.eye_location.up[2]> effect:7,2,7 quantity:100
            - playeffect effect:flame at:<player.eye_location.up[4]> effect:7,2,7 quantity:100
            - wait 5t
