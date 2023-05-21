$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/20/2023 21:52:15')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:54')
			I(1, 'ComEngine Memory', '95 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 89.5 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:52:15')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 2, 0, 56000, 'I(1, 2, \'Tetrahedra\', 14238, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 56000, 'I(1, 2, \'Tetrahedra\', 5151, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 37432, 'I(1, 2, \'Tetrahedra\', 7145, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 47028, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 60948, 'I(2, 1, \'Disk\', \'84.2 KB\', 2, \'Tetrahedra\', 4918, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 35676, 'I(1, 2, \'Tetrahedra\', 7571, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:52:19')
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
					I(1, 'Time', '05/20/2023 21:52:19')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 48620, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 5145, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 91808, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5145, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 145976, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 29266, false, 3, \'Matrix bandwidth\', 18.1643, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 145976, 'I(2, 1, \'Disk\', \'921 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 93692, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:52:22')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 38268, 'I(1, 2, \'Tetrahedra\', 9117, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 52732, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 6528, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107768, 'I(4, 1, \'Disk\', \'6 Bytes\', 2, \'Tetrahedra\', 6528, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 192936, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 37696, false, 3, \'Matrix bandwidth\', 18.8115, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 192936, 'I(2, 1, \'Disk\', \'552 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 93752, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.12758, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:52:26')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 40556, 'I(1, 2, \'Tetrahedra\', 11078, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 54928, 'I(2, 1, \'Disk\', \'3.96 KB\', 2, \'Tetrahedra\', 8282, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 124696, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 8282, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 3, 0, 258092, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 48446, false, 3, \'Matrix bandwidth\', 19.3611, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 258092, 'I(2, 1, \'Disk\', \'622 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 93792, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0497911, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:52:29')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 42112, 'I(1, 2, \'Tetrahedra\', 13490, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60284, 'I(2, 1, \'Disk\', \'3.96 KB\', 2, \'Tetrahedra\', 10462, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 149056, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 4, 0, 349992, 'I(3, 1, \'Disk\', \'4 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 349992, 'I(2, 1, \'Disk\', \'709 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 93832, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.011591, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:52:35')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:34')
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
					I(1, 'Time', '05/20/2023 21:52:35')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:34')
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 68232, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 99888, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 194636, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 194636, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 67884, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 99692, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 194608, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 194608, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66436, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 98464, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 192940, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 192940, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 65968, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 97760, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 191664, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 191664, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 8GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 6GHz; S Matrix Error =  73.835%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 5GHz; S Matrix Error =  84.599%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 5.64GHz; S Matrix Error = 130.711%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 68196, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 100268, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 194012, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 194012, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 67848, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 99772, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 193400, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 193400, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66556, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 98316, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 192752, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 192752, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 65816, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 97564, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 192224, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 192224, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 7GHz; S Matrix Error =  93.218%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 5.82GHz; S Matrix Error =  47.989%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.32GHz; S Matrix Error =  24.664%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 4.5GHz; S Matrix Error =   6.098%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 96512, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 68552, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 99856, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 195424, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 195424, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 67904, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 99772, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 194076, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 194076, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66200, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 97440, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 192292, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 192292, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66308, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 97780, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 193008, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 193008, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 7.5GHz; S Matrix Error =   2.591%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.25GHz; S Matrix Error =   0.120%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 4.75GHz; S Matrix Error =   0.251%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 6.5GHz; S Matrix Error =   0.765%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 96672, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 67704, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 100256, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 194196, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 194196, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 67380, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 99588, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 193656, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 193656, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66324, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 98760, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 192616, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 192616, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66004, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 97772, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 191996, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 191996, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 7.75GHz; S Matrix Error =   1.026%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 15, Frequency: 7.25GHz; S Matrix Error =   0.752%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 16, Frequency: 6.75GHz; S Matrix Error =   0.182%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 17, Frequency: 6.25GHz; S Matrix Error =   0.062%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 96680, 'I(1, 0, \'Frequency Group #4; Interpolating frequency sweep\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.375GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 68188, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 100012, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 194464, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 194464, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.875GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 67668, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 99328, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 194292, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 194292, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.375GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66588, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 98820, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 193252, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 193252, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.125GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:03')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 66076, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 97836, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10462, false, 2, \'1 triangles\', 118, false, 2, \'2 triangles\', 118, false)', true, false)
					ProfileItem('Solver DCS1', 2, 0, 2, 0, 192504, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 61836, false, 3, \'Matrix bandwidth\', 19.7709, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 192504, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 18, Frequency: 6.375GHz; S Matrix Error =   0.052%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 19, Frequency: 7.875GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 96788, 'I(1, 0, \'Frequency Group #5; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'89.5 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'59.5 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:15\', 1, \'Average memory/process\', \'342 MB\', 1, \'Max memory/process\', \'342 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:34\', 1, \'Average memory/process\', \'189 MB\', 1, \'Max memory/process\', \'191 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 10462, false, 2, \'Max matrix size\', 61836, false, 1, \'Matrix bandwidth\', \'19.8\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/20/2023 21:53:10\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
