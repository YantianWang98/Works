* main_pro.m:
solves ICESat-2 ATL03 raw data (ATLAS/ICESat-2 L2A Global Geolocated Photon Data):
converts raw data (h5 files) in HDF5 format from websites to txt files (photons geolocated coordinates):

The matlab file could be run by:
1. give the inputpath xxx.h5 files list
2. give the output path
3. set the border Z offset value and Earth gravitation model value
4. set the output geographic extents (output.lon_ph, output.lat_ph) in matlab file (readATL03data0.m)


       example : ATL03_20190831172034_09870406_005_01.h5             (input file)
                 ATL03_20190831172034_09870406_005_01gt1l_true.txt   (output file, beam pair 1: strong beam)
                 ATL03_20190831172034_09870406_005_01gt1r_true.txt   (output file, beam pair 1: weak beam)
                 ATL03_20190831172034_09870406_005_01gt2l_true.txt   (output file, beam pair 2: strong beam)
                 ATL03_20190831172034_09870406_005_01gt2r_true.txt   (output file, beam pair 2: weak beam)
                 ATL03_20190831172034_09870406_005_01gt3l_true.txt   (output file, beam pair 3: strong beam)
                 ATL03_20190831172034_09870406_005_01gt3r_true.txt   (output file, beam pair 3: weak beam)


The generated txt files of ATL03 (in the folder ExampleData) could be displayed in CloudCompare. The format of output txt files is Lon, Lat, X, Y, Z.
X, Y, Z are in the UTM-WGS84 projection coordinate system, which have been processed by border Z offset and Earth gravitation model (2008).



--------------------------------------------------------------------------------------------------------------------------------------------------------------



* PhotonMetrics.m:
basically compares ICESat-2 true data with DART simulated data (txt files):

The matlab file could be run by:
1. give ICESat-2 true data filename
2. give DART simulated data filename


       example : ATL03_20190831172034_09870406_005_01gt2l_Normalized.txt   (input file: ICESat-2 true data)
                 LiDAR_PC1109_solarNormalized.txt                          (input file: DART simulated data)


The generated figures could be displayed in matlab and the canopy reflectance ratio could be calculated.
Fig. 1 (All photons comparison), Fig.2 (Elevation histogram comparison), Fig. 3 (Pseudo waveform comparison), Fig.4 (Point Density comparison)



--------------------------------------------------------------------------------------------------------------------------------------------------------------



* NormalizedHeight.m:
performs terrain correction on ICESat-2 geolocated photons (txt files) using DTM (txt file) to get height-normalized photons (txt files):

The matlab file could be run by:
1. give ICESat-2 true data filename
2. give DART simulated data filename


       example : ATL03_20190831172034_09870406_005_01gt2l_true_segmented.txt              (input file: ICESat-2 true data, for displaying)
                 LIDAR_PC1118_solar.csv                                                   (input file: DART simulated data)
                 dtm_cloud - Cloud.txt                                                    (input file: DTM, for displaying)
                 LIDAR_PC1118_solar_DARTcoordinate.txt                                    (output file: DART simulated data, for displaying)
                 ATL03_20190831172034_09870406_005_01gt2l_true_segmented_Normalized.txt   (output file: height-normalized ICESat-2 true data, for displaying)
                 LIDAR_PC1118_solar_Normalized.txt                                        (output file: height-normalized DART simulated data, for displaying)


The generated txt files of height-normalized photons (in the folder ExampleData) could be displayed in CloudCompare. The format of output txt files is X, Y, Z.
Pay attention to the conversion among coordinate systems (refer to the comments, modify the Shift_X, Shift_Y and Scene dimension).



--------------------------------------------------------------------------------------------------------------------------------------------------------------



* ll2utm.m:
precisely converts Lat/Lon to UTM coordinates. Default datum is WGS84:
converts coordinates LAT,LON (in degrees) to UTM X and Y (in meters):


       example : ll2utm(38.950, -76.547) = (365971.561, 4312365.113)



--------------------------------------------------------------------------------------------------------------------------------------------------------------



* DBSCAN.m:
judges whether each ATL03 photon is noise:

The matlab file could be run by:
1. give ATL03 photons already read (e.g., simulateddata)
2. give two important parameters: epsilon ('eps') and minimum points ('MinPts'). The parameter eps defines the radius of neighborhood around a point x. 
The parameter MinPts is the minimum number of neighbors within 'eps' radius.

       example : DBSCAN(simulateddata, 10, 1) = (1, 2, 3)



--------------------------------------------------------------------------------------------------------------------------------------------------------------





