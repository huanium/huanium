#include <Strings as Lists>
#pragma rtGlobals=1		// Use modern global access method.
// FFT Analysis 

Menu "Macros"
	
	"Load TimeHarp Data ...", DecayLoad1()
End

Function DecayLoad1()

String pathName
String filename
String w0, w1, w2, w3, w4, w5, w6
String GraphName0, GraphName1,GraphName2,GraphName3
String  GraphTitle0,GraphTitle1,GraphTitle2,GraphTitle3

String filename_counts = "k5p3_000_counts"

LoadWave/G/A/D/O // Load an Igor Text file 
filename= S_filename

//Put the names of the waves into string variables

w0 = GetStrFromList(S_waveNames, 0,";")
w1 = GetStrFromList(S_waveNames, 1,";")



// Put the data file index (numbers) into the name of each wave for the 4th, 5th, and 6th characters
filename_counts[5,7] = filename[5,7]

//Create waves with meaningful names
	Duplicate/O $w0, $filename_counts; KillWaves $w0
	Wave counts = $filename_counts

	KillWaves $w1
	
// 	Delete all points after point 2000 (
	DeletePoints 2000,35268, $filename_counts

// Scale the x data to time:

	variable dt = 2 // assume 2ns data sets
	variable tstart = 0
	SetScale/P x tstart,dt,"", counts


//Make Graphs

	//GraphTitle0= "Graph_" + filename_Rydberg1
	//Display $filename_Rydberg1 as GraphTitle0
	//SetAxis Bottom -2 , 0
	//ModifyGraph mirror=1,standoff=0
	//ModifyGraph tick=2
	
	//GraphTitle1= "Graph_" + filename_Rydberg2
	//Display $filename_Rydberg2 as GraphTitle1
	//SetAxis Bottom -2 , 0
	//ModifyGraph mirror=1,standoff=0
	//ModifyGraph tick=2
	
//	GraphTitle2= "Graph_" + filename_TransFrac
	Display $filename_counts //as GraphTitle2
//	SetAxis Bottom -2 , 0
	ModifyGraph mirror=1,standoff=0
	ModifyGraph tick=2
	ModifyGraph log(left)=1
	ShowInfo

End



Function qbeats(w,t) : FitFunc
	Wave w
	Variable t

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(t) = Amp*exp(-(t - t0)/tau)*(1 + frac*cos(2*pi*fbeat/1000*(t - t0) - phase)) + Offset
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ t
	//CurveFitDialog/ Coefficients 7
	//CurveFitDialog/ w[0] = Amp
	//CurveFitDialog/ w[1] = t0
	//CurveFitDialog/ w[2] = tau
	//CurveFitDialog/ w[3] = frac
	//CurveFitDialog/ w[4] = fbeat
	//CurveFitDialog/ w[5] = phase
	//CurveFitDialog/ w[6] = Offset

	return w[0]*exp(-(t - w[1])/w[2])*(1 + w[3]*cos(2*pi*w[4]/1000*(t - w[1]) - w[5])) + w[6]
End
