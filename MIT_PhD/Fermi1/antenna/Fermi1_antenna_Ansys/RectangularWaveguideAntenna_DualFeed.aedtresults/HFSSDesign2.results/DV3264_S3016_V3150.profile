$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/20/2023 21:49:02')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:59')
			I(1, 'ComEngine Memory', '95.2 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 89.9 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:49:02')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 1, 0, 56000, 'I(1, 2, \'Tetrahedra\', 14256, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 56000, 'I(1, 2, \'Tetrahedra\', 5301, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 37196, 'I(1, 2, \'Tetrahedra\', 7169, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 47036, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 60604, 'I(2, 1, \'Disk\', \'83.1 KB\', 2, \'Tetrahedra\', 4911, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 35760, 'I(1, 2, \'Tetrahedra\', 7562, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:49:06')
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
					I(1, 'Time', '05/20/2023 21:49:06')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 49148, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 5114, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 92852, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5114, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 145232, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 29082, false, 3, \'Matrix bandwidth\', 18.1715, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 145232, 'I(2, 1, \'Disk\', \'920 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94100, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:49:08')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 38400, 'I(1, 2, \'Tetrahedra\', 9099, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 52156, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 6464, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 105908, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Tetrahedra\', 6464, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 189272, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 37260, false, 3, \'Matrix bandwidth\', 18.7259, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 189272, 'I(2, 1, \'Disk\', \'549 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94164, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.170829, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:49:12')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 40300, 'I(1, 2, \'Tetrahedra\', 11039, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 55232, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 8172, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 124812, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 8172, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 255892, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 47716, false, 3, \'Matrix bandwidth\', 19.2773, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 255892, 'I(2, 1, \'Disk\', \'618 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94176, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0793382, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:49:15')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:03')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 42068, 'I(1, 2, \'Tetrahedra\', 13504, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 60120, 'I(2, 1, \'Disk\', \'3.58 KB\', 2, \'Tetrahedra\', 10433, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 149012, 'I(4, 1, \'Disk\', \'8 Bytes\', 2, \'Tetrahedra\', 10433, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 4, 0, 343860, 'I(3, 1, \'Disk\', \'4 Bytes\', 2, \'Matrix size\', 61642, false, 3, \'Matrix bandwidth\', 19.7386, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 343860, 'I(2, 1, \'Disk\', \'720 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94180, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0379615, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 5'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/20/2023 21:49:18')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:05')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 43828, 'I(1, 2, \'Tetrahedra\', 15446, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 63132, 'I(2, 1, \'Disk\', \'6.91 KB\', 2, \'Tetrahedra\', 12236, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 167180, 'I(4, 1, \'Disk\', \'4 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, true)
				ProfileItem('Solver DCS4', 1, 0, 5, 0, 411084, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 411084, 'I(2, 1, \'Disk\', \'705 KB\', 2, \'Excitations\', 2, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94184, 'I(1, 0, \'Adaptive Pass 5\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.010886, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/20/2023 21:49:27')
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
					I(1, 'Time', '05/20/2023 21:49:27')
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71748, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 109040, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205636, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205636, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71504, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108796, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205216, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205216, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70472, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107772, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203032, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203032, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69124, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107212, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 202836, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 202836, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 8GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 6GHz; S Matrix Error =  69.524%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 5GHz; S Matrix Error =  90.124%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 5.64GHz; S Matrix Error =  90.390%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71532, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108032, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205192, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205192, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70932, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 109012, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 204468, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 204468, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69500, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106720, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203224, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203224, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69140, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106448, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 202088, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 202088, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 7GHz; S Matrix Error =  59.526%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 5.82GHz; S Matrix Error =  69.729%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.32GHz; S Matrix Error =  44.338%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 4.5GHz; S Matrix Error =   6.060%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 96896, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71548, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108668, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205044, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205044, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71652, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108364, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205292, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205292, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70212, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107504, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203244, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203244, 'I(2, 1, \'Disk\', \'3.48 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69780, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107536, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203136, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203136, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 7.5GHz; S Matrix Error =   1.952%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.25GHz; S Matrix Error =   0.142%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 4.75GHz; S Matrix Error =   0.251%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 6.5GHz; S Matrix Error =   0.808%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 96944, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71340, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108924, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205276, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205276, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71420, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108504, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205304, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205304, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 70256, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107008, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203780, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203780, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69468, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107428, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203420, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203420, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 7.75GHz; S Matrix Error =   0.720%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 15, Frequency: 7.25GHz; S Matrix Error =   0.411%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 16, Frequency: 6.75GHz; S Matrix Error =   0.189%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 17, Frequency: 6.25GHz; S Matrix Error =   0.062%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 96984, 'I(1, 0, \'Frequency Group #4; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71640, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108532, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 205568, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 205568, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 71136, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 108908, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 204316, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 204316, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69664, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 107480, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 203832, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 203832, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
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
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #5\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 69108, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 106712, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 12236, false, 2, \'1 triangles\', 104, false, 2, \'2 triangles\', 114, false)', true, false)
					ProfileItem('Solver DCS1', 3, 0, 3, 0, 202864, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 72766, false, 3, \'Matrix bandwidth\', 20.0003, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 202864, 'I(2, 1, \'Disk\', \'3.47 KB\', 2, \'Excitations\', 2, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 18, Frequency: 6.375GHz; S Matrix Error =   0.055%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 19, Frequency: 7.875GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97024, 'I(1, 0, \'Frequency Group #5; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'89.9 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'59.2 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:21\', 1, \'Average memory/process\', \'401 MB\', 1, \'Max memory/process\', \'401 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:34\', 1, \'Average memory/process\', \'199 MB\', 1, \'Max memory/process\', \'201 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 12236, false, 2, \'Max matrix size\', 72766, false, 1, \'Matrix bandwidth\', \'20.0\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/20/2023 21:50:01\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
