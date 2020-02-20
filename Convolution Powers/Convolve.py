import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from matplotlib import cm, colors
from mpl_toolkits.mplot3d.axes3d import Axes3D
import operator
import time
from numpy import unravel_index



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

    # Note: Phi[y][x]

    '''
    # just Phi with monoterms, oscillatory
    Phi[ 0+9//2][ 0+9//2]  = complex(173/256,-7/32)
    Phi[ 0+9//2][ 1+9//2]  = complex(1/8,1/16)      
    Phi[ 0+9//2][-1+9//2]  = complex(1/8,1/16)      
    Phi[ 0+9//2][ 2+9//2]  = -1/32               
    Phi[ 0+9//2][-2+9//2]  = -1/32
    Phi[ 1+9//2][ 0+9//2]  = complex(7/64,1/16)
    Phi[-1+9//2][ 0+9//2]  = complex(7/64,1/16)
    Phi[ 2+9//2][ 0+9//2]  = -complex(7/128,1/64)
    Phi[-2+9//2][ 0+9//2]  = -complex(7/128,1/64)
    Phi[ 3+9//2][ 0+9//2]  = 1/64
    Phi[-3+9//2][ 0+9//2]  = 1/64
    Phi[ 4+9//2][ 0+9//2]  = -1/512
    Phi[-4+9//2][ 0+9//2]  = -1/512

    '''
    # new Phi, with cross terms, oscillatory
    # mono terms 
    Phi[ 0+9//2][ 0+9//2]  = complex(301/384,-7/48)
    Phi[ 0+9//2][ 1+9//2]  = complex(0,1/24)     
    Phi[ 0+9//2][-1+9//2]  = complex(1/6,1/24)      
    Phi[ 0+9//2][ 2+9//2]  = -1/48               
    Phi[ 0+9//2][-2+9//2]  = -1/48
    Phi[ 1+9//2][ 0+9//2]  = complex(7/96,1/24)
    Phi[-1+9//2][ 0+9//2]  = complex(7/96,1/24)
    Phi[ 2+9//2][ 0+9//2]  = -complex(7/192,1/96)
    Phi[-2+9//2][ 0+9//2]  = -complex(7/192,1/96)
    Phi[ 3+9//2][ 0+9//2]  = 1/96
    Phi[-3+9//2][ 0+9//2]  = 1/96
    Phi[ 4+9//2][ 0+9//2]  = -1/768
    Phi[-4+9//2][ 0+9//2]  = -1/768
    
    # cross terms
    Phi[-1+9//2][-1+9//2]  =  1/24
    Phi[ 1+9//2][-1+9//2]  =  1/24
    Phi[ 1+9//2][ 1+9//2]  = -1/24
    Phi[-1+9//2][ 1+9//2]  = -1/24
    


    conv_power = np.copy(Phi)
    offset = np.array([0,0])

    #print('Max of Phi: ')
    #print(unravel_index(np.absolute(Phi).argmax(), np.absolute(Phi).shape))

    i=0
    drift = False

    while i < n_times:

        i += 1

        init_vec = unravel_index(np.absolute(conv_power).argmax(), np.absolute(conv_power).shape)
        conv_power = signal.convolve2d(Phi, conv_power, 'full')
        after_vec = unravel_index(np.absolute(conv_power).argmax(), np.absolute(conv_power).shape)
        offset += np.subtract(init_vec , after_vec)

        # print(offset)

        dim_f = np.shape(conv_power)
        
        if dim_f[0] > support_bound or dim_f[0] > support_bound:


            # if DRIFT:
            #conv_power = crop(conv_power, support_bound)

            # if NOT:
            conv_power = cropND(conv_power,(support_bound,support_bound))
            

    # print(offset)        
    return (conv_power,drift)


def cropND(img, bounding):
    if bounding[0] <= np.shape(img)[0] and bounding[1] <= np.shape(img)[1]:
        start = tuple(map(lambda a, da: a//2-da//2, img.shape, bounding))
        end = tuple(map(operator.add, start, bounding))
        slices = tuple(map(slice, start, end))
        return img[slices]
    return img


def crop(img, sup_bd):

    # find location of maximum and center there
    center = unravel_index(np.absolute(img).argmax(), np.absolute(img).shape)
    return img[center[0]-sup_bd//4:center[0]+sup_bd//4,
               center[1]-sup_bd//4:center[1]+sup_bd//4]


if __name__ == '__main__':

    
    while True:
        start = time.time()
        n_times = int(input('Convolve how many times? '))
        support_bound = int(input('NxN suppport bound, N = '))
        # decides how the support is cropped
        print('Calculating...')

        output = fast_convolve(n_times, support_bound)
        #data = np.real(convolve(n_times))
        data = np.real(output[0])
        drift = output[1]
        #print(drift)
        #print(data)
        #data = np.imag(fast_convolve(n_times, support_bound))
        #data = np.absolute(fast_convolve(n_times, support_bound))

        
        s = min(np.shape(data)[0], support_bound//2)
        cropped = cropND(data,(2*s,2*s))

        dim = np.shape(cropped)
        x = range((-dim[0]//2)+1,(dim[0]//2)+1)
        y = range((-dim[1]//2)+1,(dim[1]//2)+1)

        

        hf = plt.figure()
        ha = hf.add_subplot(projection='3d')
        ha.set_xlim(-np.shape(cropped)[0]//2, np.shape(cropped)[0]//2)
        ha.set_ylim(-np.shape(cropped)[0]//2, np.shape(cropped)[0]//2)

        drift = False # I'm setting this for now for testing
        if drift:
            ha.set_xlabel('\n \n X \n \n DRIFTING CONVOLUTION POWERS!')
            ha.set_ylabel('\n \n Y \n \n DRIFTING CONVOLUTION POWERS!')
            ha.set_zlabel(' \n \n Re(Phi^(n)) for n='+str(n_times))
        else:
            ha.set_xlabel('X')
            ha.set_ylabel('Y')
            ha.set_zlabel(' \n \n Re(Phi^(n)) for n='+str(n_times))
        

        X, Y = np.meshgrid(x, y)  
        surf = ha.plot_surface(X, Y, cropped , rstride=1, cstride=1, cmap='plasma', edgecolor='none', linewidth=0.2)

        end = time.time()
        print('Time elapsed (s): ', end - start)

        
        plt.show()
        print('-------------------------------------')
    
    



    




        
