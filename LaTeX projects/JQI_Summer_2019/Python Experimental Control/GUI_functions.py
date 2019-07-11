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
    # input includes: Mode, Delay, Switch_state x 8, Step, AH, Trap, Repump, aom, vco, vca

    time = str(int_time)
    time_point = []
    time_point.append(sg.Spin(values=('Exp. Ramp', 'Sin. Ramp', 'Lin. Ramp', '-Select-'), initial_value=row_specs[0], size=(10, 1), change_submits=True, key='_mode_'+ time + '_') )
    # time_point.append(sg.InputCombo(('-Select-', 'Ramp','Continue', 'Loop','EndLoop','Halt'), size=(8, 1), change_submits=True, key='_mode_'+ time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[1], size=(9, 1), change_submits=True, key='_delay_' + time + '_'))

    # number of digital lines
    for i in range(8):
        time_point.append(sg.Checkbox('', size=(1,1), default=bool(row_specs[2][i]), change_submits=True, key='_switch_' + time + '_' +  str(i) +'_'))

    time_point.append(sg.InputText(default_text=row_specs[3], size=(6, 1), change_submits=True, key='_step_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[4], size=(6, 1), change_submits=True, key='_AH_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[5], size=(6, 1), change_submits=True, key='_Trap_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[6], size=(6, 1), change_submits=True, key='_Repump_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[7], size=(6, 1), change_submits=True, key='_aom_760_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[8], size=(6, 1), change_submits=True, key='_vco_760_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[9], size=(6, 1), change_submits=True, key='_vca_' + time + '_'))

    time_point.append(sg.Button('Insert', key='_insert_' + time + '_'))
    time_point.append(sg.Button('Delete', key='_delete_' + time + '_'))

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
    vca_head  = sg.Text('vca', size=(4, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    blank_head  = sg.Text(' ', size=(42, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    header_list = [header_mode, delay_head, blank_head , step_head, AH_head, Trap_head, Repump_head, aom_760_head, vco_760_head, vca_head]
    points = []
    points.append(header_list)

    for i in range(len(settings.instructions)):
        row_specs = settings.instructions[i]
        points.append(generate_time_point(i, row_specs))
        # points.append(generate_time_point(i))
    return points



# def generate_analog_scan():
#     # analog scan mode selections
#     scan_event_name_a = sg.Text('Time point:')
#     scan_event_a = sg.InputText(default_text='0' , size=(6, 1), change_submits=True, key='_scan_ev_a_')
#     scan_channel_name = sg.Text('Scanning channel:')
#     scan_channel = sg.InputText(default_text='0' , size=(6, 1), change_submits=True, key='_scan_ch_a_')
#     scan_start_name_a = sg.Text('Start (V):')
#     scan_start_a = sg.InputText(default_text='0' , size=(6, 1), change_submits=True, key='_scan_volt_start_a_')
#     scan_end_name_a = sg.Text('End (V):')
#     scan_end_a = sg.InputText(default_text='10' , size=(6, 1), change_submits=True, key='_scan_volt_end_a_')
#
#     scan_delay_start_name_a = sg.Text('Delay start (s):')
#     scan_delay_start_a = sg.InputText(default_text='0' , size=(6, 1), change_submits=True, key='_scan_delay_start_a_')
#     scan_delay_end_name_a =sg.Text('Delay end (s):')
#     scan_delay_end_a = sg.InputText(default_text='0' , size=(6, 1), change_submits=True, key='_scan_delay_end_a_')
#
#     analog_scan = [scan_event_name_a, scan_event_a, scan_channel_name, scan_channel,
#                     scan_delay_start_name_a, scan_delay_start_a, scan_delay_end_name_a, scan_delay_end_a,
#                     scan_start_name_a, scan_start_a, scan_end_name_a, scan_end_a]
#
#
#     return analog_scan
#
#
#
# def generate_digital_scan():
#     # digital scan mode selections
#     scan_event_name_d = sg.Text('Time point:')
#     scan_event_d = sg.InputText(default_text='0' , size=(6, 1), change_submits=True, key='_scan_ev_d_')
#     scan_line_name = sg.Text('Scanning channel:')
#     scan_line = sg.InputText(default_text='0' , size=(6, 1), change_submits=True, key='_scan_li_d_')
#     scan_delay_start_name_d = sg.Text('Delay start (s):')
#     scan_delay_start_d = sg.InputText(default_text='0' , size=(6, 1), change_submits=True, key='_scan_delay_start_d_')
#     scan_delay_end_name_d =sg.Text('Delay end (s):')
#     scan_delay_end_d = sg.InputText(default_text='0' , size=(6, 1), change_submits=True, key='_scan_delay_end_d_')
#
#     digital_scan = [scan_event_name_d, scan_event_d, scan_line_name, scan_line, scan_delay_start_name_d,
#                             scan_delay_start_d, scan_delay_end_name_d, scan_delay_end_d]
#
#
#     return digital_scan
#
#
# def generate_scan_mode():
#     # scan mode activator
#     scan_mode_name = sg.Text('Scan mode:')
#     scan_mode_state = sg.Spin(values=('False', 'True'), initial_value='False', size=(6, 1), change_submits=True, key='_scan_mode_')
#
#     scan_mode = [scan_mode_name, scan_mode_state]
#
#     return scan_mode


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
    scan_state = str(settings.sequence['_scan_mode_'])
    scan_event_analog = str(settings.sequence['_scan_ev_a_'])
    scan_channel_analog = str(settings.sequence['_scan_ch_a_'])
    scan_delay_start_analog = str(settings.sequence['_scan_delay_start_a_'])
    scan_delay_end_analog = str(settings.sequence['_scan_delay_end_a_'])
    scan_volt_start_analog = str(settings.sequence['_scan_volt_start_a_'])
    scan_volt_end_analog = str(settings.sequence['_scan_volt_end_a_'])
    scan_event_digital = str(settings.sequence['_scan_ev_d_'])
    scan_line_digital = str(settings.sequence['_scan_li_d_'])
    scan_delay_start_digital = str(settings.sequence['_scan_delay_start_d_'])
    scan_delay_end_digital = str(settings.sequence['_scan_delay_end_d_'])


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
    exit = sg.Button('EXIT')

    # creates menu
    menu = sg.Menu(menu_def, tearoff=True)

    # shows the image of the output
    # for now it is temporarily set to be the JQI image
    # graph = sg.Image(filename = 'jqi_2.png', key='_image_', visible=True)


    # analog scan mode selections
    scan_event_name_a = sg.Text('Time point:')
    scan_event_a = sg.InputText(default_text= scan_event_analog , size=(6, 1), change_submits=True, key='_scan_ev_a_')
    scan_channel_name = sg.Text('Scanning channel:')
    scan_channel = sg.InputText(default_text=scan_channel_analog , size=(6, 1), change_submits=True, key='_scan_ch_a_')
    scan_start_name_a = sg.Text('Start (V):')
    scan_start_a = sg.InputText(default_text=scan_volt_start_analog , size=(6, 1), change_submits=True, key='_scan_volt_start_a_')
    scan_end_name_a = sg.Text('End (V):')
    scan_end_a = sg.InputText(default_text=scan_volt_end_analog , size=(6, 1), change_submits=True, key='_scan_volt_end_a_')

    scan_delay_start_name_a = sg.Text('Delay start (s):')
    scan_delay_start_a = sg.InputText(default_text= scan_delay_start_analog , size=(6, 1), change_submits=True, key='_scan_delay_start_a_')
    scan_delay_end_name_a =sg.Text('Delay end (s):')
    scan_delay_end_a = sg.InputText(default_text= scan_delay_end_analog , size=(6, 1), change_submits=True, key='_scan_delay_end_a_')

    analog_scan = [scan_event_name_a, scan_event_a, scan_channel_name, scan_channel,
                    scan_delay_start_name_a, scan_delay_start_a, scan_delay_end_name_a, scan_delay_end_a,
                    scan_start_name_a, scan_start_a, scan_end_name_a, scan_end_a]


    # digital scan mode selections
    scan_event_name_d = sg.Text('Time point:')
    scan_event_d = sg.InputText(default_text= scan_event_digital , size=(6, 1), change_submits=True, key='_scan_ev_d_')
    scan_line_name = sg.Text('Scanning channel:')
    scan_line = sg.InputText(default_text= scan_line_digital , size=(6, 1), change_submits=True, key='_scan_li_d_')
    scan_delay_start_name_d = sg.Text('Delay start (s):')
    scan_delay_start_d = sg.InputText(default_text= scan_delay_start_digital , size=(6, 1), change_submits=True, key='_scan_delay_start_d_')
    scan_delay_end_name_d =sg.Text('Delay end (s):')
    scan_delay_end_d = sg.InputText(default_text= scan_delay_end_digital , size=(6, 1), change_submits=True, key='_scan_delay_end_d_')

    digital_scan = [scan_event_name_d, scan_event_d, scan_line_name, scan_line, scan_delay_start_name_d,
                            scan_delay_start_d, scan_delay_end_name_d, scan_delay_end_d]



    # scan mode activator
    scan_mode_name = sg.Text('Scan mode:')
    scan_mode_state = sg.Spin(values=('False', 'True'), initial_value=scan_state, size=(6, 1), change_submits=True, key='_scan_mode_')

    scan_mode = [scan_mode_name, scan_mode_state]


    # generate_time_line has to read the exp_sequence to know
    # what elements to specify on the new window
    layout = [[menu],
              [header_0, spinner_name, spinner, sampling_rate_name , sampling_rate, iteration_name, iteration, apply, send_data, run_sequence, stop, exit],
              [sg.Frame(layout = generate_time_line(time_points), title='Control Board',title_color='Black', relief=sg.RELIEF_SUNKEN)],
              scan_mode,
              [sg.Frame(layout = [analog_scan], title='Analog scan settings', title_color='Black' , relief=sg.RELIEF_SUNKEN)],
              [sg.Frame(layout = [digital_scan], title='Digital scan settings', title_color='Black' , relief=sg.RELIEF_SUNKEN)]
              ]


    return layout
