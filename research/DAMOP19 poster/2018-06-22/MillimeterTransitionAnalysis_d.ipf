#include <Strings as Lists>
#pragma rtGlobals=1		// Use modern global access method.
// FFT Analysis 

Menu "Macros"
	
	"Transition Analysis...", TransitionAnalysis()
End

Function TransitionAnalysis()

String pathName
String filename
String w0, w1, w2, w3, w4, w5, w6
String GraphName0, GraphName1,GraphName2,GraphName3
String  GraphTitle0,GraphTitle1,GraphTitle2,GraphTitle3

String filename_moffset = "kmmd_000_mwoffset"
String filename_Rydberg1 = "kmmd_000_Rydberg1"
String filename_Rydberg1_sigma = "kmmd_000_Rydberg1_sigma"
String filename_Rydberg2 = "kmmd_000_Rydberg2"
String filename_Rydberg2_sigma = "kmmd_000_Rydberg2_sigma"
String filename_RydbergT = "kmmd_000_RydbergT"
String filename_RydbergT_sigma = "kmmd_000_RydbergT_sigma"

String filename_TransFrac = "kmmd_000_TransFrac"

LoadWave/T/D/O // Load an Igor Text file 
filename= S_filename

//Put the names of the waves into string variables

w0 = GetStrFromList(S_waveNames, 0,";")
w1 = GetStrFromList(S_waveNames, 1,";")
w2 = GetStrFromList(S_waveNames, 2,";")
w3 = GetStrFromList(S_waveNames, 3,";")
w4 = GetStrFromList(S_waveNames, 4,";")
w5 = GetStrFromList(S_waveNames, 5,";")
w6 = GetStrFromList(S_waveNames, 6,";")


// Put the data file index (numbers) into the name of each wave for the 4th, 5th, and 6th characters
filename_moffset[5,7] = filename[5,7]
filename_Rydberg1[5,7] = filename[5,7]
filename_Rydberg1_sigma[5,7] = filename[5,7]
filename_Rydberg2[5,7] = filename[5,7]
filename_Rydberg2_sigma[5,7] = filename[5,7]
filename_RydbergT[5,7] = filename[5,7]
filename_RydbergT_sigma[5,7] = filename[5,7]
filename_TransFrac[5,7] = filename[5,7]

//Create waves with meaningful names
	Duplicate/O $w0, $filename_moffset; KillWaves $w0
	Wave moffset = $filename_moffset


	Duplicate/O $w1, $filename_Rydberg1; KillWaves $w1
	Wave/Z Rydberg1 = $filename_Rydberg1
	
	//Duplicate/O $w2, $filename_Rydberg1_sigma;
	KillWaves $w2
	
	Duplicate/O $w3, $filename_Rydberg2; Duplicate/O $w3, $filename_TransFrac; KillWaves $w3
	Wave/Z Rydberg2 = $filename_Rydberg2
	Wave/C TransFrac = $filename_TransFrac
	
	//Duplicate/O $w4, $filename_Rydberg2_sigma; 
	KillWaves $w4

	Duplicate/O $w5, $filename_RydbergT; KillWaves $w5
	KillWaves $w6
	Wave/Z RydbergT = $filename_RydbergT

	
	TransFrac= Rydberg2/(Rydberg1 + Rydberg2)
//	TransFrac= Rydberg2/RydbergT


// Scale the x data to time:
//	variable df = (moffset[1] - moffset[0])
	variable df = (moffset[numpnts(moffset)] - moffset[0])/(numpnts(moffset)-1)
	variable fstart = moffset[0]
	SetScale/P x fstart,df,"", $Filename_Rydberg1
	SetScale/P x fstart,df,"", $Filename_Rydberg2
	SetScale/P x fstart,df,"", $Filename_RydbergT
	SetScale/P x fstart,df,"", $Filename_TransFrac


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
	
	GraphTitle2= "Graph_" + filename_TransFrac
	Display $filename_TransFrac as GraphTitle2
//	SetAxis Bottom -2 , 0
	ModifyGraph mirror=1,standoff=0
	ModifyGraph tick=2

	


End