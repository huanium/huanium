$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/18/2023 22:43:50')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:33')
			I(1, 'ComEngine Memory', '96.2 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 90.8 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:43:50')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 1, 0, 50000, 'I(1, 2, \'Tetrahedra\', 10946, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 50000, 'I(1, 2, \'Tetrahedra\', 3774, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 33960, 'I(1, 2, \'Tetrahedra\', 4729, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 42024, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 54112, 'I(2, 1, \'Disk\', \'40.7 KB\', 2, \'Tetrahedra\', 3206, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 33060, 'I(1, 2, \'Tetrahedra\', 4893, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:43:53')
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
					I(1, 'Time', '05/18/2023 22:43:53')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 44472, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 3287, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 74472, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 3287, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 113040, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 18857, false, 3, \'Matrix bandwidth\', 18.2563, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 113040, 'I(2, 1, \'Disk\', \'515 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95244, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:43:56')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 34916, 'I(1, 2, \'Tetrahedra\', 5885, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 45516, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 4203, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 83468, 'I(3, 1, \'Disk\', \'4 Bytes\', 2, \'Tetrahedra\', 4203, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 139904, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 24479, false, 3, \'Matrix bandwidth\', 18.9119, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 139904, 'I(2, 1, \'Disk\', \'281 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95352, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0459591, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:43:59')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 36064, 'I(1, 2, \'Tetrahedra\', 7152, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 47576, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 5334, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 96340, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5334, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 177280, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 31403, false, 3, \'Matrix bandwidth\', 19.3786, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 177280, 'I(2, 1, \'Disk\', \'324 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95360, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0221489, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:44:01')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 36340, 'I(1, 2, \'Tetrahedra\', 8060, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 48628, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 6155, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 104184, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 206836, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 206836, 'I(2, 1, \'Disk\', \'307 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95376, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.00962838, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:44:04')
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
					I(1, 'Time', '05/18/2023 22:44:04')
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58072, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79964, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 125588, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 125588, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57404, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78616, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124996, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124996, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56604, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77088, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 122448, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 122448, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56412, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 76988, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 122468, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 122468, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 7GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 5.5GHz; S Matrix Error =  91.327%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 4.75GHz; S Matrix Error = 148.297%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58056, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79880, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 125212, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 125212, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57600, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79504, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 123644, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 123644, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56904, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78800, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 122812, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 122812, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56544, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78376, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 123548, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 123548, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 6.25GHz; S Matrix Error =  62.637%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 5.125GHz; S Matrix Error =  66.410%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 4.375GHz; S Matrix Error =   3.386%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.875GHz; S Matrix Error =   1.756%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97892, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57988, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79056, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 123976, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 123976, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57556, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79396, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124804, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124804, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56980, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77436, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 123464, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 123464, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.0625GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:01')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57016, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78264, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 123808, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 123808, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 6.625GHz; S Matrix Error =   1.619%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 4.1875GHz; S Matrix Error =   0.240%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.5625GHz; S Matrix Error =   0.082%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 6.0625GHz; S Matrix Error =   0.296%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97924, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57856, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79204, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 125112, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 125112, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57404, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77748, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 123416, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 123416, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57048, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77876, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124248, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124248, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.96875GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:01')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56684, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77888, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6155, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124000, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36455, false, 3, \'Matrix bandwidth\', 19.6412, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124000, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 6.8125GHz; S Matrix Error =   0.346%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 6.4375GHz; S Matrix Error =   0.153%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 15, Frequency: 6.15625GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 98000, 'I(1, 0, \'Frequency Group #4; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'52.8 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:10\', 1, \'Average memory/process\', \'202 MB\', 1, \'Max memory/process\', \'202 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:19\', 1, \'Average memory/process\', \'121 MB\', 1, \'Max memory/process\', \'123 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 6155, false, 2, \'Max matrix size\', 36455, false, 1, \'Matrix bandwidth\', \'19.6\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/18/2023 22:44:23\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
