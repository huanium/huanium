import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from matplotlib import cm, colors
from mpl_toolkits.mplot3d.axes3d import Axes3D
import operator
import time



def convolve(n_times):
    #Phi = np.array([[0, 0, 0, 0, 0],
    #                [0, complex(0,-1)*(np.sqrt(3)-1), complex(2,-2), complex(0,-1)*(np.sqrt(3)-1), 0],
    #                [-2, 5+np.sqrt(3), 8, 5+np.sqrt(3), -2],
    #                [0, complex(0, 1)*(np.sqrt(3)-1), complex(2,+2), complex(0, 1)*(np.sqrt(3)-1), 0],
    #                [0, 0, 0, 0, 0]])


    Phi = np.array([[(1+complex(0,1))/4, 1/np.sqrt(2), -(1+complex(0,1))/4],
                    [0, 0, 0],
                    [(1+complex(0,1))/4, -1/np.sqrt(2), -(1+complex(0,1))/4]])

    #Phi = Phi/(22+2*np.sqrt(3))
    Phi = Phi/(np.sqrt(2+np.sqrt(2)))
    conv_power = np.copy(Phi)

    i=0
    while i < n_times:
        conv_power = signal.convolve2d(Phi, conv_power, 'full')
        i += 1

    return conv_power



def fast_convolve(n_times, support_bound):
    #Phi = np.array([[0, 0, 0, 0, 0],
    #                [0, complex(0,-1)*(np.sqrt(3)-1), complex(2,-2), complex(0,-1)*(np.sqrt(3)-1), 0],
    #                [-2, 5+np.sqrt(3), 8, 5+np.sqrt(3), -2],
    #                [0, complex(0, 1)*(np.sqrt(3)-1), complex(2,+2), complex(0, 1)*(np.sqrt(3)-1), 0],
    #                [0, 0, 0, 0, 0]])


    #Phi = np.array([[(1+complex(0,1))/4, 1/np.sqrt(2), -(1+complex(0,1))/4],
    #                [0, 0, 0],
    #                [(1+complex(0,1))/4, -1/np.sqrt(2), -(1+complex(0,1))/4]])

    #Phi = Phi/(22+2*np.sqrt(3))
    #Phi = Phi/(np.sqrt(2+np.sqrt(2)))

    
    Phi = np.zeros(shape=(9,9),dtype=np.complex_)

    Phi[ 0+9//2][ 0+9//2]  = complex(173/256,-7/32)
    Phi[ 1+9//2][ 0+9//2]  = complex(1/8,1/16)      
    Phi[-1+9//2][ 0+9//2]  = complex(1/8,1/16)      
    Phi[ 2+9//2][ 0+9//2]  = -1/32               
    Phi[-2+9//2][ 0+9//2]  = -1/32
    Phi[ 0+9//2][ 1+9//2]  = complex(7/64,1/16)
    Phi[ 0+9//2][-1+9//2]  = complex(7/64,1/16)
    Phi[ 0+9//2][ 2+9//2]  = -complex(7/128,1/64)
    Phi[ 0+9//2][-2+9//2]  = -complex(7/128,1/64)
    Phi[ 0+9//2][ 3+9//2]  = 1/64
    Phi[ 0+9//2][-3+9//2]  = 1/64
    Phi[ 0+9//2][ 4+9//2]  = -1/512
    Phi[ 0+9//2][-4+9//2]  = -1/512

    #Phi = Phi/np.sqrt(137)

    conv_power = np.copy(Phi)

    i=0
    while i < n_times:
        conv_power = signal.convolve2d(Phi, conv_power, 'full')
        dim_f = np.shape(conv_power)
        if dim_f[0] > support_bound or dim_f[0] > support_bound:
            conv_power = cropND(conv_power,(support_bound,support_bound))
        i += 1

    return conv_power


def cropND(img, bounding):
    if bounding[0] <= np.shape(img)[0] and bounding[1] <= np.shape(img)[1]:
        start = tuple(map(lambda a, da: a//2-da//2, img.shape, bounding))
        end = tuple(map(operator.add, start, bounding))
        slices = tuple(map(slice, start, end))
        return img[slices]
    return img


if __name__ == '__main__':
    
    while True:
        start = time.time()
        n_times = int(input('Convolve how many times? '))
        support_bound = 100 # decides how the support is cropped
        max_xy = 50
        
        #data = np.real(convolve(n_times))
        data = np.real(fast_convolve(n_times, support_bound))
        #print(data)
        #data = np.imag(fast_convolve(n_times, support_bound))
        #data = np.absolute(fast_convolve(n_times, support_bound))

        # if the support of the conv_power is too large --> keep it from -20 to 20
        s = min(np.shape(data)[0], max_xy)
        cropped = cropND(data,(2*s,2*s))

        dim = np.shape(cropped)
        x = range((-dim[0]//2)+1,(dim[0]//2)+1)
        y = range((-dim[1]//2)+1,(dim[1]//2)+1)

        hf = plt.figure()
        ha = hf.add_subplot(projection='3d')
        ha.set_xlim(-s, s)
        ha.set_ylim(-s, s)
        ha.set_xlabel('X')
        ha.set_ylabel('Y')
        ha.set_zlabel(' \n \n Re(Phi^(n)) for n='+str(n_times))

        X, Y = np.meshgrid(x, y)  
        surf = ha.plot_surface(X, Y, cropped, rstride=1, cstride=1, cmap='plasma', edgecolor='none', linewidth=0.2)

        end = time.time()
        print('Time elapsed (s): ', end - start)

        
        plt.show()
        print('-------------------------------------')
    
    



    




        
