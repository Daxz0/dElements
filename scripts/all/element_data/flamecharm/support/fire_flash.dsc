fire_flash_item:
    type: item
    display name: <&color[#fb8b23]>Fire Flash <red>✯
    material: firework_star
    lore:
    - <&8>A blazing flash of fire.
    - <&3>3s Cooldown
    - <&e>5 Flux


fire_flash_item_trigger:
    type: world
    debug: false
    events:
        on player walks flagged:flashed:
        - playeffect effect:flame at:<player.eye_location> offset:0.2,0.2,0.2 quantity:300
        on player right clicks block with:fire_flash_item:
            - determine passively cancelled
            - inject elementcheck_fire
            - if <player.item_in_hand.has_flag[cooldown]>:
                    - narrate "<&c>This ability is on cooldown for <player.item_in_hand.flag_expiration[cooldown].from_now.formatted>"
                    - stop
            - if <player.flag[flux]> < 5:
                - narrate "<&c>You do not have enough <&e>Flux<&c> to use this!"
                - stop
            - flag player flux:-:5
            - inventory flag slot:hand cooldown expire:3s
            - define loc <player.eye_location.forward[3].right[1]>
            - define flash_loc <[loc].up[2]>
            - animate <player> animation:arm_swing
            - playeffect effect:flame at:<[loc]> offset:0 quantity:1
            - playsound <player.location.find_entities.within[30]> sound:entity_firework_rocket_launch
            - wait 5t
            - playsound <player.location.find_entities.within[30]> sound:entity_firework_rocket_launch
            - playeffect effect:flame at:<[loc].up[1]> offset:0 quantity:1
            - wait 10t
            - playsound <player.location.find_entities.within[30]> sound:entity_blaze_shoot
            - playeffect effect:flame at:<[loc].up[2]> offset:0 quantity:30
            - foreach <player.location.find_entities.within[30].exclude[<player>]> as:__player:
                - if <player.eye_location.facing[<[flash_loc]>].degrees[30]>:
                    - flag player flashed expire:0.5s
                    - cast blindness <player> amplifier:255 duration:3s hide_particles no_ambient no_icon
                    - repeat 4:
                        - playeffect effect:flame at:<player.eye_location> offset:0.2,0.2,0.2 quantity:300
                        - wait 0.1s