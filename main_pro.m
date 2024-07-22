clear all;
clc;
inputpath='D:\ATL03_20190831172034_09870406_005_01.h5';       % D:\HowlandICESat-2\SERC\ATL03_20190831172034_09870406_005_01.h5
filelist = dir(inputpath);
outputpath = 'D:\';       %  D:\HowlandICESat-2\SERC_c0r2_2017\txt\
for i=1:length(filelist)
    
   outputname = filelist(i).name;
   filename=[filelist(i).folder '\' filelist(i).name];
   
   inputData = [];
   
   DataOut = [];
   ClipData = [];

   % offset
   borderZ = 0;         % border Z offset
   EGM = 34.2;          % Earth gravitation model (2008) offset  SERC c0r2

   for j=1:1:6
       
       if j==1 || j==3 || j==5
           m= (j+1)/2;
           str = strcat('gt',num2str(m),'l');
           
           inputData = readATL03data0(filename,str);
           data_conf=inputData.signal_conf_ph;
           % data_time=time(inputData.along_x,inputData.solar_elevation);

           data=[inputData.lon_ph,inputData.lat_ph,inputData.along_x,inputData.h_ph - borderZ + EGM,inputData.dist_ph_across];
           id=[];
           for m=1:size(data,1)
               id=[id;m];
           end
           
           outputfile=strcat(outputpath,outputname(1:end-3),str,'_true.txt');
           fid = fopen(outputfile,'w');
           for n=1:size(data,1)
               % UTM = lat_lon2utm(data(n,2),data(n,1));
               varargin(1,1) = data(n,2);
	           varargin(1,2) = data(n,1);
               UTM = ll2utm(varargin);
               UTM_E = UTM(1);
               UTM_N = UTM(2);
               % fprintf(fid,'%d %f %f %f %f %f %d\n',id(n,1),data(n,1),data(n,2),UTM_E,data(n,4),UTM_N,data_conf(n,1));
               fprintf(fid,'%f %f %f %f %f\n',data(n,1),data(n,2),UTM_E,UTM_N,data(n,4));
           end

       elseif j==2 || j==4 || j==6
           n=j/2;
           str1 = strcat('gt',num2str(n),'r');
           inputData = readATL03data0(filename,str1);
           data_conf=inputData.signal_conf_ph;
           % data_time=time(inputData.along_x,inputData.solar_elevation);
                
           data=[inputData.lon_ph,inputData.lat_ph,inputData.along_x,inputData.h_ph - borderZ + EGM,inputData.dist_ph_across];
           id=[];
           for m=1:size(data,1)
               id=[id;m];
           end
           data=[data,id];
           outputfile=strcat(outputpath,outputname(1:end-3),str1,'_true.txt');
           fid = fopen(outputfile,'w');
           for n=1:size(data,1)
               % UTM = lat_lon2utm(data(n,2),data(n,1));
               varargin(1,1) = data(n,2);
	           varargin(1,2) = data(n,1);
               UTM = ll2utm(varargin);
               UTM_E = UTM(1);
               UTM_N = UTM(2);
               fprintf(fid,'%f %f %f %f %f\n',data(n,1),data(n,2),UTM_E,UTM_N,data(n,4));
           end
       end 
   end
   disp(i/length(filelist));
end
% at03='F:\研究生项目\ICESat-2数据\ATL03_20191231011923_00660606_003_01.h5';
% output1= readATL03data(at03,'gt1l');
% output2= readATL03data(at03,'gt1r');
% output3= readATL03data(at03,'gt2l');
% output4= readATL03data(at03,'gt2r');
% output5= readATL03data(at03,'gt3l');
% output6= readATL03data(at03,'gt3r');
% output1= readATL03data(inputpath,'gt1l');
% output2= readATL03data(inputpath,'gt1r');
% output3= readATL03data(inputpath,'gt2l');
% output4= readATL03data(inputpath,'gt2r');
% output5= readATL03data(inputpath,'gt3l');
% output6= readATL03data(inputpath,'gt3r');

% %绘图
% figure(1); 
% subplot(2,3,1);
% scatter(output1.along_x,output1.h_ph,3,[0,0,0],'filled');
% subplot(2,3,2);
% scatter(output2.along_x,output2.h_ph,3,[0,0,0],'filled');
% subplot(2,3,3);
% scatter(output3.along_x,output3.h_ph,3,[0,0,0],'filled');
% subplot(2,3,4);
% scatter(output4.along_x,output4.h_ph,3,[0,0,0],'filled');
% subplot(2,3,5);
% scatter(output5.along_x,output5.h_ph,3,[0,0,0],'filled');
% subplot(2,3,6);
% scatter(output6.along_x,output6.h_ph,3,[0,0,0],'filled');
% %输出经纬度坐标点
% data1=[output1.along_x,output1.h_ph];
% outputfile=strcat(outputpath,atl03(1:end-3),data1,'_coor1.txt');
% dlmwrite(outputfile, data1, 'precision', '%.6f','newline', 'pc');


