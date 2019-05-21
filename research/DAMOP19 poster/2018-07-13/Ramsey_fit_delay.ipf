#pragma TextEncoding = "Windows-1252"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.


Function Ramsey_fit_delay(w,T) : FitFunc
	Wave w
	Variable T

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(T) = yscale*(4*Rabi^2/(Rabi^2+(12*2*Pi*(delta_0-MW_Offset)+Delta_d))^2)*(Sin(Sqrt(Rabi^2+(12*2*Pi*(delta_0-MW_Offset)+Delta_d))^2)*Tau/2)^2*(Cos(Sqrt(Rabi^2+(12*2*Pi*((delta_0-MW_Offset)+Delta_d))^2)*Tau/2)*Cos((12*2*Pi*(delta_0-MW_Offset))*T/2) - ((12*2*Pi*(delta_0-MW_Offset+Delta_d))/Sqrt((12*2*Pi*(delta_0-MW_Offset+Delta_d))^2+Rabi^2))*Sin(Sqrt(Rabi^2+(12*2*Pi*(delta_0-MW_Offset+Delta_d))^2)*Tau/2)*Sin((12*2*Pi*(delta_0-MW_Offset))*T/2))^2 + y_shift
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ T
	//CurveFitDialog/ Coefficients 7
	//CurveFitDialog/ w[0] = Tau
	//CurveFitDialog/ w[1] = delta_0
	//CurveFitDialog/ w[2] = Rabi
	//CurveFitDialog/ w[3] = Delta_d
	//CurveFitDialog/ w[4] = yscale
	//CurveFitDialog/ w[5] = y_shift
	//CurveFitDialog/ w[6] = MW_Offset

	return w[4]*(4*w[2]^2/(w[2]^2+(12*2*Pi*(w[1]-w[6])+w[3]))^2)*(Sin(Sqrt(w[2]^2+(12*2*Pi*(w[1]-w[6])+w[3]))^2)*w[0]/2)^2*(Cos(Sqrt(w[2]^2+(12*2*Pi*((w[1]-w[6])+w[3]))^2)*w[0]/2)*Cos((12*2*Pi*(w[1]-w[6]))*T/2) - ((12*2*Pi*(w[1]-w[6]+w[3]))/Sqrt((12*2*Pi*(w[1]-w[6]+w[3]))^2+w[2]^2))*Sin(Sqrt(w[2]^2+(12*2*Pi*(w[1]-w[6]+w[3]))^2)*w[0]/2)*Sin((12*2*Pi*(w[1]-w[6]))*T/2))^2 + w[5]
End

Function E_cos2(w,delay) : FitFunc
	Wave w
	Variable delay

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(delay) = y0 + A*Exp(-B*(delay-Tau))*(Cos(12*2*Pi*freq*(delay - Tau)/2 - phi))^2 
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ delay
	//CurveFitDialog/ Coefficients 6
	//CurveFitDialog/ w[0] = y0
	//CurveFitDialog/ w[1] = A
	//CurveFitDialog/ w[2] = B
	//CurveFitDialog/ w[3] = phi
	//CurveFitDialog/ w[4] = Tau
	//CurveFitDialog/ w[5] = freq

	return w[0] + w[1]*Exp(-w[2]*(delay-w[4]))*(Cos(12*2*Pi*w[5]*(delay - w[4])/2 - w[3]))^2 
End
