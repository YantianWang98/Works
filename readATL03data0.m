 function output= readATL03data0(abs_path_ATLO3,str)
%读取ATL03中的有关数据，并返回一个结构体,str为轨道名字，例如‘gt2r'

data03_path=['/gt/geolocation/segment_ph_cnt ';  
             '/gt/geolocation/ph_index_beg   ';
             '/gt/geolocation/surf_type      ';
             '/gt/geolocation/segment_dist_x ';
             '/gt/geolocation/ref_elev       ';
             '/gt/geolocation/solar_elevation';
             '/gt/heights/h_ph               ';
             '/gt/heights/dist_ph_along      ';
             '/gt/heights/dist_ph_across     ';
             '/gt/geophys_corr/geoid         ';
             '/gt/heights/lat_ph             ';
             '/gt/heights/lon_ph             ';
             '/gt/heights/signal_conf_ph     ';
             '/gt/geolocation/segment_id     ';
             '/gt/geophys_corr/tide_ocean    '];
for ii=1:15
    path=data03_path(ii,:);            %读取每一个相对路径
    newpath=strip(path);               %去除空格
    Newpath=strrep(newpath,'gt',str);  %更换到具体轨道
    data=h5read(abs_path_ATLO3,Newpath);
    if ii==1
        output.segment_ph_cnt=data;
    elseif ii==2
        output.ph_index_beg=data;
    elseif ii==3
        output.surf_type=data;
    elseif ii==4
        output.segment_dist_x=data-data(1,1);  
    elseif ii==5
        output.ref_elev=data;
    elseif ii==6
        output.solar_elevation=data;
    elseif ii==7
        output.h_ph=data;
    elseif ii==8
        output.dist_ph_along=data;
    elseif ii==9
        output.dist_ph_across=data;
    elseif ii==10
        output.geoid=data;
    elseif ii==11
        output.lat_ph=data;
    elseif ii==12
        output.lon_ph=data;   
    elseif ii==13
        output.signal_conf_ph=data;
    elseif ii==14
        output.segment_id=data;
    else
        output.tide_ocean=data;
    end
end


n=size(output.segment_ph_cnt,1);       %读取地理段数（沿线段光子数）
for jj=1:n
    n_ph=output.segment_ph_cnt(jj,1);  %判断该地理段是否有光子
    if n_ph>0
        st=output.ph_index_beg(jj,1);    %第一个光子索引号
        en=st+int64(n_ph)-1;             %最后一个光子的索引号,st为64位整形，en为32位整形
        output.along_x(st:en,1)=output.segment_dist_x(jj,1)+output.dist_ph_along(st:en,1);  %光子的沿轨道距离
    end
end
     
% left_lon_idx=(output.lon_ph > -68.8 & output.lon_ph < -68.7); 
% left_lat_idx=(output.lat_ph > 45.195 & output.lat_ph < 45.21);   

% Howland_data range
% left_lon_idx=(output.lon_ph > -68.7490165356405 & output.lon_ph < -68.736243263476210);     % -68.75  -68.74
% SERC data range     c1r4    38.874 -76.579  38.883 -76.568 
% c0r2_2017     38.888 -76.568    38.898  -76.556  
% c0r2_2017     38.888 -76.568    38.898  -76.556  
% c0r2_2017 move right    38.89035 -76.56333    38.89952  -76.55199  
left_lon_idx=(output.lon_ph > -76.580 & output.lon_ph < -76.510);     % -68.75  -68.74

% left_lon_idx=((output.lon_ph >111.7755 & output.lon_ph <111.7775)|(output.lon_ph >111.778 & output.lon_ph <111.78) );

% Howland_data range
% left_lat_idx=(output.lat_ph > 45.20155741067766 & output.lat_ph < 45.210530516742610);      % 45.198  45.208
% SERC data range  
left_lat_idx=(output.lat_ph > 38.860 & output.lat_ph < 38.950);      % 45.198  45.208

left_out = (left_lon_idx & left_lat_idx);
  
output.along_x=output.along_x(left_out);
output.h_ph=output.h_ph(left_out);
output.lon_ph=output.lon_ph(left_out);
output.lat_ph=output.lat_ph(left_out);
output.dist_ph_across=output.dist_ph_across(left_out);
output.signal_conf_ph=output.signal_conf_ph(1,:)';
output.signal_conf_ph=output.signal_conf_ph(left_out);

end

