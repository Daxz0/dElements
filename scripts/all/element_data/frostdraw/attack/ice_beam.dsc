ice_beam_item:
    type: item
    display name: <&color[#A5F2F3]>Ice Beam <red>✯
    material: warped_roots
    lore:
    - <&8>A beam of ice that deals moderate damage.
    - <&3>3s Cooldown
    - <&e>10 Flux


ice_beam_trigger:
    type: world
    debug: true
    events:
        on player right clicks block with:ice_beam_item:
        - determine passively cancelled
        - inject elementcheck_ice
        - if <player.item_in_hand.has_flag[cooldown]>:
                - narrate "<&c>This ability is on cooldown for <player.item_in_hand.flag_expiration[cooldown].from_now.formatted>"
                - stop
        - if <player.flag[flux]> < 10:
            - narrate "<&c>You do not have enough <&e>Flux<&c> to use this!"
            - stop
        - flag player flux:-:10
        - inventory flag slot:hand cooldown expire:3s
        - define start_location <player.eye_location.forward[1].right[0.3].down[0.5]>
        - define target_location <[start_location].precise_target_position[12].if_null[<[start_location].forward[12]>]>
        - define hit_location <player.precise_target_position.y>
        - define mob_eyes <player.precise_target.eye_height.add[<player.precise_target.eye_height.y>].if_null[0]>
        - hurt 5 <player.precise_target[12].if_null[<empty>]> source:<player>
        - cast slow <player.precise_target[12].if_null[<empty>]> amplifier:3 duration:5s no_ambient no_icon hide_particles
        - playeffect at:<[start_location].points_between[<[target_location]>].distance[0.1]> effect:redstone special_data:1|AQUA quantity:50 offset:0
        - wait 10t
        - repeat 5:
            - playeffect effect:redstone at:<[target_location].location.up[0.8]> special_data:1|AQUA quantity:50 offset:0.3,0.3,0.3
            - wait 1s