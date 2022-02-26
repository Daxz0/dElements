flame_repel_item:
    type: item
    display name: <&color[#fb8b23]>Flame Repel <red>✯
    material: fire_charge
    lore:
    - <&8>Repels your ememies, knocking them back.
    - <&3>10s Cooldown
    - <&e>80 Flux


fire_repel_repel:
    type: world
    debug: false
    events:
        on player right clicks block with:flame_repel_item:
        - determine passively cancelled
        - inject elementcheck_fire
        - if <player.item_in_hand.has_flag[cooldown]>:
                - narrate "<&c>This ability is on cooldown for <player.item_in_hand.flag_expiration[cooldown].from_now.formatted>"
                - stop
        - if <player.flag[flux]> < 80:
            - narrate "<&c>You do not have enough <&e>Flux<&c> to use this!"
            - stop
        - flag player flux:-:80
        - inventory flag slot:hand cooldown expire:10s
        - teleport <player> <player.location.up[1]>
        - adjust <player> gravity:false
        - flag player noMove expire:2s
        - playsound <player> sound:block_lava_extinguish
        - playeffect effect:flame at:<player.location.up[0.8].points_around_x[radius=2;points=30]> quantity:30 offset:0
        - playeffect effect:flame at:<player.location.up[0.8].points_around_z[radius=2;points=30]> quantity:30 offset:0
        - wait 25t
        - playsound <player> sound:entity_blaze_shoot
        - playeffect effect:flame at:<player.location.up[0.8].points_around_x[radius=2;points=30]> quantity:30 offset:0
        - playeffect effect:flame at:<player.location.up[0.8].points_around_z[radius=2;points=30]> quantity:30 offset:0
        - playeffect effect:flame at:<player.location.up[0.8].points_around_x[radius=4;points=50]> quantity:100 offset:1,0,0
        - playeffect effect:flame at:<player.location.up[0.8].points_around_z[radius=4;points=50]> quantity:100 offset:0,0,-1
        - hurt 10 <player.location.up[0.8].find_entities.within[4].exclude[<player>]> source:<player>
        - burn <player.location.up[0.8].find_entities.within[4].exclude[<player>]> d:10s
        - push <player.location.up[0.8].find_entities.within[4].exclude[<player>]> destination:<player.location.relative[0,0,-5]>
        - adjust <player> gravity:true