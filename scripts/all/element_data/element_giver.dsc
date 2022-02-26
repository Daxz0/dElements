elementroller:
    type: item
    display name: <&c>Element Roller
    material: player_head
    lore:
    - <&7>A new adventure awaits...
    mechanisms:
        skull_skin: 538900a6-9df8-4e72-97b7-aa97afd37658|ewogICJ0aW1lc3RhbXAiIDogMTY0NTU4MDc1MDc1NiwKICAicHJvZmlsZUlkIiA6ICIyYWQwZDlmMGUxMTM0ODM0OGVmNDQ0OWRmNTRlYTFkNCIsCiAgInByb2ZpbGVOYW1lIiA6ICJGaXJlQjB5IiwKICAic2lnbmF0dXJlUmVxdWlyZWQiIDogdHJ1ZSwKICAidGV4dHVyZXMiIDogewogICAgIlNLSU4iIDogewogICAgICAidXJsIiA6ICJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzc1YTE0NWY1ZGFhMjRmZTljYTc4ZDNlZjlhMTU0OGI5NDMzODRjNTk1ZTZjMzI0MzMyNDNiYzYyMTM5YTFkNGMiLAogICAgICAibWV0YWRhdGEiIDogewogICAgICAgICJtb2RlbCIgOiAic2xpbSIKICAgICAgfQogICAgfQogIH0KfQ==



elementroller_util:
    type: world
    debug: false
    events:
        on player places elementroller:
        - determine cancelled
        on player equips elementroller:
        - determine cancelled



give_element:
    type: world
    debug: false
    events:
        after player joins flagged:!notFirstJoin:
            - flag player notFirstJoin
            - give elementroller

        after player drops elementroller:
        - remove <context.entity>
        - define rng <util.random.int[1].to[5]>
        - repeat 2:
            - title title:<&color[#fb8b23]>Flamecharm
            - playsound <player> sound:ENTITY_EXPERIENCE_ORB_PICKUP
            - wait 10t
            - title title:<&color[#eaeaea]>Galebreath
            - playsound <player> sound:ENTITY_EXPERIENCE_ORB_PICKUP
            - wait 10t
            - title title:<&color[#A5F2F3]>Frostdraw
            - playsound <player> sound:ENTITY_EXPERIENCE_ORB_PICKUP
            - wait 10t
            - title title:<&color[#eedd82]>Thundercall
            - playsound <player> sound:ENTITY_EXPERIENCE_ORB_PICKUP
            - wait 10t
        - if <[rng]> == 1:
            - flag player element:flamecharm
            - run victory
            - title title:<&color[#fb8b23]>Flamecharm
        - else if <[rng]> == 2:
            - flag player element:frostdraw
            - run victory
            - title title:<&color[#A5F2F3]>Frostdraw
        - else if <[rng]> == 3:
            - flag player element:galebreath
            - run victory
            - title title:<&color[#eaeaea]>Galebreath
        - else if <[rng]> == 4:
            - flag player element:thundercall
            - run victory
            - title title:<&color[#eedd82]>Thundercall
