elementcheck_fire:
    type: task
    debug: false
    defs: elementpass
    script:
        - if <player.flag[element]> != flamecharm:
            - stop