import PySimpleGUI as sg


def generate_time_point(int_time):

    # this generates a time point, which is equivalent to
    # a row on the Experimental Control Window
    # A row contains the Mode, Delay, TTL switches, Step, AH,
    # Trap, Repump, aom, vco specifications

    # input is the time_point number
    # e.g.: 1st time point --> input is 1

    # returns the time_point, which is a list object

    time = str(int_time)

    time_point = list()
    time_point.append(sg.InputCombo(('Continue', 'Ramp','Loop','EndLoop','Halt'), size=(8, 1), key='_mode_'+ time + '_'))
    time_point.append(sg.InputText(default_text='0', size=(5, 1), key='_delay_' + time + '_'))
    for i in range(6):
        time_point.append(sg.Checkbox('', size=(1,1), default=False, key='_switch_' + time + str(i) +'_'))

    time_point.append(sg.InputText(default_text='0.01', size=(6, 1), key='_step_' + time + '_'))
    time_point.append(sg.InputText(default_text='0', size=(6, 1), key='_AH_' + time + '_'))
    time_point.append(sg.InputText(default_text='0', size=(6, 1), key='_Trap_' + time + '_'))
    time_point.append(sg.InputText(default_text='0', size=(6, 1), key='_Repump_' + time + '_'))
    time_point.append(sg.InputText(default_text='0', size=(6, 1), key='_aom_760_' + time + '_'))
    time_point.append(sg.InputText(default_text='0', size=(6, 1), key='_vco_760_' + time + '_'))


    return time_point



def generate_time_line(time_points):

    # Input: how many time points the user wants
    # this generates a list of time points
    # returns a list of time_points.



    # creates the header

    header_mode = sg.Text('Mode',  size=(10, 1), justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    delay_head  = sg.Text('Delay', size=(5, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    step_head  = sg.Text('Step', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    AH_head  = sg.Text('AH', size=(5, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    Repump_head  = sg.Text('Repump', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    Trap_head  = sg.Text('Trap', size=(5, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    aom_760_head  = sg.Text('760 aom', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    vco_760_head  = sg.Text('760 vco', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    blank_head  = sg.Text(' ', size=(30, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)

    header_list = [header_mode, delay_head, blank_head , step_head, AH_head, Trap_head, Repump_head, aom_760_head, vco_760_head]

    points = list()
    points.append(header_list)

    for i in range(time_points):
        points.append(generate_time_point(i))

    return points



def layout_main(time_points):

    # this function creates the layout for the main window
    # layout is just a list of objects
    # input is the number of time points

    # ------ Menu Definition ------ #
    menu_def = [['File', ['Open', 'Save', 'Exit', 'Properties']],
                ['Edit', ['Paste', ['Special', 'Normal', ], 'Undo'], ],
                ['Help', 'About...'], ]


    # header definitions
    header_0 = sg.Text('Experimental Control', size=(30, 1), justification='center', font=("Helvetica", 15), relief=sg.RELIEF_RIDGE)
    spinner_name = sg.Text('Number of time points')
    spinner = sg.Spin([sz for sz in range(6, 172)], font=('Helvetica 15'), initial_value= time_points , change_submits=True, key='_spin_')
    update_hardware = sg.Button('Update hardware')

    # creates menu
    menu = sg.Menu(menu_def, tearoff=True)




    layout = [[menu], [header_0, spinner_name, spinner, update_hardware],
              [sg.Frame(layout = generate_time_line(time_points),
                      title='Control Board',title_color='Black', relief=sg.RELIEF_SUNKEN)]]


    return layout
