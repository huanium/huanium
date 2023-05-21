$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/20/2023 18:33:26')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:53')
			I(1, 'ComEngine Memory', '93.1 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 87.4 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 18:33:26')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:04')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 2, 0, 56000, 'I(1, 2, \'Tetrahedra\', 14181, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 56000, 'I(1, 2, \'Tetrahedra\', 5248, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 37136, 'I(1, 2, \'Tetrahedra\', 7213, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 47148, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 61084, 'I(2, 1, \'Disk\', \'83.6 KB\', 2, \'Tetrahedra\', 4935, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 35848, 'I(1, 2, \'Tetrahedra\', 7611, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 18:33:30')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:20')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 1'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 18:33:30')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 49656, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 5148, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 91436, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5148, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 145848, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 29260, false, 3, \'Matrix bandwidth\', 18.1553, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 145848, 'I(2, 1, \'Disk\', \'926 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 91720, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 18:33:33')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 38280, 'I(1, 2, \'Tetrahedra\', 9161, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 52576, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 6540, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107516, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6540, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 194320, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 37748, false, 3, \'Matrix bandwidth\', 18.7753, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 194320, 'I(2, 1, \'Disk\', \'558 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 91840, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.14588, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 18:33:36')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 40592, 'I(1, 2, \'Tetrahedra\', 11130, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 55008, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 8316, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 126224, 'I(4, 1, \'Disk\', \'4 Bytes\', 2, \'Tetrahedra\', 8316, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 3, 0, 254496, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 48664, false, 3, \'Matrix bandwidth\', 19.3619, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 254496, 'I(2, 1, \'Disk\', \'630 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 91860, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0886104, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 18:33:40')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 42236, 'I(1, 2, \'Tetrahedra\', 13625, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60416, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 10553, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 149444, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10553, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 4, 0, 357236, 'I(3, 1, \'Disk\', \'4 Bytes\', 2, \'Matrix size\', 62408, false, 3, \'Matrix bandwidth\', 19.7748, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 357236, 'I(2, 1, \'Disk\', \'722 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 91884, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0201595, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 5'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 18:33:43')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:05')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 43468, 'I(1, 2, \'Tetrahedra\', 15268, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 63108, 'I(2, 1, \'Disk\', \'6.91 KB\', 2, \'Tetrahedra\', 12064, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 165372, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 5, 0, 404452, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 404452, 'I(2, 1, \'Disk\', \'673 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 91908, 'I(1, 0, \'Adaptive Pass 5\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0101547, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 18:33:51')
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
					I(1, 'Time', '05/20/2023 18:33:51')
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71344, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108292, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205160, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205160, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71184, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107704, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205472, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205472, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69492, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105904, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203768, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203768, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 68744, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 104864, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 202592, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 202592, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 8GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 6GHz; S Matrix Error =  75.694%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 5GHz; S Matrix Error =  83.787%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 5.64GHz; S Matrix Error =  76.192%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70892, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106956, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 204776, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 204776, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70528, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107132, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 204188, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 204188, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69580, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106304, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 202712, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 202712, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69428, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105672, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203280, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203280, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 7GHz; S Matrix Error =  62.672%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 5.82GHz; S Matrix Error =  46.824%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.32GHz; S Matrix Error =  21.675%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 4.5GHz; S Matrix Error =   6.710%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94708, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71296, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107260, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205576, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205576, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70952, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107284, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205032, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205032, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69480, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106272, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203136, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203136, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69044, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105376, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 202484, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 202484, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 7.5GHz; S Matrix Error =   3.356%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.25GHz; S Matrix Error =   0.166%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 4.75GHz; S Matrix Error =   0.256%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 6.5GHz; S Matrix Error =   0.803%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94748, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71300, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107664, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205416, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205416, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71176, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107032, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205440, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205440, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69700, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106772, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203924, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203924, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69284, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105476, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 202708, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 202708, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 7.75GHz; S Matrix Error =   1.060%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 15, Frequency: 7.25GHz; S Matrix Error =   0.734%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 16, Frequency: 6.75GHz; S Matrix Error =   0.141%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 17, Frequency: 6.25GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94860, 'I(1, 0, \'Frequency Group #4; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'87.4 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:04\', 1, \'Total Memory\', \'59.6 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:20\', 1, \'Average memory/process\', \'395 MB\', 1, \'Max memory/process\', \'395 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:27\', 1, \'Average memory/process\', \'199 MB\', 1, \'Max memory/process\', \'201 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 12064, false, 2, \'Max matrix size\', 71710, false, 1, \'Matrix bandwidth\', \'20.0\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/20/2023 18:34:19\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/20/2023 22:14:50')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:12')
			I(1, 'ComEngine Memory', '91 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 85.5 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Adaptive Passes converged\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 22:14:55')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:07')
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
					I(1, 'Time', '05/20/2023 22:14:55')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:07')
				$end 'TotalInfo'
				GroupOptions=4
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'From 4GHz to 8GHz, 401 Frequencies\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 8GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 6GHz; S Matrix Error =  75.694%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 5GHz; S Matrix Error =  83.787%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 7GHz; S Matrix Error =  25.106%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 4.5GHz; S Matrix Error =  28.213%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 6.5GHz; S Matrix Error =  12.349%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 6.25GHz; S Matrix Error =  10.813%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 4.75GHz; S Matrix Error =   9.258%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 4.25GHz; S Matrix Error =   7.094%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 7.5GHz; S Matrix Error =   4.652%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 6.75GHz; S Matrix Error =   0.428%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 7.75GHz; S Matrix Error =   0.567%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 7.25GHz; S Matrix Error =   0.295%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 15, Frequency: 5.32GHz; S Matrix Error =   0.217%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 16, Frequency: 5.64GHz; S Matrix Error =   0.133%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 17, Frequency: 5.82GHz; S Matrix Error =   0.094%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Using previously solved data. Additional simulations must be performed to correct interpolating sweep convergence or passivity\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
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
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70364, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106992, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 204328, 'I(4, 1, \'Disk\', \'793 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 204328, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69852, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106788, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203928, 'I(4, 1, \'Disk\', \'793 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203928, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.625GHz'
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69344, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105492, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203244, 'I(4, 1, \'Disk\', \'793 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203244, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 7.125GHz'
					$begin 'StartInfo'
						I(0, 'DESKTOP-9GEMUKL')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:04')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69080, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 104956, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12064, false, 2, \'1 triangles\', 114, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203192, 'I(4, 1, \'Disk\', \'793 Bytes\', 2, \'Matrix size\', 71710, false, 3, \'Matrix bandwidth\', 19.964, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203192, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 18, Frequency: 7.875GHz; S Matrix Error =   0.062%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 19, Frequency: 7.375GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 92780, 'I(1, 0, \'Frequency Group #1; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'85.5 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'0 Bytes\')', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:07\', 1, \'Average memory/process\', \'199 MB\', 1, \'Max memory/process\', \'200 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 12064, false, 2, \'Max matrix size\', 71710, false, 1, \'Matrix bandwidth\', \'20.0\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/20/2023 22:15:02\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
