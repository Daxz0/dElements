elementcheck_ice:
    type: task
    debug: false
    script:
        - if <player.flag[element]> != frostdraw:
            - stop