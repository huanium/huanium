import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import csv




if __name__ == '__main__':

    data = np.loadtxt("data4.csv", delimiter=",")
    x = data[:,0]
    y = data[:,1]
    z = data[:,2]

    fig = plt.figure()
    ax1 = fig.add_subplot(111,projection='3d')

    X,Y = np.meshgrid(x,y)
    #X,Z = np.meshgrid(x,z)
    #ax1.scatter(x,y,z, c=z, cmap='plasma', s=5, linewidths=0.0)

    ax1.plot_trisurf(x,y,z, cmap='plasma', linewidths=0.0)
    #ax1.plot_surface(X, Y, Z, *args, **kwargs)
    plt.grid(True)
    plt.show()


    

    
    

    




        
