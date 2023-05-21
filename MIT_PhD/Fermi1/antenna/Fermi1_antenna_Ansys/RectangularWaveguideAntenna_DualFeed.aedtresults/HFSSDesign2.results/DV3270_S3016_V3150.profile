$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/20/2023 21:50:16')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:40')
			I(1, 'ComEngine Memory', '94.9 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 89.4 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:50:16')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 2, 0, 56000, 'I(1, 2, \'Tetrahedra\', 14228, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 56000, 'I(1, 2, \'Tetrahedra\', 5155, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 37324, 'I(1, 2, \'Tetrahedra\', 7121, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 47100, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 60624, 'I(2, 1, \'Disk\', \'82.2 KB\', 2, \'Tetrahedra\', 4864, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 35940, 'I(1, 2, \'Tetrahedra\', 7490, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:50:20')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:15')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 1'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:50:20')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 49072, 'I(2, 1, \'Disk\', \'3.96 KB\', 2, \'Tetrahedra\', 5057, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 91620, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5057, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 142476, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 28726, false, 3, \'Matrix bandwidth\', 18.1145, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 142476, 'I(2, 1, \'Disk\', \'911 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 93588, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:50:23')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 38328, 'I(1, 2, \'Tetrahedra\', 9009, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 52456, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 6428, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106904, 'I(4, 1, \'Disk\', \'6 Bytes\', 2, \'Tetrahedra\', 6428, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 189680, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 37088, false, 3, \'Matrix bandwidth\', 18.7425, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 189680, 'I(2, 1, \'Disk\', \'549 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 93720, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.111917, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:50:26')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 38604, 'I(1, 2, \'Tetrahedra\', 10108, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 53656, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 7424, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 116864, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Tetrahedra\', 7424, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 227172, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43210, false, 3, \'Matrix bandwidth\', 19.1358, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 227172, 'I(2, 1, \'Disk\', \'526 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 93748, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.077205, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:50:29')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 41096, 'I(1, 2, \'Tetrahedra\', 12339, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57116, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 9399, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 136748, 'I(4, 1, \'Disk\', \'4 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 3, 0, 307876, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 307876, 'I(2, 1, \'Disk\', \'668 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 93752, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0146337, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:50:36')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:21')
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
					I(1, 'Time', '05/20/2023 21:50:36')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:21')
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
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66520, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 95556, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 167780, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 167780, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 65676, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 96216, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 167008, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 167008, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 64856, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 93644, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 166272, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 166272, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 64152, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 92996, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 165832, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 165832, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 8GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 6GHz; S Matrix Error =  71.308%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 5GHz; S Matrix Error =  86.487%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 5.64GHz; S Matrix Error = 100.192%\')', false, true)
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
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66296, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 95828, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 167820, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 167820, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.82GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66256, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 95088, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 167324, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 167324, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.32GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 64692, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 94092, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 165884, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 165884, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 63948, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 93052, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 165484, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 165484, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 7GHz; S Matrix Error =  67.773%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 5.82GHz; S Matrix Error =  55.172%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.32GHz; S Matrix Error =  30.711%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 4.5GHz; S Matrix Error =   5.823%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 96508, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
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
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66324, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 94896, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 167880, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 167880, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 65960, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 95372, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 167360, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 167360, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 64292, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 93712, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 165868, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 165868, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 63560, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 93144, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 164932, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 164932, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 7.5GHz; S Matrix Error =   2.369%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.25GHz; S Matrix Error =   0.126%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 4.75GHz; S Matrix Error =   0.256%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 6.5GHz; S Matrix Error =   0.848%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 96596, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66096, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 95756, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 167748, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 167748, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 65848, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 96096, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 166976, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 166976, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 64360, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 93904, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 165680, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 165680, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 63884, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 92612, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 9399, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 165048, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 55276, false, 3, \'Matrix bandwidth\', 19.5817, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 165048, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 7.75GHz; S Matrix Error =   0.811%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 15, Frequency: 7.25GHz; S Matrix Error =   0.391%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 16, Frequency: 6.75GHz; S Matrix Error =   0.153%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 17, Frequency: 6.25GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 96728, 'I(1, 0, \'Frequency Group #4; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'89.4 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'59.2 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:15\', 1, \'Average memory/process\', \'301 MB\', 1, \'Max memory/process\', \'301 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:21\', 1, \'Average memory/process\', \'163 MB\', 1, \'Max memory/process\', \'164 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 9399, false, 2, \'Max matrix size\', 55276, false, 1, \'Matrix bandwidth\', \'19.6\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/20/2023 21:50:57\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
