import numpy as np
import matplotlib.pyplot as plt
from scipy import signal


def power_convolve(n_times):

    #Phi = [complex(-1/16,  0),
    #       complex(2/8,  1/8),
    #       complex(5/8, -2/8),
    #       complex(2/8,  1/8),
    #       complex(-1/16,  0)]

    Phi = [complex(1/16,0),
           complex(0,1/3),
           complex(-1/4,0),
           complex(0,0),
           complex(3/8,0),
           complex(0,0),
           complex(-1/4,0),
           complex(0,1/3),
           complex(1/16,0)
           ]

    n = 1
    Phi_N = Phi.copy()
    while n < n_times: 
        Phi_new = np.convolve(Phi_N,  Phi)
        Phi_N = Phi_new.copy()
        n = n + 1

    print('Convolution power:', n_times)    
    print('Length of Phi_N:' , len(Phi_N))

    return Phi_N


def power(n_times):

    Phi_N = power_convolve(n_times)
    Real_Phi_N = [i.real for i in Phi_N]
    Imag_Phi_N = [i.imag for i in Phi_N]

    Abs_Phi_N = [abs(i) for i in Phi_N]
    x = [i - int(len(Phi_N)/2) -1 for i in range(len(Phi_N))]

    fig, ax = plt.subplots()
    ax.stem(x, Abs_Phi_N, markerfmt=' ',use_line_collection=True)
    #ax.stem(x, Real_Phi_N, markerfmt=' ',use_line_collection=True)
    #ax.stem(x, Imag_Phi_N, markerfmt=' ',use_line_collection=True)
    plt.show()








def power_convolve_2d(n_times):

    x = np.array([[0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, -16, 0, 0, 0, 0],
                  [0, 0, 0, 0,  64, 0, 0, 0, 0],
                  [1, 0, 20, 0, 326, 0, 20, 0, 1],
                  [0, 0, 0, 0,  64, 0, 0, 0, 0],
                  [0, 0, 0, 0, -16, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0]],
                 dtype='float')

    y = np.array([[0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0,-2, 0, 6, 0, -6, 0, 2,0],
                  [0,4, 0, 52, 0, 76, 0, -4,0],
                  [0,-2, 0, 6, 0, -6, 0, 2,0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0]],
                 dtype='float')

    Phi = (1/512)*(x+y)


    n = 1
    Phi_N = Phi.copy()
    while n < n_times: 
        Phi_new = signal.convolve2d(Phi_N, Phi, 'full')
        Phi_N = Phi_new.copy()
        n = n + 1

    print('Convolution power:', n_times)    
    print('Length of Phi_N:' , len(Phi_N))

    return Phi_N


def power_2d(n_times):

    Phi_N = power_convolve_2d(n_times)

    Abs_Phi_N = [abs(i) for i in Phi_N]
    x = [i - int(len(Phi_N)/2) -1 for i in range(len(Phi_N))]

    fig, ax = plt.subplots()
    ax.stem(x, Abs_Phi_N, markerfmt=' ',use_line_collection=True)
    plt.show()






    




if __name__ == '__main__':

    n_times = 50

    power(n_times)

    
    



    




        
