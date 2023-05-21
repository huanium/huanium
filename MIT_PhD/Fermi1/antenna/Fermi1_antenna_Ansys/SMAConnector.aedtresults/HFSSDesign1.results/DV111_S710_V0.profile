$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/18/2023 02:30:09')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:08')
			I(1, 'ComEngine Memory', '92.5 M')
		$end 'TotalInfo'
		GroupOptions=8
		TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Executing from C:\\\\Program Files\\\\AnsysEM\\\\Ansys Student\\\\v222\\\\Win64\\\\HFSSCOMENGINE.exe\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC\', \'Enabled\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'Allow off core\', \'True\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC settings\', \'Auto\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Machines:\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'DESKTOP-9GEMUKL [31.9 GB]: RAM Limit: 90.000000%, 4 cores, Free Disk Space: 473 GB\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'Solution Basis Order\', \'1\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 87.2 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 02:30:09')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:00')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 30300, 'I(1, 2, \'Tetrahedra\', 1776, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 37356, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 49480, 'I(2, 1, \'Disk\', \'41 KB\', 2, \'Tetrahedra\', 468, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 30472, 'I(1, 2, \'Tetrahedra\', 1933, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 02:30:09')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:04')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 1'
				$begin 'StartInfo'
					I(0, 'Frequency:  5GHz')
					I(1, 'Time', '05/18/2023 02:30:09')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 38340, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 548, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 47660, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 548, false, 2, \'1 triangles\', 106, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 0, 0, 53640, 'I(3, 1, \'Disk\', \'1.53 KB\', 2, \'Matrix size\', 2507, false, 3, \'Matrix bandwidth\', 14.5152, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 53640, 'I(2, 1, \'Disk\', \'64.3 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 91368, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5GHz')
					I(1, 'Time', '05/18/2023 02:30:12')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 30976, 'I(1, 2, \'Tetrahedra\', 2100, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 38128, 'I(2, 1, \'Disk\', \'4.74 KB\', 2, \'Tetrahedra\', 697, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 48948, 'I(3, 1, \'Disk\', \'6 Bytes\', 2, \'Tetrahedra\', 697, false, 2, \'1 triangles\', 106, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 0, 0, 56192, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 3427, false, 3, \'Matrix bandwidth\', 16.2169, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 56192, 'I(2, 1, \'Disk\', \'28.9 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 91640, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.00296756, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 02:30:14')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:02')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC\', \'Enabled\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Solution - Sweep'
				$begin 'StartInfo'
					I(0, 'Interpolating HFSS Frequency Sweep, Solving Distributed - up to 4 frequencies in parallel')
					I(1, 'Time', '05/18/2023 02:30:14')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=4
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'From 2.5GHz to 7.5GHz, 401 Frequencies\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:00')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 46684, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 697, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 56088, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 697, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 0, 0, 0, 0, 57784, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 3427, false, 3, \'Matrix bandwidth\', 16.2169, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 57784, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 2.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:00')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 46792, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 697, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 56224, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 697, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 0, 0, 0, 0, 57944, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 3427, false, 3, \'Matrix bandwidth\', 16.2169, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 57960, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 3.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:00')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 46532, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 697, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 55984, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 697, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 0, 0, 0, 0, 57148, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 3427, false, 3, \'Matrix bandwidth\', 16.2169, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 57148, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:00')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 46376, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 697, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 55924, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 697, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 0, 0, 0, 0, 57004, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 3427, false, 3, \'Matrix bandwidth\', 16.2169, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 57004, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 7.5GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 2.5GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 5GHz; S Matrix Error =   5.583%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 3.75GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94156, 'I(1, 0, \'Frequency Group #1; Interpolating frequency sweep\')', true, true)
				ProfileFootnote('I(1, 0, \'Interpolating sweep converged and is passive\')', 0)
				ProfileFootnote('I(1, 0, \'HFSS: Distributed Interpolating sweep\')', 0)
			$end 'ProfileGroup'
		$end 'ProfileGroup'
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Simulation Summary'
			$begin 'StartInfo'
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(0, ' ')
			$end 'TotalInfo'
			GroupOptions=0
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'87.2 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'48.3 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:04\', 1, \'Average memory/process\', \'54.9 MB\', 1, \'Max memory/process\', \'54.9 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:02\', 1, \'Average memory/process\', \'56.1 MB\', 1, \'Max memory/process\', \'56.6 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 697, false, 2, \'Max matrix size\', 3427, false, 1, \'Matrix bandwidth\', \'16.2\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/18/2023 02:30:17\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
