#ifndef CHAMBER_HPP
#define CHAMBER_HPP

#include <cstdlib>

// Settings for spoons
struct spoonProps {
    double strengthSetting;
    double strength; 
    int radius;
    int2 pos;
};


// Handles the simulation parameters and potentials.
class Chamber
{
    public:
        int DIM, DS;
        double *Potential, *Kinetic, *XkY, *YkX, *devXkY, *devYkX, *omegaR;
        double *devPotential;
        cuDoubleComplex *devExpPotential, *hostExpPotential;
        cuDoubleComplex *devExpKinetic, *hostExpKinetic;
        cuDoubleComplex *devExpXkY, *devExpYkX;
        double *X, *Y, *kX, *kY;
        double dx, dy, dk, dt;
        double fov, kfov;
        double omega, epsilon;
        double mass, g;
        double cooling, useReal;
        double cmapscale;
        bool useImaginaryTime, useRotatingFrame;
        bool stopSim;
        spoonProps spoon1;
        bool useLeapMotion, useLeapZ;
        double4 LeapProps;
        cufftHandle fftPlan2D, fftPlan1D;


        
        void setup(int size, double fov, double g, double deltat, bool useImag, double cool);
        void setHarmonicPotential(double o, double ep);
        void setEdgePotential(double strength, double radius, double sharpness);
        void setupPotential();
        void AbsorbingBoundaryConditions(double strength, double radius);
        void SetupSpoon(double strength, double radius);
        void Spoon();
        // void InitializePotential(cuDoubleComplex *arr);
        void Cleanup();
    

};




#endif