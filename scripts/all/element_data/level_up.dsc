


actionbarsystem:
    type: world
    debug: false
    events:
        on delta time secondly every:1:
        - foreach <server.online_players> as:__player:
            - adjust <player> hide_particles:damage_indicator
            - actionbar " <&c><player.flag[health].round_down>/<player.flag[maxhealth]>❤    <&e><player.flag[flux]>/<player.flag[maxflux]>⚡ Flux"
            - if <player.flag[health].is_decimal>:
                - flag player health:<player.flag[health].round_down>
            - if <player.flag[flux].is_decimal>:
                - flag player flux:<player.flag[flux].round_down>
            - if <player.flag[health]> < <player.flag[maxhealth]>:
                - flag player health:+:<player.flag[maxhealth].add[1].mul[0.01].round_down>
            - if <player.flag[health]> > <player.flag[maxhealth]>:
                - flag player health:+:<player.flag[maxhealth].sub[<player.flag[health]>].round_down>
            - if <player.flag[flux]> < <player.flag[maxflux]>:
                - flag player flux:+:<player.flag[maxflux].mul[0.02].round_down>
            - if <player.flag[flux]> > <player.flag[maxflux]>:
                - flag player flux:+:<player.flag[maxflux].sub[<player.flag[flux]>].round_down>


            - if <player.flag[health]> <= 0:
                - hurt <player> <player.health> cause:player
                - flag player health:<player.flag[maxhealth]>
        on player damaged:
            - determine passively cancelled
            - animate <player> animation:hurt
            - playsound <player> sound:entity_player_hurt
            - flag <player> health:-:<context.damage>
        after player joins:
        - if !<player.has_flag[flux]> && !<player.has_flag[health]>:
            - flag player level:1
            - flag player xp:0
            - flag <player> flux:100
            - flag <player> maxflux:100
            - flag <player> health:100
            - flag <player> maxhealth:100
            - flag <player> reqxp:100


resetallvalues:
    type: command
    name: rav
    description: a
    usage: /rav
    script:
        - flag player level:1
        - flag player xp:0
        - flag <player> flux:100
        - flag <player> maxflux:100
        - flag <player> health:100
        - flag <player> maxhealth:100
maxallvalues:
    type: command
    name: mav
    description: a
    usage: /mav
    script:
        - flag <player> flux:9999999
        - flag <player> maxflux:9999999
        - flag <player> health:9999999
        - flag <player> maxhealth:9999999


xplevelupcheck:
    type: world
    debug: false
    events:
        on player opens playermenu:
        - flag player menuopen
        on player closes playermenu:
        - flag player menuopen:!

        on delta time secondly:
        - foreach <server.online_players> as:__player:
            - if <player.flag[level]> == 35:
                - stop
            - if <player.flag[reqxp].is_less_than_or_equal_to[<player.flag[xp]>]>:
                - run victory
                - flag player xp:<player.flag[xp].sub[<player.flag[reqxp]>]>
                - flag player level:++
                - narrate <&b>----------------------------------------
                - narrate <&b>
                - narrate "  <&b><&l>LEVEL UP <&r><&c><&8><player.flag[level].sub[1].to_roman_numerals>→<&2><player.flag[level].to_roman_numerals>"
                - narrate <&b>
                - narrate <&b>----------------------------------------
                - flag player reqxp:<player.flag[reqxp].mul[1.5].round_down>
            - if <player.has_flag[menuopen]>:
                - inventory open destination:playermenu






xpgrant:
    type: world
    events:
        on player kills entity:
        - flag player xp:+:<context.entity.health_max.div[2]>
        - actionbar "<&c>+ <context.entity.health_max.div[2]> XP"


playermenu:
    type: inventory
    title: Player Menu
    inventory: chest
    gui: true
    size: 54
    slots:
    - "[panes] [panes] [panes] [panes] [panes] [panes] [panes] [panes] [panes]"
    - "[panes] [panes] [panes] [panes] [phead] [panes] [panes] [panes] [panes]"
    - "[panes] [panes] [panes] [panes] [panes] [panes] [panes] [panes] [panes]"
    - "[panes] [panes] [panes] [panes] [levelitem] [panes] [panes] [panes] [panes]"
    - "[panes] [panes] [panes] [panes] [panes] [panes] [panes] [panes] [panes]"
    - "[panes] [panes] [panes] [panes] [panes] [panes] [panes] [panes] [panes]"

phead:
    type: item
    display name: <&b>Your profile
    material: player_head[skull_skin=<player.name>]

menucmd:
    type: command
    name: menu
    description: Opens the Player Menu
    usage: /menu
    script:
    - inventory open d:playermenu

panes:
    type: item
    display name: <&c>
    material: BLACK_STAINED_GLASS_pane

levelitem:
    type: item
    display name: <&c>Level <player.flag[level].format_number.if_null[NaN]>
    material: iron_sword
    mechanisms:
        unbreakable: true
        hides: all
    lore:
    - <&7>Progress to Level <player.flag[level].add[1].if_null[NaN]><&e>
    - <&e><player.flag[xp].format_number.if_null[NaN]><&7>/<&e><player.flag[reqxp].format_number.if_null[NaN]>