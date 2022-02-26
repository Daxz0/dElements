flame_burst_item:
    type: item
    display name: <&color[#fb8b23]>Flame Burst <red>✯✯✯
    material: cut_copper_slab
    lore:
    - <&8>A burst of fire propelling the user and players around.
    - <&3>30s Cooldown
    - <&e>900 Flux


flame_burst_trigger:
    type: world
    debug: false
    events:
        on player right clicks block with:flame_burst_item:
        - determine passively cancelled
        - inject elementcheck_fire
        - if <player.item_in_hand.has_flag[cooldown]>:
                - narrate "<&c>This ability is on cooldown for <player.item_in_hand.flag_expiration[cooldown].from_now.formatted>"
                - stop
        - if <player.flag[flux]> < 900:
            - narrate "<&c>You do not have enough <&e>Flux<&c> to use this!"
            - stop
        - flag player flux:-:900
        - inventory flag slot:hand cooldown expire:30s
        - playsound sound:entity_generic_explode <player>
        - playeffect effect:flame at:<player.location.up[1]> offset:1,1,1 quantity:500
        - shoot <player> no_rotate height:29