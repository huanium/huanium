import PySimpleGUI as sg
import GUI_functions as GUI
import settings
import numpy as np
import csv
import pickle
import PCI_control as PCI


def print_sequence(sequence):
    # this function prints sequence
    for key , val in sorted(sequence.items()):
        print(str(key)+"\t", str(val))




def save_sequence(values):
    # saves the sequence, by assigning the values dictionary
    # to the sequence variable in settings.py
    settings.sequence = settings.values.copy()





def record_sequence(values):
    # this function writes the experimental sequence to a csv file
    # write a csv version of the exp_sequence for inspection
    with open('exp_sequence.csv', 'w') as f:  # Just use 'w' mode in 3.x
        w = csv.writer(f, dialect = 'excel')
        for k,v in values.items():
            w.writerow([k,v])





def read_sequence():
    # this function reads an experimental sequence
    # and gives to py to create new window
    # with old specifications from last time
    # input: none. It just reads the exp_sequence.csv in the folder
    # output: a dictionary that will be fed to window creation
    sequence = {}
    with open('exp_sequence.csv') as fp:

        for line in fp:
            line = line.rstrip("\n")
            pair = line.split(',')
            if pair != ['']:
                sequence.update({pair[0]: pair[1]})

    settings.sequence = sequence.copy() # assigns this new sequence to settings
    return settings.sequence





def update_sequence():
    # this function updates the experimental specifications
    # changes as applied throughout
    save_sequence(settings.values)
    record_sequence(settings.values)
    read_sequence()




def sequence_to_instructions_spin():

    # this function takes the sequence, which is a dictionary,
    # and turns it into instructions for the next start-up
    # essentially this saves the exp specs
    # input: N/A
    # output: settings.instructions which is a global var

    read_sequence()
    settings.instructions  = []
    spin = int(settings.sequence['_spin_'])
    iter = str(settings.sequence['_iter_'])
    num_rows = int((len(settings.sequence) - 16)/17)
    # print('Spin is:', spin)
    # print('Num_rows is:', num_rows )

    if spin <= num_rows: # new number of rows is less than before

        for row in range(spin):
            row_switch = ['']*8

            mode = settings.sequence[str('_mode_'+str(row)+'_')]
            delay = settings.sequence[str('_delay_'+str(row)+'_')]

            for col in range(8):
                row_switch[col] = settings.sequence[str('_switch_' + str(row) + '_' + str(col) + '_' )]

            step = settings.sequence[str('_step_'+str(row)+'_')]
            ah = settings.sequence[str('_AH_'+str(row)+'_')]
            trap = settings.sequence[str('_Trap_'+str(row)+'_')]
            repump = settings.sequence[str('_Repump_'+str(row)+'_')]
            aom = settings.sequence[str('_aom_760_'+str(row)+'_')]
            vco = settings.sequence[str('_vco_760_'+str(row)+'_')]
            vca = settings.sequence[str('_vca_'+str(row)+'_')]

            row_specs = [mode, delay, row_switch, step, ah, trap, repump, aom, vco, vca]
            settings.instructions.append(row_specs)

        # print(settings.instructions)
        return settings.instructions

    else: # do the same thing up to the old points, then set new rows to last row
        for row in range(num_rows):
            row_switch = ['']*8

            mode = settings.sequence[str('_mode_'+str(row)+'_')]
            delay = settings.sequence[str('_delay_'+str(row)+'_')]

            for col in range(8):
                row_switch[col] = settings.sequence[str('_switch_' + str(row) + '_' + str(col) + '_' )]

            step = settings.sequence[str('_step_'+str(row)+'_')]
            ah = settings.sequence[str('_AH_'+str(row)+'_')]
            trap = settings.sequence[str('_Trap_'+str(row)+'_')]
            repump = settings.sequence[str('_Repump_'+str(row)+'_')]
            aom = settings.sequence[str('_aom_760_'+str(row)+'_')]
            vco = settings.sequence[str('_vco_760_'+str(row)+'_')]
            vca = settings.sequence[str('_vca_'+str(row)+'_')]

            row_specs = [mode, delay, row_switch, step, ah, trap, repump, aom, vco, vca]
            settings.instructions.append(row_specs)

        for new_row in range(spin - num_rows):
            new_row_specs = settings.instructions[-1] # just copying the last row
            settings.instructions.append(new_row_specs)
        # print(settings.instructions)
        return settings.instructions












def insert(location):
    # this function inserts a time point into the program
    # - updates the values (dictionary)
    # - updates the .csv file by changing the number of spinners
    # - copying the row right before it and add this row
    # - then shifting everything after by one time point.
    # - then restarting the window.
    # input: the location of insertion

    read_sequence()
    settings.values['_spin_'] = str(int(settings.values['_spin_']) + 1) # spinners increase by 1.
    spin = int(settings.values['_spin_'])
    iter = str(settings.values['_iter_'])
    num_rows = int((len(settings.values) - 16)/17)

    # adding the last row
    settings.values['_mode_' + str(spin) + '_'] = '-Select-'
    settings.values['_delay_' + str(spin) + '_'] = '0.0005'
    settings.values['_switch_' + str(spin) + '_0_'] = False
    settings.values['_switch_' + str(spin) + '_1_'] = False
    settings.values['_switch_' + str(spin) + '_2_'] = False
    settings.values['_switch_' + str(spin) + '_3_'] = False
    settings.values['_switch_' + str(spin) + '_4_'] = False
    settings.values['_switch_' + str(spin) + '_5_'] = False
    settings.values['_switch_' + str(spin) + '_6_'] = False
    settings.values['_switch_' + str(spin) + '_7_'] = False
    settings.values['_step_' + str(spin) + '_'] = '0'
    settings.values['_AH_' + str(spin) + '_'] = '0'
    settings.values['_Trap_' + str(spin) + '_'] = '0'
    settings.values['_Repump_' + str(spin) + '_'] = '0'
    settings.values['_aom_760_' + str(spin) + '_'] = '0'
    settings.values['_vco_760_' + str(spin) + '_'] = '0'
    settings.values['_vca_' + str(spin) + '_'] = '0'

    # now shift everything after location to +1 time point
    #print('Location: ', location)
    #print('Num points:', int((len(settings.values)-16)/17))
    for l in range(int((len(settings.values)-16)/17) - 2, location -1, -1 ): # travels backwards
        settings.values['_mode_'   + str(l+1) + '_']    = settings.values['_mode_'   + str(l) + '_']
        settings.values['_delay_'  + str(l+1) + '_']    = settings.values['_delay_'  + str(l) + '_']
        settings.values['_switch_' + str(l+1) + '_0_']  = settings.values['_switch_' + str(l) + '_0_']
        settings.values['_switch_' + str(l+1) + '_1_']  = settings.values['_switch_' + str(l) + '_1_']
        settings.values['_switch_' + str(l+1) + '_2_']  = settings.values['_switch_' + str(l) + '_2_']
        settings.values['_switch_' + str(l+1) + '_3_']  = settings.values['_switch_' + str(l) + '_3_']
        settings.values['_switch_' + str(l+1) + '_4_']  = settings.values['_switch_' + str(l) + '_4_']
        settings.values['_switch_' + str(l+1) + '_5_']  = settings.values['_switch_' + str(l) + '_5_']
        settings.values['_switch_' + str(l+1) + '_6_']  = settings.values['_switch_' + str(l) + '_6_']
        settings.values['_switch_' + str(l+1) + '_7_']  = settings.values['_switch_' + str(l) + '_7_']
        settings.values['_step_'   + str(l+1) + '_']    = settings.values['_step_'   + str(l) + '_']
        settings.values['_AH_'     + str(l+1) + '_']    = settings.values['_AH_'     + str(l) + '_']
        settings.values['_Trap_'   + str(l+1) + '_']    = settings.values['_Trap_'   + str(l) + '_']
        settings.values['_Repump_' + str(l+1) + '_']    = settings.values['_Repump_' + str(l) + '_']
        settings.values['_aom_760_'+ str(l+1) + '_']    = settings.values['_aom_760_'+ str(l) + '_']
        settings.values['_vco_760_'+ str(l+1) + '_']    = settings.values['_vco_760_'+ str(l) + '_']
        settings.values['_vca_'+ str(l+1) + '_']    = settings.values['_vca_'+ str(l) + '_']

    return settings.values


def sequence_to_instructions_insert_or_delete():
    # this turns the new sequence from insertion to instructions
    read_sequence()
    settings.instructions  = []
    spin = int(settings.sequence['_spin_'])
    iter = str(settings.sequence['_iter_'])
    num_rows = int((len(settings.sequence) - 16)/17)

    for row in range(spin):
        row_switch = ['']*8

        mode = settings.sequence[str('_mode_'+str(row)+'_')]
        delay = settings.sequence[str('_delay_'+str(row)+'_')]

        for col in range(8):
            row_switch[col] = settings.sequence[str('_switch_' + str(row) + '_' + str(col) + '_' )]

        step = settings.sequence[str('_step_'+str(row)+'_')]
        ah = settings.sequence[str('_AH_'+str(row)+'_')]
        trap = settings.sequence[str('_Trap_'+str(row)+'_')]
        repump = settings.sequence[str('_Repump_'+str(row)+'_')]
        aom = settings.sequence[str('_aom_760_'+str(row)+'_')]
        vco = settings.sequence[str('_vco_760_'+str(row)+'_')]
        vca = settings.sequence[str('_vca_'+str(row)+'_')]

        row_specs = [mode, delay, row_switch, step, ah, trap, repump, aom, vco, vca]
        settings.instructions.append(row_specs)

    return settings.instructions



def delete(location):
    # this function deletes a time point from the program
    # - updates the values (dictionary)
    # - updates the .csv file by changing the number of spinners
    # - copying the row right before it and add this row
    # - then shifting everything after by one time point.
    # - then restarting the window.
    # input: the location of insertion

    read_sequence()
    settings.values['_spin_'] = str(int(settings.values['_spin_']) - 1) # spinners increase by 1.
    spin = int(settings.values['_spin_'])
    iter = str(settings.values['_iter_'])
    num_rows = int((len(settings.values) - 16)/17)

    # first shift everything after location to -1 time point
    # print('Location: ', location)
    # print('Num points:', int((len(settings.values)-16)/17))
    for l in range(location, int((len(settings.values)-16)/17)-1): # travels forward
        settings.values['_mode_'   + str(l) + '_']    = settings.values['_mode_'   + str(l+1) + '_']
        settings.values['_delay_'  + str(l) + '_']    = settings.values['_delay_'  + str(l+1) + '_']
        settings.values['_switch_' + str(l) + '_0_']  = settings.values['_switch_' + str(l+1) + '_0_']
        settings.values['_switch_' + str(l) + '_1_']  = settings.values['_switch_' + str(l+1) + '_1_']
        settings.values['_switch_' + str(l) + '_2_']  = settings.values['_switch_' + str(l+1) + '_2_']
        settings.values['_switch_' + str(l) + '_3_']  = settings.values['_switch_' + str(l+1) + '_3_']
        settings.values['_switch_' + str(l) + '_4_']  = settings.values['_switch_' + str(l+1) + '_4_']
        settings.values['_switch_' + str(l) + '_5_']  = settings.values['_switch_' + str(l+1) + '_5_']
        settings.values['_switch_' + str(l) + '_6_']  = settings.values['_switch_' + str(l+1) + '_6_']
        settings.values['_switch_' + str(l) + '_7_']  = settings.values['_switch_' + str(l+1) + '_7_']
        settings.values['_step_'   + str(l) + '_']    = settings.values['_step_'   + str(l+1) + '_']
        settings.values['_AH_'     + str(l) + '_']    = settings.values['_AH_'     + str(l+1) + '_']
        settings.values['_Trap_'   + str(l) + '_']    = settings.values['_Trap_'   + str(l+1) + '_']
        settings.values['_Repump_' + str(l) + '_']    = settings.values['_Repump_' + str(l+1) + '_']
        settings.values['_aom_760_'+ str(l) + '_']    = settings.values['_aom_760_'+ str(l+1) + '_']
        settings.values['_vco_760_'+ str(l) + '_']    = settings.values['_vco_760_'+ str(l+1) + '_']
        settings.values['_vca_'+ str(l+1) + '_']    = settings.values['_vca_'+ str(l+1) + '_']

    # next removes the last row
    del settings.values['_mode_' + str(spin) + '_']
    del settings.values['_delay_' + str(spin) + '_']
    del settings.values['_switch_' + str(spin) + '_0_']
    del settings.values['_switch_' + str(spin) + '_1_']
    del settings.values['_switch_' + str(spin) + '_2_']
    del settings.values['_switch_' + str(spin) + '_3_']
    del settings.values['_switch_' + str(spin) + '_4_']
    del settings.values['_switch_' + str(spin) + '_5_']
    del settings.values['_switch_' + str(spin) + '_6_']
    del settings.values['_switch_' + str(spin) + '_7_']
    del settings.values['_step_' + str(spin) + '_']
    del settings.values['_AH_' + str(spin) + '_']
    del settings.values['_Trap_' + str(spin) + '_']
    del settings.values['_Repump_' + str(spin) + '_']
    del settings.values['_aom_760_' + str(spin) + '_']
    del settings.values['_vco_760_' + str(spin) + '_']
    del settings.values['_vca_' + str(spin) + '_']

    return settings.values





def sequence_to_instructions_delete():
    # this turns the new sequence from deletion to instructions
    read_sequence()
    settings.instructions  = []
    spin = int(settings.sequence['_spin_'])
    iter = str(settings.sequence['_iter_'])
    num_rows = int((len(settings.sequence) - 16)/17)

    for row in range(spin):
        row_switch = ['']*8

        mode = settings.sequence[str('_mode_'+str(row)+'_')]
        delay = settings.sequence[str('_delay_'+str(row)+'_')]

        for col in range(8):
            row_switch[col] = settings.sequence[str('_switch_' + str(row) + '_' + str(col) + '_' )]

        step = settings.sequence[str('_step_'+str(row)+'_')]
        ah = settings.sequence[str('_AH_'+str(row)+'_')]
        trap = settings.sequence[str('_Trap_'+str(row)+'_')]
        repump = settings.sequence[str('_Repump_'+str(row)+'_')]
        aom = settings.sequence[str('_aom_760_'+str(row)+'_')]
        vco = settings.sequence[str('_vco_760_'+str(row)+'_')]
        vca = settings.sequence[str('_vca_'+str(row)+'_')]

        row_specs = [mode, delay, row_switch, step, ah, trap, repump, aom, vco, vca]
        settings.instructions.append(row_specs)

    return settings.instructions






def interpret(command):
    # this function translates the instructions on Board
    # into data to be sent to PCI
    rate = float(settings.sequence['_rate_'])
    spin = int(settings.sequence['_spin_'])
    iter = str(settings.sequence['_iter_'])

    num_events = int((len(settings.sequence)-16)/17)
    print('Number of events: ', num_events)

    # loop through the sequence
    for e in range(num_events):
        mode_e = str(settings.sequence['_mode_' + str(e) + '_'])

        if str(settings.sequence['_delay_' + str(e) + '_']) == '':
            duration_e = float(0.0)
        else:
            duration_e = float(settings.sequence['_delay_' + str(e) + '_'])

        if str(settings.sequence['_step_' + str(e) + '_']) == '':
            step_e = float(0.0)
        else:
            step_e = float(settings.sequence['_step_' + str(e) + '_'])

        if str(settings.sequence['_AH_' + str(e) + '_']) == '':
            AH_e = float(0.0)
        else:
            AH_e = float(settings.sequence['_AH_' + str(e) + '_'])

        if str(settings.sequence['_Trap_' + str(e) + '_']) == '':
            Trap_e = float(0.0)
        else:
            Trap_e = float(settings.sequence['_Trap_' + str(e) + '_'])

        if str(settings.sequence['_Repump_' + str(e) + '_']) == '':
            Repump_e = float(0.0)
        else:
            Repump_e = float(settings.sequence['_Repump_' + str(e) + '_'])

        if str(settings.sequence['_aom_760_' + str(e) + '_']) == '':
            aom_760_e = float(0.0)
        else:
            aom_760_e = float(settings.sequence['_aom_760_' + str(e) + '_'])

        if str(settings.sequence['_vco_760_' + str(e) + '_']) == '':
            vco_760_e = float(0.0)
        else:
            vco_760_e = float(settings.sequence['_vco_760_' + str(e) + '_'])

        if str(settings.sequence['_vca_' + str(e) + '_']) == '':
            vca_e = float(0.0)
        else:
            vca_e = float(settings.sequence['_vca_' + str(e) + '_'])

        # channel 1
        settings.AH.append([mode_e, duration_e, step_e, AH_e])
        # channel 2
        settings.Trap.append([mode_e, duration_e, step_e, Trap_e])
        # channel 3
        settings.Repump.append([mode_e, duration_e, step_e, Repump_e])
        # channel 4
        settings.aom.append([mode_e, duration_e, step_e, aom_760_e])
        # channel 5
        settings.vco.append([mode_e, duration_e, step_e, vco_760_e])
        # channel 6
        settings.vca.append([mode_e, duration_e, step_e, vca_e])


    # DIGITAL
    # the states of the 8 lines at each event is associated with an int8 number
    # with this number and duration --> we can get the correct digital output
    # much simpler than analog

    for event in range(num_events):
        state_number = 0
        for line in range(8): # loop through each line
            switch_line = settings.sequence[str('_switch_' + str(event) + '_' + str(line) + '_' )]
            #print('Switch_line: ', switch_line)
            if switch_line == 'True':
                state_number = state_number + 2**line
            else:
                state_number = state_number
        # switch has the form [[state_number, delay]]
        settings.switch.append([state_number, float(settings.sequence['_delay_' + str(event) + '_'])])

    # print(settings.switch)

    if command == 'simulate':
        PCI.simulate(1, rate, PCI.to_wave(settings.AH, rate),
                              PCI.to_wave(settings.Trap, rate),
                              PCI.to_wave(settings.Repump, rate),
                              PCI.to_wave(settings.aom, rate),
                              PCI.to_wave(settings.vco, rate),
                              PCI.to_wave(settings.vca, rate)#,
                              #PCI.to_digit(settings.switch, rate)
                              )

    elif command == 'run':
        PCI.run(iter, rate, PCI.to_wave(settings.AH, rate),
                      PCI.to_wave(settings.Trap, rate),
                      PCI.to_wave(settings.Repump, rate),
                      PCI.to_wave(settings.aom, rate),
                      PCI.to_wave(settings.vco, rate),
                      PCI.to_wave(settings.vca, rate),
                      PCI.to_digit(settings.switch, rate)
                      )

    else:
        print('Invalid command')

    # reset waves to zeros
    settings.AH = settings.AH*0
    settings.Trap = settings.Trap*0
    settings.Repump = settings.Repump*0
    settings.aom = settings.aom*0
    settings.vco = settings.vco*0
    settings.vca = settings.vca*0
    settings.switch = []

    return








def make_window(initial_num_points):
    # this function make the main window with a certain layout
    # layout is defined in GUI_functions
    # obtain experimental specs from exp_sequence.txt
    # the sequence is a global var defined in settings.py
    sg.ChangeLookAndFeel('GreenTan')
    settings.new_time_points = int(settings.sequence['_spin_'])
    settings.old_time_points = int((len(settings.sequence) - 16)/17)
    settings.sequence = read_sequence()

    settings.window = sg.Window('Experimental Control - PCI-6733',
                   default_element_size=(80, 1),
                   grab_anywhere=False).Layout(GUI.layout_main(initial_num_points))

    # GUI.generate_graph(window)

    settings.inserted = False
    settings.deleted = False
    settings.ramped = False

    while True:
        # constantly updating for events/values
        settings.event, settings.values = settings.window.Read()
        if settings.event is None:
            break
        else:
            print(settings.event)
        # check for a new number of time points
        settings.new_time_points = int(settings.values['_spin_'])

        if settings.event == 'Exit':
            quit()

        if settings.event == 'About':
            sg.Popup('Experimental Control', 'Created by Huan Q Bui\n Summer 2019')

        # check for change in number of rows
        if settings.event == '_spin_':
            update_sequence()
            sequence_to_instructions_spin()
            break

        for location in range(settings.new_time_points):
            # check for insertion
            if settings.event == '_insert_' + str(location) + '_':
                update_sequence()
                insert(location)
                sequence_to_instructions_insert_or_delete()

                settings.inserted = True
                print(settings.inserted)
                update_sequence()
                settings.window.Close()
                return

                # check for deletion
            if settings.event == '_delete_' + str(location) + '_':
                update_sequence()
                delete(location)
                sequence_to_instructions_insert_or_delete()
                settings.deleted = True
                update_sequence()
                settings.window.Close()
                return


                # check for clicking the ramping option
            if settings.event == '_mode_' + str(location) + '_':
                settings.ramped = True
                update_sequence()
                settings.window.Close()
                return

        # save settings
        if settings.event == 'Apply':
            update_sequence()
            break

        # save settings + plot
        if settings.event == 'Send data':
            # turns instructions into waveform to be sent
            # when data is sent, program simulates the waveform
            update_sequence()
            interpret('simulate')
            settings.event = None

        if settings.event == 'Run Sequence':
            # when sequence is run, data is sent to PCI
            update_sequence()
            interpret('run')
            settings.event = None

        if settings.event == 'STOP':
            sg.Popup('?', 'No sequence is running!')

        if settings.event == 'EXIT':
            settings.window.Close()
            quit()

        del settings.values[0]

    update_sequence()
    settings.window.Close()


    return
