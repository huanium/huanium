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
    for i in range(settings.digital_channels):
        time_point.append(sg.Checkbox('', size=(1,1), default=bool(row_specs[2][i]), change_submits=True, key='_switch_' + time + '_' +  str(i) +'_'))

    # time_point.append(sg.InputText(default_text=row_specs[3], size=(6, 1), change_submits=True, key='_step_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[3], size=(7, 1), change_submits=True, key='_AH_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[4], size=(7, 1), change_submits=True, key='_Trap_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[5], size=(7, 1), change_submits=True, key='_Repump_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[6], size=(7, 1), change_submits=True, key='_aom_760_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[7], size=(7, 1), change_submits=True, key='_vco_760_' + time + '_'))
    time_point.append(sg.InputText(default_text=row_specs[8], size=(7, 1), change_submits=True, key='_vca_' + time + '_'))

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
    # step_head  = sg.Text('Step', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    AH_head  = sg.Text('AH', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    Repump_head  = sg.Text('Repump', size=(7, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    Trap_head  = sg.Text('Trap', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    aom_760_head  = sg.Text('760 aom', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    vco_760_head  = sg.Text('760 vco', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    vca_head  = sg.Text('vca', size=(6, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    blank_head  = sg.Text('line0   line1    line2    line3     line4    line5    line6    line7',
                    size=(43, 1),  justification='center', font=("Helvetica", 10), relief=sg.RELIEF_RIDGE)
    header_list = [header_mode, delay_head, blank_head, AH_head, Trap_head, Repump_head, aom_760_head, vco_760_head, vca_head]
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
    scan_mech = str(settings.sequence['_scan_mech_'])
    scan_delay_a_val = bool(settings.sequence['_scan_delay_a_'])
    scan_volt_a_val = bool(settings.sequence['_scan_volt_a_'])
    step_delay_a_val = str(settings.sequence['_step_delay_a_'])
    step_volt_a_val = str(settings.sequence['_step_volt_a_'])
    step_delay_d_val = str(settings.sequence['_step_delay_d_'])

    # header definitions
    header_0 = sg.Text('PCI-6733', size=(10, 1), justification='center', font=("Helvetica", 15), relief=sg.RELIEF_RIDGE)
    spinner_name = sg.Text('Number of time points')
    spinner = sg.Spin([sz for sz in range(1, 100)], size=(5,1), initial_value= spin , change_submits=True, key='_spin_')
    apply = sg.Button('Apply')
    run_sequence = sg.Button('Run Sequence')
    sampling_rate_name = sg.Text('Sampling rate/Clock (Hz)')
    sampling_rate = sg.InputText(default_text= rate , size=(5, 1), change_submits=True, key='_rate_')
    iteration_name = sg.Text('Iterations')
    iteration = sg.InputText(default_text= iter , size=(5, 1), change_submits=True, key='_iter_')
    send_data = sg.Button('Plot data')
    stop = sg.Button('STOP')
    exit = sg.Button('EXIT')

    # creates menu
    menu = sg.Menu(menu_def, tearoff=True)

    # shows the image of the output
    # for now it is temporarily set to be the JQI image
    graph = sg.Image(filename = 'jqi-logo.png', key='_image_', visible=True)

    # or altenatively just some blank space
    # graph = sg.Canvas(size=(200, 200), key='_canvas_')

    # analog scan mode selections
    scan_event_name_a = sg.Text('Time point:')
    scan_event_a = sg.InputText(default_text= scan_event_analog , size=(2, 1), change_submits=True, key='_scan_ev_a_')
    scan_channel_name = sg.Text('Channel:')
    scan_channel = sg.Spin(values=('_AH_', '_Trap_', '_Repump_', '_aom_760_', '_vco_760_', '_vca_'), initial_value=scan_channel_analog, size=(10, 1), change_submits=True, key='_scan_ch_a_')
    scan_start_name_a = sg.Text('Start (V):')
    scan_start_a = sg.InputText(default_text=scan_volt_start_analog , size=(6, 1), change_submits=True, key='_scan_volt_start_a_')
    scan_end_name_a = sg.Text('End (V):')
    scan_end_a = sg.InputText(default_text=scan_volt_end_analog , size=(6, 1), change_submits=True, key='_scan_volt_end_a_')
    scan_volt_name_a = sg.Text('Voltage')
    scan_volt_a = sg.Checkbox('', size=(1,1), default=scan_volt_a_val, change_submits=True, key='_scan_volt_a_')
    step_volt_name_a = sg.Text('Step (V)')
    step_volt_a = sg.InputText(default_text=step_volt_a_val , size=(8, 1), change_submits=True, key='_step_volt_a_')

    scan_delay_start_name_a = sg.Text('Start (s):')
    scan_delay_start_a = sg.InputText(default_text= scan_delay_start_analog , size=(6, 1), change_submits=True, key='_scan_delay_start_a_')
    scan_delay_end_name_a =sg.Text('End (s): ')
    scan_delay_end_a = sg.InputText(default_text= scan_delay_end_analog , size=(6, 1), change_submits=True, key='_scan_delay_end_a_')
    scan_delay_name_a = sg.Text('Delay   ')
    scan_delay_a = sg.Checkbox('', size=(1,1), default=scan_delay_a_val, change_submits=True, key='_scan_delay_a_')
    step_delay_name_a = sg.Text('Step (s)')
    step_delay_a = sg.InputText(default_text=step_delay_a_val , size=(8, 1), change_submits=True, key='_step_delay_a_')

    analog_scan = [[scan_event_name_a, scan_event_a, scan_channel_name, scan_channel],
                    [scan_delay_name_a, scan_delay_a, scan_delay_start_name_a, scan_delay_start_a, scan_delay_end_name_a, scan_delay_end_a, step_delay_name_a, step_delay_a], # delay scan
                    [scan_volt_name_a, scan_volt_a, scan_start_name_a, scan_start_a, scan_end_name_a, scan_end_a, step_volt_name_a, step_volt_a]] # voltage scan


    # digital scan mode selections
    scan_event_name_d = sg.Text('Time point:')
    scan_event_d = sg.InputText(default_text= scan_event_digital , size=(2, 1), change_submits=True, key='_scan_ev_d_')
    scan_line_name = sg.Text('Channel:')
    scan_line = sg.Spin(values=('0','1','2','3','4','5','6','7'), initial_value=scan_line_digital, size=(8, 1), change_submits=True, key='_scan_li_d_')
    scan_delay_start_name_d = sg.Text('Start (s):')
    scan_delay_start_d = sg.InputText(default_text= scan_delay_start_digital , size=(6, 1), change_submits=True, key='_scan_delay_start_d_')
    scan_delay_end_name_d =sg.Text('End (s):')
    scan_delay_end_d = sg.InputText(default_text= scan_delay_end_digital , size=(6, 1), change_submits=True, key='_scan_delay_end_d_')
    step_delay_name_d = sg.Text('Step (s)')
    step_delay_d = sg.InputText(default_text=step_delay_d_val , size=(8, 1), change_submits=True, key='_step_delay_d_')
    scan_delay_d_name = sg.Text('Delay scan:      ')

    digital_scan = [[scan_event_name_d, scan_event_d, scan_line_name, scan_line],
                        [scan_delay_d_name, scan_delay_start_name_d, scan_delay_start_d, scan_delay_end_name_d, scan_delay_end_d, step_delay_name_d, step_delay_d]]



    # scan mode activator
    scan_mode_name = sg.Text('Scan mode:')
    scan_mode_state = sg.Spin(values=('No scan', 'Analog', 'Digital'), initial_value=scan_state, size=(8, 1), change_submits=True, key='_scan_mode_')
    scan_mech_name = sg.Text('Scan mechanism:')
    scan_mode_mech = sg.Spin(values=('Single-array Multi-sweep', 'Multi-array Single-sweep'), initial_value=scan_mech, size=(30, 1), change_submits=True, key='_scan_mech_')
    scan_button = sg.Button('SCAN')
    apply_scan = sg.Button('Apply settings')

    scan_mode = [scan_mode_name, scan_mode_state, scan_mech_name, scan_mode_mech, apply_scan, scan_button]


    # generate_time_line has to read the exp_sequence to know
    # what elements to specify on the new window
    layout = [[menu],
            [header_0, spinner_name, spinner, sampling_rate_name , sampling_rate, iteration_name, iteration, apply, send_data, run_sequence, stop, exit],
            [sg.Frame(layout = analog_scan, title='Analog scan settings', title_color='Black' , relief=sg.RELIEF_SUNKEN),
            sg.Frame(layout = digital_scan, title='Digital scan settings', title_color='Black' , relief=sg.RELIEF_SUNKEN)],
            scan_mode,
              [sg.Frame(layout = generate_time_line(time_points), title='Control Board',title_color='Black', relief=sg.RELIEF_SUNKEN)],
              [graph]
              ]


    return layout
