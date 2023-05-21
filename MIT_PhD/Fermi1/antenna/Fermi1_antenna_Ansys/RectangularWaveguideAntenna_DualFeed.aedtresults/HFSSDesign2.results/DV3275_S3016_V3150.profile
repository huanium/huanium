$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/20/2023 21:53:58')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:01:09')
			I(1, 'ComEngine Memory', '95.8 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 90.3 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:53:58')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 2, 0, 56000, 'I(1, 2, \'Tetrahedra\', 14208, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 56000, 'I(1, 2, \'Tetrahedra\', 5152, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 37208, 'I(1, 2, \'Tetrahedra\', 7087, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 46684, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 60052, 'I(2, 1, \'Disk\', \'82.2 KB\', 2, \'Tetrahedra\', 4836, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 35688, 'I(1, 2, \'Tetrahedra\', 7437, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:54:02')
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
					I(1, 'Time', '05/20/2023 21:54:02')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 49072, 'I(2, 1, \'Disk\', \'3.96 KB\', 2, \'Tetrahedra\', 5021, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 91736, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5021, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 143268, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 28536, false, 3, \'Matrix bandwidth\', 18.1018, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 143268, 'I(2, 1, \'Disk\', \'915 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94440, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:54:05')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 38412, 'I(1, 2, \'Tetrahedra\', 8950, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 52192, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 6345, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105904, 'I(4, 1, \'Disk\', \'4 Bytes\', 2, \'Tetrahedra\', 6345, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 183912, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 36560, false, 3, \'Matrix bandwidth\', 18.6973, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 183912, 'I(2, 1, \'Disk\', \'551 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94560, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.133545, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:54:08')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 39752, 'I(1, 2, \'Tetrahedra\', 10854, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 54592, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 8086, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 124288, 'I(4, 1, \'Disk\', \'4 Bytes\', 2, \'Tetrahedra\', 8086, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 3, 0, 258420, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 47320, false, 3, \'Matrix bandwidth\', 19.3174, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 258420, 'I(2, 1, \'Disk\', \'626 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94608, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0985249, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:54:12')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 42088, 'I(1, 2, \'Tetrahedra\', 13281, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60128, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 10287, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 147224, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10287, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 4, 0, 336836, 'I(3, 1, \'Disk\', \'4 Bytes\', 2, \'Matrix size\', 60820, false, 3, \'Matrix bandwidth\', 19.7425, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 336836, 'I(2, 1, \'Disk\', \'716 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94660, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0253923, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 5'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:54:15')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:05')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 45048, 'I(1, 2, \'Tetrahedra\', 16240, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 64496, 'I(2, 1, \'Disk\', \'7.29 KB\', 2, \'Tetrahedra\', 13013, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 177080, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 6, 0, 450468, 'I(3, 1, \'Disk\', \'3 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 450468, 'I(2, 1, \'Disk\', \'825 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94680, 'I(1, 0, \'Adaptive Pass 5\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.012697, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:54:24')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:44')
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
					I(1, 'Time', '05/20/2023 21:54:24')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:44')
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
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 72432, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 111956, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 215024, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 215024, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 72548, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 111832, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 215380, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 215380, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71196, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110980, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 213580, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 213580, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70376, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110780, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 211716, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 211716, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 8GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 6GHz; S Matrix Error =  73.440%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 5GHz; S Matrix Error =  84.994%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 5.64GHz; S Matrix Error = 128.379%\')', false, true)
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
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 72480, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 112668, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 215252, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 215252, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.82GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 72344, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 111560, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 214696, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 214696, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.32GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70904, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110104, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 213488, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 213488, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70160, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110444, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 212120, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 212120, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 7GHz; S Matrix Error =  92.763%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 5.82GHz; S Matrix Error =  50.044%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.32GHz; S Matrix Error =  25.157%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 4.5GHz; S Matrix Error =   5.989%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97392, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
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
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 72536, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 112392, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 215200, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 215200, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 72040, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 111092, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 213508, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 213508, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70544, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110352, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 212816, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 212816, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.5GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69920, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 109932, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 212608, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 212608, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 7.5GHz; S Matrix Error =   2.671%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.25GHz; S Matrix Error =   0.130%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 4.75GHz; S Matrix Error =   0.251%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 6.5GHz; S Matrix Error =   0.796%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97464, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 72480, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 113128, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 215292, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 215292, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71988, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 111236, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 214736, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 214736, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.75GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70516, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110972, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 211904, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 211904, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 6.25GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69980, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110460, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 212480, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 212480, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 7.75GHz; S Matrix Error =   0.909%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 15, Frequency: 7.25GHz; S Matrix Error =   0.592%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 16, Frequency: 6.75GHz; S Matrix Error =   0.172%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 17, Frequency: 6.25GHz; S Matrix Error =   0.057%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97596, 'I(1, 0, \'Frequency Group #4; Interpolating frequency sweep\')', true, true)
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
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 72560, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 113180, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 215088, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 215088, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.875GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 72232, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 111692, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 214020, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 214020, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.375GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70728, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110376, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 213188, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 213188, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.125GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:05')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69896, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110572, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13013, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 100, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 212440, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 77666, false, 3, \'Matrix bandwidth\', 20.1102, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 212440, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 18, Frequency: 6.375GHz; S Matrix Error =   0.052%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 19, Frequency: 7.875GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97636, 'I(1, 0, \'Frequency Group #5; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'90.3 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'58.6 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:21\', 1, \'Average memory/process\', \'440 MB\', 1, \'Max memory/process\', \'440 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:44\', 1, \'Average memory/process\', \'209 MB\', 1, \'Max memory/process\', \'210 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 13013, false, 2, \'Max matrix size\', 77666, false, 1, \'Matrix bandwidth\', \'20.1\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/20/2023 21:55:08\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
