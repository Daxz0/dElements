flame_of_mending_item:
    type: item
    display name: <&color[#fb8b23]>Flame of Mending <red>✯
    material: campfire
    lore:
    - <&8>A campfire of restoration.
    - <&3>10s Cooldown
    - <&e>50<&pc> Flux

flame_of_mending_trigger:
    type: world
    debug: false
    events:
        on player right clicks block with:flame_of_mending_item:
            - determine passively cancelled
            - if <context.block> != air:
                - inject elementcheck_fire
                - if <player.item_in_hand.has_flag[cooldown]>:
                    - narrate "<&c>This ability is on cooldown for <player.item_in_hand.flag_expiration[cooldown].from_now.formatted>"
                - if <player.flag[flux]> < <player.flag[maxflux].mul[0.5]>:
                    - narrate "<&c>You do not have enough <&e>Flux<&c> to use this!"
                    - stop
                - flag player flux:-:<player.flag[maxflux].mul[0.5]>
                - inventory flag slot:hand cooldown expire:10s
                - showfake fire <context.location.up[1]> d:5s
                - repeat 5:
                    - if <context.location.up[1].find_entities[player].within[2].any>:
                        - wait 1s
                        - flag player health:+:<player.flag[maxhealth].mul[0.10].round_up>