#pragma TextEncoding = "Windows-1252"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.


Function Ramsey_fringes(w,detune) : FitFunc
	Wave w
	Variable detune

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(detune) = 4*yscale*(Rabi^2/(Rabi^2+(12*2*Pi*(detune+Delta_Stark-Center))^2))*(Sin(Sqrt(Rabi^2+(12*2*Pi*(detune+Delta_Stark-Center))^2)*Tau/2)^2)*(Cos(Sqrt(Rabi^2+(12*2*Pi*(detune+Delta_Stark-Center))^2)*Tau/2)*Cos((12*2*Pi*(detune-Center))*T/2) - ((12*2*Pi*(detune+Delta_Stark-Center))/Sqrt((12*2*Pi*(detune+Delta_Stark-Center))^2+Rabi^2))*Sin(Sqrt(Rabi^2+(12*2*Pi*(detune+Delta_Stark-Center))^2)*Tau/2)*Sin((12*2*Pi*(detune-Center))*T/2))^2 + y_shift
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ detune
	//CurveFitDialog/ Coefficients 7
	//CurveFitDialog/ w[0] = Tau
	//CurveFitDialog/ w[1] = T
	//CurveFitDialog/ w[2] = Center
	//CurveFitDialog/ w[3] = Rabi
	//CurveFitDialog/ w[4] = Delta_Stark
	//CurveFitDialog/ w[5] = yscale
	//CurveFitDialog/ w[6] = y_shift

	return 4*w[5]*(w[3]^2/(w[3]^2+(12*2*Pi*(detune+w[4]-w[2]))^2))*(Sin(Sqrt(w[3]^2+(12*2*Pi*(detune+w[4]-w[2]))^2)*w[0]/2)^2)*(Cos(Sqrt(w[3]^2+(12*2*Pi*(detune+w[4]-w[2]))^2)*w[0]/2)*Cos((12*2*Pi*(detune-w[2]))*w[1]/2) - ((12*2*Pi*(detune+w[4]-w[2]))/Sqrt((12*2*Pi*(detune+w[4]-w[2]))^2+w[3]^2))*Sin(Sqrt(w[3]^2+(12*2*Pi*(detune+w[4]-w[2]))^2)*w[0]/2)*Sin((12*2*Pi*(detune-w[2]))*w[1]/2))^2 + w[6]
End
