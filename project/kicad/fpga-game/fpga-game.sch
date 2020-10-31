EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Memory_Flash:AT25SF081-SSHD-X U1
U 1 1 5F9C9757
P 5450 3300
F 0 "U1" H 6094 3346 50  0000 L CNN
F 1 "AT25SF081-SSHD-X" H 6094 3255 50  0000 L CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 5450 2700 50  0001 C CNN
F 3 "https://www.adestotech.com/wp-content/uploads/DS-AT25SF081_045.pdf" H 5450 3300 50  0001 C CNN
	1    5450 3300
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male J1
U 1 1 5F9CA9EA
P 3650 3200
F 0 "J1" H 3758 3481 50  0000 C CNN
F 1 "Conn_01x04_Male" H 3758 3390 50  0000 C CNN
F 2 "Connector_PinHeader_1.00mm:PinHeader_1x04_P1.00mm_Vertical" H 3650 3200 50  0001 C CNN
F 3 "~" H 3650 3200 50  0001 C CNN
	1    3650 3200
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male J2
U 1 1 5F9CCD38
P 3650 3950
F 0 "J2" H 3758 4231 50  0000 C CNN
F 1 "Conn_01x04_Male" H 3758 4140 50  0000 C CNN
F 2 "Connector_PinHeader_1.00mm:PinHeader_1x04_P1.00mm_Vertical" H 3650 3950 50  0001 C CNN
F 3 "~" H 3650 3950 50  0001 C CNN
	1    3650 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 3100 3850 3100
Wire Wire Line
	6050 3100 6050 2750
Wire Wire Line
	6050 2750 4300 2750
Wire Wire Line
	4300 2750 4300 3200
Wire Wire Line
	4300 3200 3850 3200
Wire Wire Line
	4850 3200 4500 3200
Wire Wire Line
	4500 3200 4500 3300
Wire Wire Line
	4500 3300 3850 3300
Wire Wire Line
	4850 3300 4650 3300
Wire Wire Line
	4650 3300 4650 3400
Wire Wire Line
	4650 3400 3850 3400
Wire Wire Line
	5450 2800 4450 2800
Wire Wire Line
	4450 2800 4450 3850
Wire Wire Line
	4450 3850 3850 3850
Wire Wire Line
	5450 3800 4550 3800
Wire Wire Line
	4550 3800 4550 3950
Wire Wire Line
	4550 3950 3850 3950
Wire Wire Line
	4850 3400 4700 3400
Wire Wire Line
	4700 3400 4700 4050
Wire Wire Line
	4700 4050 3850 4050
Wire Wire Line
	4850 3500 4850 4150
Wire Wire Line
	4850 4150 3850 4150
$EndSCHEMATC