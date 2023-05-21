$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/18/2023 22:29:23')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:35')
			I(1, 'ComEngine Memory', '96.2 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 90.6 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:29:23')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 1, 0, 49000, 'I(1, 2, \'Tetrahedra\', 10125, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 49000, 'I(1, 2, \'Tetrahedra\', 3464, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 33944, 'I(1, 2, \'Tetrahedra\', 4357, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 41588, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 54424, 'I(2, 1, \'Disk\', \'42.5 KB\', 2, \'Tetrahedra\', 2967, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 32916, 'I(1, 2, \'Tetrahedra\', 4583, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:29:26')
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
					I(1, 'Time', '05/18/2023 22:29:26')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 42884, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 3085, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 71080, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 3085, false, 2, \'1 triangles\', 117, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 0, 0, 107780, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 17701, false, 3, \'Matrix bandwidth\', 18.0781, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 107780, 'I(2, 1, \'Disk\', \'491 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95020, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:29:29')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 34508, 'I(1, 2, \'Tetrahedra\', 5510, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 45108, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 3907, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80804, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 3907, false, 2, \'1 triangles\', 117, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 131188, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 22717, false, 3, \'Matrix bandwidth\', 18.6949, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 131188, 'I(2, 1, \'Disk\', \'269 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95112, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.178175, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:29:31')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 35272, 'I(1, 2, \'Tetrahedra\', 6684, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 46924, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 4970, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 92520, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 4970, false, 2, \'1 triangles\', 117, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 164184, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 29253, false, 3, \'Matrix bandwidth\', 19.2536, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 164184, 'I(2, 1, \'Disk\', \'316 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95220, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.116012, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:29:34')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 36880, 'I(1, 2, \'Tetrahedra\', 8178, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 49132, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 6301, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105912, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6301, false, 2, \'1 triangles\', 117, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 215356, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 37399, false, 3, \'Matrix bandwidth\', 19.6808, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 215356, 'I(2, 1, \'Disk\', \'370 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95260, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0390186, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 5'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:29:37')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 37344, 'I(1, 2, \'Tetrahedra\', 9377, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 51564, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 7368, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 116524, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 251984, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 251984, 'I(2, 1, \'Disk\', \'364 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95284, 'I(1, 0, \'Adaptive Pass 5\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0117997, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:29:40')
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
					I(1, 'Time', '05/18/2023 22:29:40')
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60652, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 85136, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141904, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141904, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60532, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 84348, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141600, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141600, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59320, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 83276, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 140260, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 140260, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58388, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 82140, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 138820, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 138820, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 7GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 5.5GHz; S Matrix Error =  54.562%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 4.75GHz; S Matrix Error =  91.536%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60084, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 84164, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 141080, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 141080, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59796, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 83500, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 140844, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 140844, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59012, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 83024, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 139356, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 139356, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58600, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 82460, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 138932, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 138932, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 6.25GHz; S Matrix Error =  53.331%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 5.125GHz; S Matrix Error =  55.842%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 4.375GHz; S Matrix Error =   8.136%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.875GHz; S Matrix Error =   6.430%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97800, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60392, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 84380, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 140860, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 140860, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60340, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 84844, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 140904, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 140904, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59440, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 83476, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 139796, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 139796, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58644, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 82696, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 139444, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 139444, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 6.625GHz; S Matrix Error =   4.049%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 4.5625GHz; S Matrix Error =   0.274%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 6.0625GHz; S Matrix Error =   0.122%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 4.9375GHz; S Matrix Error =   0.086%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97896, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60232, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 84584, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 140908, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 140908, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59920, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 84024, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 140588, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 140588, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 4.84375GHz'
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59360, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 83436, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 139836, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 139836, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 5.03125GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:02')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 59056, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 83364, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 7368, false, 2, \'1 triangles\', 117, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 139408, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 43941, false, 3, \'Matrix bandwidth\', 19.9013, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 139408, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 6.8125GHz; S Matrix Error =   0.186%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 5.3125GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'90.6 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'53.1 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:13\', 1, \'Average memory/process\', \'246 MB\', 1, \'Max memory/process\', \'246 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:19\', 1, \'Average memory/process\', \'137 MB\', 1, \'Max memory/process\', \'139 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 7368, false, 2, \'Max matrix size\', 43941, false, 1, \'Matrix bandwidth\', \'19.9\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/18/2023 22:29:59\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
