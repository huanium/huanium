$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '05/18/2023 22:39:34')
			I(1, 'Host', 'DESKTOP-9GEMUKL')
			I(1, 'Processor', '24')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:00:23')
			I(1, 'ComEngine Memory', '95.3 M')
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
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 90.1 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:39:34')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:03')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU4', 1, 0, 1, 0, 49000, 'I(1, 2, \'Tetrahedra\', 9465, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 1, 0, 1, 0, 49000, 'I(1, 2, \'Tetrahedra\', 3613, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 33984, 'I(1, 2, \'Tetrahedra\', 4602, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 41636, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 53520, 'I(2, 1, \'Disk\', \'41.5 KB\', 2, \'Tetrahedra\', 3172, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 32996, 'I(1, 2, \'Tetrahedra\', 4801, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:39:37')
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
					I(1, 'Time', '05/18/2023 22:39:37')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 43340, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 3276, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 73528, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 3276, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 116084, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 18867, false, 3, \'Matrix bandwidth\', 18.3782, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 116084, 'I(2, 1, \'Disk\', \'513 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94428, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:39:40')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 34808, 'I(1, 2, \'Tetrahedra\', 5787, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 45840, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 4169, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 83336, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 4169, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 1, 0, 147420, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 24371, false, 3, \'Matrix bandwidth\', 18.9844, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 147420, 'I(2, 1, \'Disk\', \'276 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94488, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.119231, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:39:42')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 36132, 'I(1, 2, \'Tetrahedra\', 7043, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 47332, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 5319, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 95412, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 5319, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 179700, 'I(3, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 31467, false, 3, \'Matrix bandwidth\', 19.5186, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 179700, 'I(2, 1, \'Disk\', \'323 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94496, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0508328, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 4'
				$begin 'StartInfo'
					I(0, 'Frequency:  5.64GHz')
					I(1, 'Time', '05/18/2023 22:39:45')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:02')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 37404, 'I(1, 2, \'Tetrahedra\', 8640, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 50396, 'I(2, 1, \'Disk\', \'3.57 KB\', 2, \'Tetrahedra\', 6805, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 0, 0, 111708, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false, 2, \'1 triangles\', 104, false)', true, true)
				ProfileItem('Solver DCS4', 0, 0, 2, 0, 240000, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40675, false, 3, \'Matrix bandwidth\', 19.9678, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 240000, 'I(2, 1, \'Disk\', \'384 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 94504, 'I(1, 0, \'Adaptive Pass 4\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0189431, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '05/18/2023 22:39:48')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:09')
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
					I(1, 'Time', '05/18/2023 22:39:48')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:09')
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58836, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81632, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 139624, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40675, false, 3, \'Matrix bandwidth\', 19.9678, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 139624, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58476, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81732, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 139296, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40675, false, 3, \'Matrix bandwidth\', 19.9678, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 139296, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57804, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81052, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 139012, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40675, false, 3, \'Matrix bandwidth\', 19.9678, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 139012, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57356, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80396, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 138364, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40675, false, 3, \'Matrix bandwidth\', 19.9678, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 138364, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 7GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 4GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 5.5GHz; S Matrix Error = 194.077%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 4.75GHz; S Matrix Error = 229.091%\')', false, true)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58832, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81596, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 139556, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40675, false, 3, \'Matrix bandwidth\', 19.9678, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 139556, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58380, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 81272, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 139224, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40675, false, 3, \'Matrix bandwidth\', 19.9678, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 139224, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57788, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80784, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 138580, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40675, false, 3, \'Matrix bandwidth\', 19.9678, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 138580, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
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
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 57236, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false)', true, false)
					ProfileItem('Matrix Assembly', 0, 0, 0, 0, 80452, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 6805, false, 2, \'1 triangles\', 104, false)', true, false)
					ProfileItem('Solver DCS1', 1, 0, 1, 0, 138444, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 40675, false, 3, \'Matrix bandwidth\', 19.9678, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 138444, 'I(2, 1, \'Disk\', \'2.27 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 6.25GHz; S Matrix Error =   6.674%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 5.125GHz; S Matrix Error =   5.448%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 4.375GHz; S Matrix Error =   3.688%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 5.875GHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 97028, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
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
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'90.1 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:03\', 1, \'Total Memory\', \'52.3 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:10\', 1, \'Average memory/process\', \'234 MB\', 1, \'Max memory/process\', \'234 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:09\', 1, \'Average memory/process\', \'136 MB\', 1, \'Max memory/process\', \'136 MB\', 2, \'Total number of processes\', 4, false, 2, \'Total number of cores\', 4, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 6805, false, 2, \'Max matrix size\', 40675, false, 1, \'Matrix bandwidth\', \'20.0\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'05/18/2023 22:39:57\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
