fire_palm_item:
    type: item
    display name: <&color[#fb8b23]>Fire Palm <red>✯✯
    material: cut_copper_stairs
    lore:
    - <&8>A cone of fire bursting from the palm.
    - <&3>10s Cooldown
    - <&e>200 Flux


fire_palm_trigger:
    type: world
    debug: false
    events:
        on player right clicks block with:fire_palm_item:
        - determine passively cancelled
        - inject elementcheck_fire
        - if <player.item_in_hand.has_flag[cooldown]>:
                - narrate "<&c>This ability is on cooldown for <player.item_in_hand.flag_expiration[cooldown].from_now.formatted>"
                - stop
        - if <player.flag[flux]> < 200:
            - narrate "<&c>You do not have enough <&e>Flux<&c> to use this!"
            - stop
        - flag player flux:-:200
        - inventory flag slot:hand cooldown expire:10s
        - flag player noMove expire:2s
        - repeat 3:
            - animate animation:ARM_SWING <player>
            - playsound <player> sound:entity_blaze_hurt
            - playeffect effect:flame at:<player.location.right[0.3].up[0.8]> offset:0.2,0.2,0.2 quantity:9
            - wait 10t
        - playsound <player> sound:entity_blaze_shoot
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[6].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[5].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[4].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[3].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[2].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[1].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[0].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[-1].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[-2].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[-3].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[-4].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[-5].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - playeffect effect:flame at:<player.eye_location.forward[0.5].right[0.3].points_between[<player.eye_location.left[-6].forward[6]>].distance[0.3]> quantity:5 offset:0,0.5,0
        - hurt 30 <player.eye_location.forward[3].find_entities.within[6].exclude[<player>].filter_tag[<player.eye_location.facing[<player.eye_location.forward[6].right[0.3]>]>]> source:<player>
        - burn <player.eye_location.forward[3].find_entities.within[6].exclude[<player>].filter_tag[<player.eye_location.facing[<player.eye_location.forward[6].right[0.3]>]>]> duration:25s