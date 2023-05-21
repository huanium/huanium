$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/18/2023 23:02:16')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:28')
			I(1, 'ComEngine Memory', '96 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 90.8 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 23:02:16')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 1, 0, 48000, 'I(1, 2, \'Tetrahedra\', 9073, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 48000, 'I(1, 2, \'Tetrahedra\', 3104, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 33516, 'I(1, 2, \'Tetrahedra\', 4007, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 40920, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 52680, 'I(2, 1, \'Disk\', \'40.7 KB\', 2, \'Tetrahedra\', 2790, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 32312, 'I(1, 2, \'Tetrahedra\', 4174, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 23:02:19')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:10')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 1'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 23:02:19')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 42380, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 2875, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 70204, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 2875, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 0, 0, 106188, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 16699, false, 3, \'Matrix bandwidth\', 18.234, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 106188, 'I(2, 1, \'Disk\', \'467 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95128, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 23:02:22')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 33896, 'I(1, 2, \'Tetrahedra\', 5040, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 44364, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 3672, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79140, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 3672, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 129076, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 21617, false, 3, \'Matrix bandwidth\', 18.9199, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 129076, 'I(2, 1, \'Disk\', \'263 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95188, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.326044, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 23:02:24')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 34984, 'I(1, 2, \'Tetrahedra\', 6142, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 46296, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 4654, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 90028, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 4654, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 158412, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 27603, false, 3, \'Matrix bandwidth\', 19.377, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 158412, 'I(2, 1, \'Disk\', \'298 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95228, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0769833, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 23:02:27')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 36680, 'I(1, 2, \'Tetrahedra\', 7540, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 47484, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 5893, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 102428, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 208436, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 208436, 'I(2, 1, \'Disk\', \'349 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95236, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0127882, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 23:02:30')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:14')
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
					I(1, 'Time', '05/18/2023 23:02:30')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:14')
				$end 'TotalInfo'
				GroupOptions=4
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'From 4GHz to 7GHz, 301 Frequencies\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57328, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77184, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 126348, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 126348, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56932, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 76880, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124984, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124984, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56516, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 76340, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 125336, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 125336, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:01')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 55528, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 75640, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 123628, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 123628, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 7GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 5.5GHz; S Matrix Error = 137.949%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 4.75GHz; S Matrix Error = 109.160%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57240, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77092, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 125308, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 125308, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.125GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57080, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78372, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 125164, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 125164, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.375GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56116, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 76168, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 123940, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 123940, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.875GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:01')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 55544, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 76724, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 123488, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 123488, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 6.25GHz; S Matrix Error =  13.478%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 5.125GHz; S Matrix Error =   8.617%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 4.375GHz; S Matrix Error =   4.013%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.875GHz; S Matrix Error =   0.463%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97744, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 5.64GHz; S Matrix Error =   0.218%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.625GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57500, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77468, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 126696, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 126696, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.9375GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56824, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77084, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 125856, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 125856, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.3125GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56304, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 76356, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124304, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124304, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.5625GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:01')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 55944, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77200, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5893, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124020, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 35155, false, 3, \'Matrix bandwidth\', 19.747, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124020, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 6.625GHz; S Matrix Error =   0.422%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.9375GHz; S Matrix Error =   0.078%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 5.3125GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97776, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'90.8 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'51.4 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:10\', 1, \'Average memory/process\', \'204 MB\', 1, \'Max memory/process\', \'204 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:14\', 1, \'Average memory/process\', \'122 MB\', 1, \'Max memory/process\', \'124 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 5893, false, 2, \'Max matrix size\', 35155, false, 1, \'Matrix bandwidth\', \'19.7\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/18/2023 23:02:44\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
