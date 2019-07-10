import PySimpleGUI as sg
from tkinter import *
from random import randint
import numpy as np
import settings


def bool(true_or_false):
    # converts string 'True' to True
    # same for 'False'
    if true_or_false == 'True':
        return True
    elif true_or_false == 'False':
        return False
    else:
        return


def generate_time_point(int_time, row_specs):
    # this generates a time point, which is equivalent to
    # a row on the Experimental Control Window
    # A row contains the Mode, Delay, TTL switches, Step, AH,
    # Trap, Repump, aom, vco specifications
    # input is the specs for a row
    # input includes: Mode, Delay, Switch_state x 8, Step, AH, Trap, Repump, aom, vco

    time = str(int_time)
    time_point = []
    time_point.append(sg.Spin(values=('Exp. Ramp', 'Sin. Ramp', 'Lin. Ramp', '-Select-'), initial_value=row_specs[0], size=(10, 1), change_submits=True, key='_mode_'+ time + '_') )
    # time_point.append(sg.InputCombo(('-Select-', 'Ramp','Continue', 'Loop','EndLoop','Halt'), size=(8, 1), change_submits=True, key='_mode_'+ time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[1], size=(9, 1), change_submits=True, key='_delay_' + time + '_'))

    # number of tick boxes per row
    for i in range(8):
        time_point.append(sg.Checkbox('', size=(1,1), default=bool(row_specs[2][i]), change_submits=True, key='_switch_' + time + '_' +  str(i) +'_'))

    if row_specs[0] == '-Select-':
        # then voltage mode
        time_point.append(sg.InputText(default_text=row_specs[3], size=(6, 1), change_submits=True, key='_step_' + time + '_'))
        time_point.append(sg.InputText(default_text=row_specs[4], size=(6, 1), change_submits=True, key='_AH_' + time + '_'))
        time_point.append(sg.InputText(default_text=row_specs[5], size=(6, 1), change_submits=True, key='_Trap_' + time + '_'))
        time_point.append(sg.InputText(default_text=row_specs[6], size=(6, 1), change_submits=True, key='_Repump_' + time + '_'))
        time_point.append(sg.InputText(default_text=row_specs[7], size=(6, 1), change_submits=True, key='_aom_760_' + time + '_'))
        time_point.append(sg.InputText(default_text=row_specs[8], size=(6, 1), change_submits=True, key='_vco_760_' + time + '_'))

    else: # if we're in ramped mode --> these blanks become time
        time_point.append(sg.InputText(default_text=row_specs[3], size=(6, 1), text_color='Blue', change_submits=True, key='_step_' + time + '_'))
        time_point.append(sg.InputText(default_text=row_specs[4], size=(6, 1), text_color='Blue', change_submits=True, key='_AH_' + time + '_'))
        time_point.append(sg.InputText(default_text=row_specs[5], size=(6, 1), text_color='Blue', change_submits=True, key='_Trap_' + time + '_'))
        time_point.append(sg.InputText(default_text=row_specs[6], size=(6, 1), text_color='Blue', change_submits=True, key='_Repump_' + time + '_'))
        time_point.append(sg.InputText(default_text=row_specs[7], size=(6, 1), text_color='Blue', change_submits=True, key='_aom_760_' + time + '_'))
        time_point.append(sg.InputText(default_text=row_specs[8], size=(6, 1), text_color='Blue', change_submits=True, key='_vco_760_' + time + '_'))




    time_point.append(sg.Button('Insert', key='_insert_' + time + '_'))

    return time_point

def generate_time_line(time_points):
    # Input: how many time points the user wants
    # this generates a list of time points
    # returns a list of time_points.
    # creates the header
    header_mode = sg.Text('Mode',  size=(10, 1), justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    delay_head  = sg.Text('Delay', size=(8, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    step_head  = sg.Text('Step', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    AH_head  = sg.Text('AH', size=(5, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    Repump_head  = sg.Text('Repump', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    Trap_head  = sg.Text('Trap', size=(5, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    aom_760_head  = sg.Text('760 aom', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    vco_760_head  = sg.Text('760 vco', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    blank_head  = sg.Text(' ', size=(42, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    header_list = [header_mode, delay_head, blank_head , step_head, AH_head, Trap_head, Repump_head, aom_760_head, vco_760_head]
    points = []
    points.append(header_list)

    for i in range(len(settings.instructions)):
        row_specs = settings.instructions[i]
        points.append(generate_time_point(i, row_specs))
        # points.append(generate_time_point(i))
    return points




def layout_main(time_points):
    # this function creates the layout for the main window
    # layout is just a list of objects
    # input is the number of time points
    # ------ Menu Definition ------ #
#    menu_def = [['File', ['Open', 'Save', 'Exit', 'Properties']],
#                ['Edit', ['Paste', ['Special', 'Normal', ], 'Undo'], ],
#                ['Help', 'About...'], ]
    menu_def = [['Action',[ 'About', 'Exit']]]

    spin = int(settings.sequence['_spin_'])
    rate = str(settings.sequence['_rate_'])
    iter = str(settings.sequence['_iter_'])

    # header definitions
    header_0 = sg.Text('PCI-6733', size=(10, 1), justification='center', font=("Helvetica", 15), relief=sg.RELIEF_RIDGE)
    spinner_name = sg.Text('Number of time points')
    spinner = sg.Spin([sz for sz in range(1, 100)], size=(5,1), initial_value= spin , change_submits=True, key='_spin_')
    apply = sg.Button('Apply')
    run_sequence = sg.Button('Run Sequence')
    sampling_rate_name = sg.Text('Sampling rate/Clock (Hz)')
    sampling_rate = sg.InputText(default_text= rate , size=(6, 1), change_submits=True, key='_rate_')
    iteration_name = sg.Text('Iterations')
    iteration = sg.InputText(default_text= iter , size=(6, 1), change_submits=True, key='_iter_')
    send_data = sg.Button('Send data')
    stop = sg.Button('STOP')

    # creates menu
    menu = sg.Menu(menu_def, tearoff=True)

    # shows the image of the output
    # for now it is temporarily set to be the JQI image
    graph = sg.Image(filename = 'jqi_1.png', key='_image_', visible=True)

    # generate_time_line has to read the exp_sequence to know
    # what elements to specify on the new window
    layout = [[menu],
              [header_0, spinner_name, spinner, sampling_rate_name , sampling_rate, iteration_name, iteration, apply, send_data, run_sequence, stop],
              [sg.Frame(layout = generate_time_line(time_points),title='Control Board',title_color='Black', relief=sg.RELIEF_SUNKEN)],
              [graph]]

    return layout
