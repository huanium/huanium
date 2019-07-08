# this script defines some of the global variables

def init():
    global new_time_points
    global old_time_points
    global default_num_pts
    global event
    global values
    global sequence
    global instructions
    global AH
    global Trap
    global Repump
    global aom
    global vco
    global window


    window = None
    new_time_points = 10
    old_time_points = 10
    default_num_pts = 5
    event = ''
    values = {}
    sequence = {}
    instructions = []
    AH = []
    Trap = []
    Repump = []
    aom = []
    vco = []
