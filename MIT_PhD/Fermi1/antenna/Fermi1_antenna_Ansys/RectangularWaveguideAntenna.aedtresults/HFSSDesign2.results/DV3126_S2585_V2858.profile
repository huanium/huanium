$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/18/2023 22:53:34')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:33')
			I(1, 'ComEngine Memory', '96.5 M')
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
				I(1, 'Time', '05/18/2023 22:53:34')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 1, 0, 49000, 'I(1, 2, \'Tetrahedra\', 10682, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 49000, 'I(1, 2, \'Tetrahedra\', 3609, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 33972, 'I(1, 2, \'Tetrahedra\', 4588, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 41620, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 53608, 'I(2, 1, \'Disk\', \'40.9 KB\', 2, \'Tetrahedra\', 3165, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 33016, 'I(1, 2, \'Tetrahedra\', 4763, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:53:37')
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
					I(1, 'Time', '05/18/2023 22:53:37')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 43204, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 3257, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 73380, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 3257, false, 2, \'1 triangles\', 106, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 115900, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 18747, false, 3, \'Matrix bandwidth\', 18.3309, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 115900, 'I(2, 1, \'Disk\', \'511 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95372, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:53:39')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 34472, 'I(1, 2, \'Tetrahedra\', 5684, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 45484, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 4102, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 83356, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Tetrahedra\', 4102, false, 2, \'1 triangles\', 106, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 142740, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 23953, false, 3, \'Matrix bandwidth\', 18.9486, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 142740, 'I(2, 1, \'Disk\', \'271 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95428, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0825596, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:53:42')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 35400, 'I(1, 2, \'Tetrahedra\', 6925, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 47608, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 5246, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 95120, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Tetrahedra\', 5246, false, 2, \'1 triangles\', 106, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 184348, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 30993, false, 3, \'Matrix bandwidth\', 19.4881, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 184348, 'I(2, 1, \'Disk\', \'322 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95440, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0432608, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:53:45')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 37376, 'I(1, 2, \'Tetrahedra\', 8502, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 50340, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 6713, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110260, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 3, 0, 250208, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 250208, 'I(2, 1, \'Disk\', \'382 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95584, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0171116, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:53:48')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:19')
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
					I(1, 'Time', '05/18/2023 22:53:48')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:19')
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58324, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81036, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 142384, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 142384, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57684, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80128, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141536, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141536, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57504, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80364, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141284, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141284, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57260, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79916, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141320, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141320, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 7GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 5.5GHz; S Matrix Error = 106.964%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 4.75GHz; S Matrix Error = 106.525%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58464, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81696, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 142484, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 142484, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58320, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81068, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 142172, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 142172, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57604, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80040, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141296, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141296, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.875GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57120, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79800, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 140744, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 140744, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 6.25GHz; S Matrix Error =  25.800%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 5.125GHz; S Matrix Error =  20.433%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 4.375GHz; S Matrix Error =   1.037%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.875GHz; S Matrix Error =   0.304%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 98136, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58700, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81248, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 142488, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 142488, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.1875GHz'
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58340, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80800, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 142388, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 142388, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.5625GHz'
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57708, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80356, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141428, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141428, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.0625GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57228, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79724, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141136, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141136, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 6.625GHz; S Matrix Error =   0.513%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 4.1875GHz; S Matrix Error =   0.245%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.5625GHz; S Matrix Error =   0.251%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 6.0625GHz; S Matrix Error =   0.226%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 98168, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 5.64GHz; S Matrix Error =   0.825%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.8125GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59044, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81432, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 143236, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 143236, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.4375GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58620, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81352, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 142496, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 142496, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.7575GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57492, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80100, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141420, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141420, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.15625GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57208, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79740, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6713, false, 2, \'1 triangles\', 106, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141068, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40101, false, 3, \'Matrix bandwidth\', 19.9612, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141068, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 6.8125GHz; S Matrix Error =   0.160%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 15, Frequency: 6.4375GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 98224, 'I(1, 0, \'Frequency Group #4; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'52.3 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:10\', 1, \'Average memory/process\', \'244 MB\', 1, \'Max memory/process\', \'244 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:19\', 1, \'Average memory/process\', \'139 MB\', 1, \'Max memory/process\', \'140 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 6713, false, 2, \'Max matrix size\', 40101, false, 1, \'Matrix bandwidth\', \'20.0\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/18/2023 22:54:07\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
