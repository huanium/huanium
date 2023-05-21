$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/20/2023 21:27:23')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:01:19')
			I(1, 'ComEngine Memory', '93.4 M')
		$end 'TotalInfo'
		GroupOptions=8
		TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Executing from C:\\\\Program Files\\\\AnsysEM\\\\Ansys Student\\\\v222\\\\Win64\\\\HFSSCOMENGINE.exe\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC\', \'Enabled\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'Allow off core\', \'True\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC settings\', \'Auto\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Machines:\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'DESKTOP-9GEMUKL [31.9 GB]: RAM Limit: 90.000000%, 4 cores, Free Disk Space: 471 GB\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'Solution Basis Order\', \'1\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 88 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:27:23')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:04')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 1, 0, 60000, 'I(1, 2, \'Tetrahedra\', 19623, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 60000, 'I(1, 2, \'Tetrahedra\', 6421, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 39712, 'I(1, 2, \'Tetrahedra\', 9587, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 50336, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 64936, 'I(2, 1, \'Disk\', \'82.9 KB\', 2, \'Tetrahedra\', 7033, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 37756, 'I(1, 2, \'Tetrahedra\', 9977, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:27:27')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:21')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 1'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:27:27')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 53704, 'I(2, 1, \'Disk\', \'4.35 KB\', 2, \'Tetrahedra\', 7234, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 114656, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7234, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 234700, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 42508, false, 3, \'Matrix bandwidth\', 18.9369, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 234700, 'I(2, 1, \'Disk\', \'1.3 MB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92140, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:27:29')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 41120, 'I(1, 2, \'Tetrahedra\', 12148, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57384, 'I(2, 1, \'Disk\', \'4.35 KB\', 2, \'Tetrahedra\', 9177, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 134980, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9177, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 3, 0, 308100, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 54426, false, 3, \'Matrix bandwidth\', 19.412, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 308100, 'I(2, 1, \'Disk\', \'813 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92216, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.308984, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:27:33')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:05')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 43040, 'I(1, 2, \'Tetrahedra\', 14902, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 62160, 'I(2, 1, \'Disk\', \'7.71 KB\', 2, \'Tetrahedra\', 11741, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 163052, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 11741, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 5, 0, 401276, 'I(3, 1, \'Disk\', \'5 Bytes\', 2, \'Matrix size\', 70314, false, 3, \'Matrix bandwidth\', 19.8964, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 401276, 'I(2, 1, \'Disk\', \'925 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92252, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.103806, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:27:38')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:05')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 44416, 'I(1, 2, \'Tetrahedra\', 16940, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 64880, 'I(2, 1, \'Disk\', \'7.71 KB\', 2, \'Tetrahedra\', 13608, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 183112, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13608, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 6, 0, 476264, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 81850, false, 3, \'Matrix bandwidth\', 20.1137, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 476264, 'I(2, 1, \'Disk\', \'889 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92268, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0314186, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 5'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:27:43')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:05')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 45768, 'I(1, 2, \'Tetrahedra\', 18635, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 67212, 'I(2, 1, \'Disk\', \'7.71 KB\', 2, \'Tetrahedra\', 15137, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 199164, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 7, 0, 531932, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 531932, 'I(2, 1, \'Disk\', \'885 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92272, 'I(1, 0, \'Adaptive Pass 5\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0142898, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:27:48')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:53')
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
					I(1, 'Time', '05/20/2023 21:27:48')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:53')
				$end 'TotalInfo'
				GroupOptions=4
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'From 4GHz to 8GHz, 401 Frequencies\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 8GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 76272, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 120872, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 242528, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 242528, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 76208, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 120768, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 242224, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 242224, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 75352, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 119924, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 241988, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 241988, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 74604, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 119136, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 240092, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 240092, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 8GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 6GHz; S Matrix Error =  59.198%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 5GHz; S Matrix Error =  91.057%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 5.64GHz; S Matrix Error =  76.708%\')', false, true)
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
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 76124, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 120804, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 242208, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 242208, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.82GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 76072, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 120744, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 241904, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 241904, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.32GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 74540, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 119128, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 239396, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 239396, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73700, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 118220, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 239448, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 239448, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 7GHz; S Matrix Error =  34.359%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 5.82GHz; S Matrix Error =  37.918%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.32GHz; S Matrix Error =  53.775%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 4.5GHz; S Matrix Error =  20.475%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94860, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 75992, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 120696, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 241276, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 241276, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 75812, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 120428, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 240576, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 240576, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 74420, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 119620, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 238608, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 238608, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.16GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73732, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 118304, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 239240, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 239240, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 6.5GHz; S Matrix Error =  18.907%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.75GHz; S Matrix Error =   6.761%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 4.25GHz; S Matrix Error =   7.001%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 5.16GHz; S Matrix Error =   7.159%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94908, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 76088, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 121384, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 242732, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 242732, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 75284, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 119844, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 241212, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 241212, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73784, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 118276, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 240868, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 240868, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.08GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73260, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 117844, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 239112, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 239112, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 7.5GHz; S Matrix Error =   7.003%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 15, Frequency: 6.75GHz; S Matrix Error =   6.612%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 16, Frequency: 6.25GHz; S Matrix Error =   7.331%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 17, Frequency: 5.08GHz; S Matrix Error =   7.146%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94936, 'I(1, 0, \'Frequency Group #4; Interpolating frequency sweep\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 76096, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 121980, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 241380, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 241380, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 75908, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 120612, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 242656, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 242656, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.875GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 74408, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 119796, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 240508, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 240508, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.625GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 74100, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 118940, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 240268, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 240268, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 18, Frequency: 7.75GHz; S Matrix Error =   2.569%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 19, Frequency: 7.25GHz; S Matrix Error =   0.860%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 20, Frequency: 6.875GHz; S Matrix Error =   0.237%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 21, Frequency: 6.625GHz; S Matrix Error =   0.103%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95048, 'I(1, 0, \'Frequency Group #5; Interpolating frequency sweep\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.625GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #6\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 76024, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 120712, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 242196, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 242196, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.375GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #6\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 76232, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 121484, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 242312, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 242312, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.875GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #6\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 74764, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 119740, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 240256, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 240256, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.125GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:06')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #6\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73624, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 119292, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 15137, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 4, 0, 4, 0, 239120, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 91226, false, 3, \'Matrix bandwidth\', 20.2334, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 239120, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 22, Frequency: 7.625GHz; S Matrix Error =   0.073%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 23, Frequency: 7.375GHz; S Matrix Error =   0.055%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 24, Frequency: 7.875GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95140, 'I(1, 0, \'Frequency Group #6; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'88 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:04\', 1, \'Total Memory\', \'63.4 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:21\', 1, \'Average memory/process\', \'519 MB\', 1, \'Max memory/process\', \'519 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:53\', 1, \'Average memory/process\', \'235 MB\', 1, \'Max memory/process\', \'237 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 15137, false, 2, \'Max matrix size\', 91226, false, 1, \'Matrix bandwidth\', \'20.2\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/20/2023 21:28:42\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
