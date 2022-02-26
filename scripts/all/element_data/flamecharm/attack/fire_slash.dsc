fire_slash_item:
    type: item
    display name: <&color[#fb8b23]>Fire Slash <red>✯
    material: fire_coral
    lore:
    - <&8>A firey slash of flames.
    - <&3>2s Cooldown
    - <&e>10 Flux


fire_slash_slash:
    type: world
    debug: false
    events:
        on player right clicks block with:fire_slash_item:
        - determine passively cancelled
        - inject elementcheck_fire
        - if <player.item_in_hand.has_flag[cooldown]>:
                - narrate "<&c>This ability is on cooldown for <player.item_in_hand.flag_expiration[cooldown].from_now.formatted>"
                - stop
        - if <player.flag[flux]> < 10:
            - narrate "<&c>You do not have enough <&e>Flux<&c> to use this!"
            - stop
        - flag player flux:-:10
        - flag player noMove expire:1s
        - inventory flag slot:hand cooldown expire:2s
        - define loc <player.location>
        - playsound <player> sound:entity_blaze_hurt
        - playeffect effect:flame at:<player.eye_location.up[0.3]> quantity:100 offset:0.3,0,0.3
        - wait 15t
        - playsound <player> sound:entity_blaze_shoot
        - playeffect effect:flame at:<[loc].up[0.8].points_around_y[radius=3;points=30]> quantity:30 offset:0
        - hurt 5 <[loc].up[0.8].find_entities.within[3].exclude[<player>]> source:<player>
        - burn <[loc].up[0.8].find_entities.within[3].exclude[<player>]> d:5s