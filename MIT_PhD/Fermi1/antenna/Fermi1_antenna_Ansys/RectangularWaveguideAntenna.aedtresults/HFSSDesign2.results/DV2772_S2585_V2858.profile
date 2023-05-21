$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/18/2023 21:58:11')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:01:38')
			I(1, 'ComEngine Memory', '93.7 M')
		$end 'TotalInfo'
		GroupOptions=8
		TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Executing from C:\\\\Program Files\\\\AnsysEM\\\\Ansys Student\\\\v222\\\\Win64\\\\HFSSCOMENGINE.exe\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC\', \'Enabled\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'Allow off core\', \'True\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC settings\', \'Auto\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Machines:\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'DESKTOP-9GEMUKL [31.9 GB]: RAM Limit: 90.000000%, 4 cores, Free Disk Space: 472 GB\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'Solution Basis Order\', \'1\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 88.1 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 21:58:11')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 1, 0, 47000, 'I(1, 2, \'Tetrahedra\', 8003, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 47000, 'I(1, 2, \'Tetrahedra\', 3217, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 34000, 'I(1, 2, \'Tetrahedra\', 4207, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 41488, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 54456, 'I(2, 1, \'Disk\', \'42.4 KB\', 2, \'Tetrahedra\', 2920, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 32840, 'I(1, 2, \'Tetrahedra\', 4426, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 21:58:14')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:13')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 1'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 21:58:14')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 42292, 'I(2, 1, \'Disk\', \'3.97 KB\', 2, \'Tetrahedra\', 3027, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 71576, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 3027, false, 2, \'1 triangles\', 116, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 105784, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 17533, false, 3, \'Matrix bandwidth\', 18.1963, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 105784, 'I(2, 1, \'Disk\', \'487 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92668, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 21:58:16')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 33928, 'I(1, 2, \'Tetrahedra\', 5340, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 44624, 'I(2, 1, \'Disk\', \'3.6 KB\', 2, \'Tetrahedra\', 3845, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80320, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 3845, false, 2, \'1 triangles\', 116, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 130508, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 22539, false, 3, \'Matrix bandwidth\', 18.8018, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 130508, 'I(2, 1, \'Disk\', \'270 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92840, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.205506, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 21:58:19')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 35348, 'I(1, 2, \'Tetrahedra\', 6496, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 46700, 'I(2, 1, \'Disk\', \'3.6 KB\', 2, \'Tetrahedra\', 4865, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 90700, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 4865, false, 2, \'1 triangles\', 116, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 165600, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 28743, false, 3, \'Matrix bandwidth\', 19.3086, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 165600, 'I(2, 1, \'Disk\', \'308 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92848, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0977609, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 21:58:22')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 36632, 'I(1, 2, \'Tetrahedra\', 7963, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 48940, 'I(2, 1, \'Disk\', \'3.21 KB\', 2, \'Tetrahedra\', 6169, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 104952, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6169, false, 2, \'1 triangles\', 116, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 218640, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36707, false, 3, \'Matrix bandwidth\', 19.686, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 218640, 'I(2, 1, \'Disk\', \'362 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92852, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0348598, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 5'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 21:58:25')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 38192, 'I(1, 2, \'Tetrahedra\', 9815, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 52140, 'I(2, 1, \'Disk\', \'3.97 KB\', 2, \'Tetrahedra\', 7814, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 122228, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 3, 0, 279964, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 279964, 'I(2, 1, \'Disk\', \'434 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92856, 'I(1, 0, \'Adaptive Pass 5\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0126222, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 21:58:27')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:01:22')
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
					I(1, 'Time', '05/18/2023 21:58:27')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:47')
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60416, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 86288, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 154628, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 154628, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59828, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 85188, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 154104, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 154104, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59544, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 85540, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 153672, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 153672, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59500, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 85328, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 153424, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 153424, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 7GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 5.5GHz; S Matrix Error = 165.427%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 4.75GHz; S Matrix Error = 175.202%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60656, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 86336, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 154792, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 154792, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60152, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 86168, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 154468, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 154468, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59788, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 85460, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 153756, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 153756, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58944, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 84096, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 152888, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 152888, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 6.25GHz; S Matrix Error =  10.863%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 5.125GHz; S Matrix Error =  11.837%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 4.375GHz; S Matrix Error =  12.569%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.875GHz; S Matrix Error =   0.276%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95364, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 5.64GHz; S Matrix Error =   0.225%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileFootnote('I(1, 0, \'Interpolating sweep did NOT converge\')', 0)
				ProfileFootnote('I(1, 0, \'HFSS: Distributed Interpolating sweep\')', 0)
				ProfileFootnote('I(1, 0, \'Sweep Simulation FAILED\')', 0)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'88.1 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'53.2 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:13\', 1, \'Average memory/process\', \'273 MB\', 1, \'Max memory/process\', \'273 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:01:22\', 1, \'Average memory/process\', \'150 MB\', 1, \'Max memory/process\', \'151 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 7814, false, 2, \'Max matrix size\', 46799, false, 1, \'Matrix bandwidth\', \'20.0\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/18/2023 21:59:50\', 1, \'Status\', \'Aborted\')', 1)
	$end 'ProfileGroup'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/18/2023 21:59:59')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:05')
			I(1, 'ComEngine Memory', '91.5 M')
		$end 'TotalInfo'
		GroupOptions=8
		TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Executing from C:\\\\Program Files\\\\AnsysEM\\\\Ansys Student\\\\v222\\\\Win64\\\\HFSSCOMENGINE.exe\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC\', \'Enabled\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'Allow off core\', \'True\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC settings\', \'Auto\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Machines:\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'DESKTOP-9GEMUKL [31.9 GB]: RAM Limit: 90.000000%, 4 cores, Free Disk Space: 472 GB\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'Solution Basis Order\', \'1\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 85.7 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Adaptive Passes converged\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 21:59:59')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:05')
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
					I(1, 'Time', '05/18/2023 21:59:59')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:04')
				$end 'TotalInfo'
				GroupOptions=4
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'From 4GHz to 7GHz, 301 Frequencies\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 7GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 5.5GHz; S Matrix Error = 165.427%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 4.75GHz; S Matrix Error = 175.202%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 6.25GHz; S Matrix Error =  10.863%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 5.125GHz; S Matrix Error =  11.837%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 4.375GHz; S Matrix Error =  12.569%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.875GHz; S Matrix Error =   0.276%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 5.64GHz; S Matrix Error =   0.225%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Using previously solved data. Additional simulations must be performed to correct interpolating sweep convergence or passivity\')', false, true)
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
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60864, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 86776, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 155272, 'I(4, 1, \'Disk\', \'790 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 155272, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60372, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 85448, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 154816, 'I(4, 1, \'Disk\', \'790 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 154816, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59480, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 84752, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 153888, 'I(4, 1, \'Disk\', \'790 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 153888, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59048, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 84484, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7814, false, 2, \'1 triangles\', 116, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 153116, 'I(4, 1, \'Disk\', \'790 Bytes\', 2, \'Matrix size\', 46799, false, 3, \'Matrix bandwidth\', 20.0005, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 153116, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 6.625GHz; S Matrix Error =   0.398%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.9375GHz; S Matrix Error =   0.112%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 5.3125GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 93108, 'I(1, 0, \'Frequency Group #1; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'85.7 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'0 Bytes\')', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:05\', 1, \'Average memory/process\', \'151 MB\', 1, \'Max memory/process\', \'152 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 7814, false, 2, \'Max matrix size\', 46799, false, 1, \'Matrix bandwidth\', \'20.0\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/18/2023 22:00:04\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
