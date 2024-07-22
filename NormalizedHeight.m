clc;
% Read True data
fid0 = fopen('D:\HowlandICESat-2\SERC_c0r2_2017\txt\ATL03_20190831172034_09870406_005_01gt2l_true_segmented.txt','r');
formatSpec0 = '%f %f %f';
sizeA = [3 Inf];
ATL = fscanf(fid0, formatSpec0, sizeA);
ATL = ATL';

for ii = 1:length(ATL(:,1))
    NewATL(ii, 1) = ATL(ii,1) - 364541.00;  % Shift_X to DART
    NewATL(ii, 2) = ATL(ii,2) - 4302642.00; % Shift_Y to DART
    NewATL(ii, 3) = ATL(ii,3);              % Z
end
fclose(fid0);


% Read Simulated data
fid = fopen('D:\HowlandICESat-2\SERC_c0r2_2017\txt\LIDAR_PC1118_solar.csv','r');   
formatSpec = '%f %f %f %f %f %f';
sizeB = [6 Inf];
LiDARPC = fscanf(fid, formatSpec, sizeB);
LiDARPC = LiDARPC';


fid1 = fopen('D:\HowlandICESat-2\SERC_c0r2_2017\txt\LIDAR_PC1118_solar_DARTcoordinate.txt','w');
for qq = 1:length(LiDARPC(:,1))
    fprintf(fid1,'%f %f %f\n',LiDARPC(qq,2),4500 - LiDARPC(qq,1),LiDARPC(qq,3));        % Scene dimension, coordinate
end
fclose(fid1);

% Read DTM
fid2 = fopen('D:\HowlandICESat-2\SERC_c0r2_2017\txt\dtm_cloud - Cloud.txt','r');
formatSpec2 = '%f %f %f %d %d %d';
sizeC = [6 Inf];
DTM = fscanf(fid2, formatSpec2, sizeC);
DTM = DTM';
fclose(fid2);


% Euclidean distance    Find the closed DTM with True data
NormalizedATL = NewATL;
for i = 1:length(NewATL(:,1))
    dist = 100000;     % A big value
    for j = 1:length(DTM(:,1))
        % XY distance
        tmp = sqrt((NewATL(i,1)-DTM(j,1)) * (NewATL(i,1)-DTM(j,1)) + (NewATL(i,2)-DTM(j,2)) * (NewATL(i,2)-DTM(j,2)));
        if tmp < dist
            dist = tmp;
            index_DTM = j;
        end
    end
    NormalizedATL(i,3) = NewATL(i,3) - DTM(index_DTM,3);   % Height delete DTM
    % disp(i/length(NewATL(:,1)));
end
fid3 = fopen('D:\HowlandICESat-2\SERC_c0r2_2017\txt\ATL03_20190831172034_09870406_005_01gt2l_true_segmented_Normalized.txt','w');
for jj = 1:length(NormalizedATL(:,1))
    fprintf(fid3,'%f %f %f\n',NormalizedATL(jj,1),NormalizedATL(jj,2),NormalizedATL(jj,3));
end
fclose(fid3);


for i = 1:length(LiDARPC(:,1))
    NewLiDARPC(i, 1) = LiDARPC(i,2);
    NewLiDARPC(i, 2) = 4500 - LiDARPC(i,1);
    NewLiDARPC(i, 3) = LiDARPC(i,3);
end
% Euclidean distance    Find the closed DTM with Simulated data
NormalizedLiDARPC = NewLiDARPC;
for i = 1:length(NewLiDARPC(:,1))
    dist = 100000;     % A big value
    for j = 1:length(DTM(:,1))
        % XY distance
        tmp = sqrt((NewLiDARPC(i,1)-DTM(j,1)) * (NewLiDARPC(i,1)-DTM(j,1)) + (NewLiDARPC(i,2)-DTM(j,2)) * (NewLiDARPC(i,2)-DTM(j,2)));
        if tmp < dist
            dist = tmp;
            index_DTM = j;
        end
    end
    NormalizedLiDARPC(i,3) = NewLiDARPC(i,3) - DTM(index_DTM,3);   % Height delete DTM
    disp(i/length(NewLiDARPC(:,1)));
end

fid4 = fopen('D:\HowlandICESat-2\SERC_c0r2_2017\txt\LIDAR_PC1118_solar_Normalized.txt','w');
for jj = 1:length(NormalizedLiDARPC(:,1))
    fprintf(fid4,'%f %f %f\n',NormalizedLiDARPC(jj,1),NormalizedLiDARPC(jj,2),NormalizedLiDARPC(jj,3));
end
fclose(fid4);


