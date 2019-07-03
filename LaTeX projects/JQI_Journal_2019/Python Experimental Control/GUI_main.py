import PySimpleGUI as sg
import GUI_functions as GUI
import settings


def make_window(initial_num_points):

    sg.ChangeLookAndFeel('GreenTan')

    settings.new_time_points = initial_num_points
    settings.old_time_points = initial_num_points


    window = sg.Window('Experimental Control',
                   default_element_size=(80, 1),
                   grab_anywhere=False).Layout(GUI.layout_main(initial_num_points))


    while True:
        event, values = window.Read()

        if event is None or event == 'Exit':
            break

        del values[0]

        settings.new_time_points = int(values['_spin_'])

        if settings.new_time_points != settings.old_time_points:
            break

        for k , v in sorted(values.items()): # iterating freqa dictionary
            print(str(k)+"\t", str(v))
            


    window.Close()

#    sg.Popup('Experimental Procedure',
#        'The button clicked was "{}"'.format(event))



    return


