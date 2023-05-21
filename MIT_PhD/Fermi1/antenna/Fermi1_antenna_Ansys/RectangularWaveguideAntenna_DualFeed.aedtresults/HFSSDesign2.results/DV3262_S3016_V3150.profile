$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/20/2023 21:47:47')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:52')
			I(1, 'ComEngine Memory', '95.6 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 90.2 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:47:47')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 2, 0, 55000, 'I(1, 2, \'Tetrahedra\', 13580, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 55000, 'I(1, 2, \'Tetrahedra\', 5113, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 37452, 'I(1, 2, \'Tetrahedra\', 7092, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 46860, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 60448, 'I(2, 1, \'Disk\', \'83.7 KB\', 2, \'Tetrahedra\', 4843, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 35796, 'I(1, 2, \'Tetrahedra\', 7503, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:47:51')
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
					I(1, 'Time', '05/20/2023 21:47:51')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 49260, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 5061, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 92252, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 144124, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 28758, false, 3, \'Matrix bandwidth\', 18.1375, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 144124, 'I(2, 1, \'Disk\', \'914 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94412, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:47:54')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 38128, 'I(1, 2, \'Tetrahedra\', 9025, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 52688, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 6428, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106692, 'I(4, 1, \'Disk\', \'6 Bytes\', 2, \'Tetrahedra\', 6428, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 189088, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 37092, false, 3, \'Matrix bandwidth\', 18.7588, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 189088, 'I(2, 1, \'Disk\', \'552 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94568, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.20117, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:47:57')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 38712, 'I(1, 2, \'Tetrahedra\', 10191, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 53620, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 7497, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 117592, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7497, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 233348, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43700, false, 3, \'Matrix bandwidth\', 19.1717, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 233348, 'I(2, 1, \'Disk\', \'539 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94576, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0739553, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:48:00')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 41164, 'I(1, 2, \'Tetrahedra\', 12415, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57592, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 9473, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 138364, 'I(4, 1, \'Disk\', \'4 Bytes\', 2, \'Tetrahedra\', 9473, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 3, 0, 299052, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55776, false, 3, \'Matrix bandwidth\', 19.607, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 299052, 'I(2, 1, \'Disk\', \'672 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94576, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0221265, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 5'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:48:04')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:05')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 44120, 'I(1, 2, \'Tetrahedra\', 15257, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 63064, 'I(2, 1, \'Disk\', \'7.29 KB\', 2, \'Tetrahedra\', 12061, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 165780, 'I(4, 1, \'Disk\', \'4 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 5, 0, 406460, 'I(3, 1, \'Disk\', \'4 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 406460, 'I(2, 1, \'Disk\', \'790 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94580, 'I(1, 0, \'Adaptive Pass 5\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0146014, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:48:12')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:27')
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
					I(1, 'Time', '05/20/2023 21:48:12')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:27')
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
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71324, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 109132, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 206224, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 206224, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70780, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106860, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205116, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205116, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69244, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105964, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 204036, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 204036, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 68820, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105500, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203176, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203176, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 8GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 6GHz; S Matrix Error =  80.353%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 5GHz; S Matrix Error =  84.508%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 5.64GHz; S Matrix Error =  49.656%\')', false, true)
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
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70320, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107428, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 204932, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 204932, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.82GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70656, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108124, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205068, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205068, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.32GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69508, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107140, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 204452, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 204452, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 68604, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 104748, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 202604, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 202604, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 7GHz; S Matrix Error =  47.792%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 5.82GHz; S Matrix Error =  41.185%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.32GHz; S Matrix Error =  17.612%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 4.5GHz; S Matrix Error =  11.721%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97228, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
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
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70968, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108544, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205292, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205292, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70640, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107512, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 204772, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 204772, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69296, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106156, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203680, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203680, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 68656, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106480, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203612, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203612, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 7.5GHz; S Matrix Error =   9.296%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 6.5GHz; S Matrix Error =   2.375%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 4.75GHz; S Matrix Error =   2.439%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 4.25GHz; S Matrix Error =   0.802%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97312, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71164, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108340, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205792, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205792, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70928, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108112, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205556, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205556, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69436, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106584, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203916, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203916, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 68832, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105872, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12061, false, 2, \'1 triangles\', 108, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203692, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71732, false, 3, \'Matrix bandwidth\', 19.979, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203692, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 7.75GHz; S Matrix Error =   0.657%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 15, Frequency: 7.25GHz; S Matrix Error =   0.574%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 16, Frequency: 6.75GHz; S Matrix Error =   0.252%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 17, Frequency: 6.25GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97380, 'I(1, 0, \'Frequency Group #4; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'90.2 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'59 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:21\', 1, \'Average memory/process\', \'397 MB\', 1, \'Max memory/process\', \'397 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:27\', 1, \'Average memory/process\', \'200 MB\', 1, \'Max memory/process\', \'201 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 12061, false, 2, \'Max matrix size\', 71732, false, 1, \'Matrix bandwidth\', \'20.0\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/20/2023 21:48:40\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
