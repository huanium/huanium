$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/18/2023 22:28:31')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:33')
			I(1, 'ComEngine Memory', '96 M')
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
				I(1, 'Time', '05/18/2023 22:28:31')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 1, 0, 49000, 'I(1, 2, \'Tetrahedra\', 10459, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 49000, 'I(1, 2, \'Tetrahedra\', 3528, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 33944, 'I(1, 2, \'Tetrahedra\', 4452, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 41560, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 54316, 'I(2, 1, \'Disk\', \'42.4 KB\', 2, \'Tetrahedra\', 3082, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 32984, 'I(1, 2, \'Tetrahedra\', 4670, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:28:34')
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
					I(1, 'Time', '05/18/2023 22:28:34')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 43036, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 3194, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 73396, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 3194, false, 2, \'1 triangles\', 120, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 0, 0, 109516, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 18415, false, 3, \'Matrix bandwidth\', 18.1801, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 109516, 'I(2, 1, \'Disk\', \'508 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94992, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:28:36')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 34564, 'I(1, 2, \'Tetrahedra\', 5630, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 45404, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 4078, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 82676, 'I(3, 1, \'Disk\', \'6 Bytes\', 2, \'Tetrahedra\', 4078, false, 2, \'1 triangles\', 120, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 138640, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 23887, false, 3, \'Matrix bandwidth\', 18.8888, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 138640, 'I(2, 1, \'Disk\', \'282 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95052, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.129536, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:28:39')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 35616, 'I(1, 2, \'Tetrahedra\', 6859, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 47464, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 5175, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 94848, 'I(3, 1, \'Disk\', \'6 Bytes\', 2, \'Tetrahedra\', 5175, false, 2, \'1 triangles\', 120, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 172772, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 30607, false, 3, \'Matrix bandwidth\', 19.379, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 172772, 'I(2, 1, \'Disk\', \'327 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95088, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0270611, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:28:42')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 37168, 'I(1, 2, \'Tetrahedra\', 8416, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 50084, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 6577, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 110000, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 222892, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 222892, 'I(2, 1, \'Disk\', \'386 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 95108, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.014985, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:28:44')
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
					I(1, 'Time', '05/18/2023 22:28:44')
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58564, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81916, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 129904, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 129904, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57992, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79832, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 129440, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 129440, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57184, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79316, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 128532, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 128532, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56812, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78748, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 128236, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 128236, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 7GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 5.5GHz; S Matrix Error =  53.734%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 4.75GHz; S Matrix Error =  90.317%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58216, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80760, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 129644, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 129644, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57788, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79456, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 129532, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 129532, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57316, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79044, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 128704, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 128704, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56752, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78900, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 128388, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 128388, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 6.25GHz; S Matrix Error =  63.817%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 5.125GHz; S Matrix Error =  64.013%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 4.375GHz; S Matrix Error =   6.017%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.875GHz; S Matrix Error =   1.952%\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97636, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 5.64GHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 9, Frequency: 5.64GHz; S Matrix Error =   1.259%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58444, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80728, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 130104, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 130104, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58128, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80032, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 129516, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 129516, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57684, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79400, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 128876, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 128876, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57084, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 78772, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 128380, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 128380, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 10, Frequency: 6.625GHz; S Matrix Error =   0.668%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 11, Frequency: 4.5625GHz; S Matrix Error =   0.211%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 12, Frequency: 4.9375GHz; S Matrix Error =   0.266%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 13, Frequency: 4.1875GHz; S Matrix Error =   0.118%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97664, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58168, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81360, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 129780, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 129780, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57792, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79532, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 129288, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 129288, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #4\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57172, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 79220, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 128560, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 128560, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 56932, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80292, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6577, false, 2, \'1 triangles\', 120, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 128392, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 39217, false, 3, \'Matrix bandwidth\', 19.7929, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 128392, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 14, Frequency: 6.8125GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97800, 'I(1, 0, \'Frequency Group #4; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'53 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:10\', 1, \'Average memory/process\', \'218 MB\', 1, \'Max memory/process\', \'218 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:19\', 1, \'Average memory/process\', \'126 MB\', 1, \'Max memory/process\', \'127 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 6577, false, 2, \'Max matrix size\', 39217, false, 1, \'Matrix bandwidth\', \'19.8\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/18/2023 22:29:04\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
