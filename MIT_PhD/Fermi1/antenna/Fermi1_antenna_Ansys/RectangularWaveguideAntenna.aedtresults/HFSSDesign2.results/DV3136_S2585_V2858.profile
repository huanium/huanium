$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/18/2023 23:04:52')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:28')
			I(1, 'ComEngine Memory', '96.6 M')
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
				I(1, 'Time', '05/18/2023 23:04:52')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 1, 0, 48000, 'I(1, 2, \'Tetrahedra\', 9318, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 48000, 'I(1, 2, \'Tetrahedra\', 3199, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 33644, 'I(1, 2, \'Tetrahedra\', 4086, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 41208, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 53504, 'I(2, 1, \'Disk\', \'41.6 KB\', 2, \'Tetrahedra\', 2835, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 32896, 'I(1, 2, \'Tetrahedra\', 4296, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 23:04:56')
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
					I(1, 'Time', '05/18/2023 23:04:56')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 42292, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 2939, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 70584, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 2939, false, 2, \'1 triangles\', 110, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 0, 0, 107208, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 17011, false, 3, \'Matrix bandwidth\', 18.2144, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 107208, 'I(2, 1, \'Disk\', \'474 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95404, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 23:04:58')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 33700, 'I(1, 2, \'Tetrahedra\', 5178, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 44508, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 3767, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79520, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 3767, false, 2, \'1 triangles\', 110, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 133300, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 22147, false, 3, \'Matrix bandwidth\', 18.9153, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 133300, 'I(2, 1, \'Disk\', \'266 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95484, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.164156, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 23:05:01')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 35408, 'I(1, 2, \'Tetrahedra\', 6315, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 46504, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 4778, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 90868, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 4778, false, 2, \'1 triangles\', 110, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 163500, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 28327, false, 3, \'Matrix bandwidth\', 19.4084, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 163500, 'I(2, 1, \'Disk\', \'306 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95496, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0463604, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 23:05:03')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 36432, 'I(1, 2, \'Tetrahedra\', 7750, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 48460, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 6070, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 104976, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 213508, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 213508, 'I(2, 1, \'Disk\', \'360 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95648, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0149889, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 23:05:06')
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
					I(1, 'Time', '05/18/2023 23:05:06')
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57936, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78340, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 126252, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 126252, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57400, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77872, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 127140, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 127140, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:01')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56620, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77128, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124904, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124904, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56340, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 76760, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124544, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124544, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 7GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 5.5GHz; S Matrix Error =  78.145%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 4.75GHz; S Matrix Error = 111.431%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57968, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78428, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 126408, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 126408, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57760, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78220, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 127020, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 127020, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56684, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77120, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124952, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124952, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56084, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 76512, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124488, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124488, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 6.25GHz; S Matrix Error =  16.668%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 5.125GHz; S Matrix Error =  18.533%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 4.375GHz; S Matrix Error =   4.229%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.875GHz; S Matrix Error =   0.690%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 98212, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 5.64GHz; S Matrix Error =   0.141%; Secondary solver criterion is not converged\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57640, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78956, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 126196, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 126196, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56724, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77216, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124948, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124948, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56320, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77124, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124596, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124596, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.1875GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:01')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 55976, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 77400, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6070, false, 2, \'1 triangles\', 110, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 124300, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 36251, false, 3, \'Matrix bandwidth\', 19.8074, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 124300, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 6.625GHz; S Matrix Error =   0.242%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.9375GHz; S Matrix Error =   0.135%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 4.5625GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 98376, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:10\', 1, \'Average memory/process\', \'209 MB\', 1, \'Max memory/process\', \'209 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:14\', 1, \'Average memory/process\', \'123 MB\', 1, \'Max memory/process\', \'124 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 6070, false, 2, \'Max matrix size\', 36251, false, 1, \'Matrix bandwidth\', \'19.8\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/18/2023 23:05:21\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
