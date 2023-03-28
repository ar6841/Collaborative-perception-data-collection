clear all;
close all;
clc;
V = velodynelidar('PuckHiRes');
%start(V);
start_time = tic;
mins = 5;
Max_time = 60*mins;
time_table  = NaT(Max_time*1000,1,'TimeZone','America/New_York');
num = 1;
while toc(start_time)<Max_time
    [Ptcloud,timestamp] = read(V);
    
    pcwrite(Ptcloud,sprintf('Dataset/ptcloud_%d.pcd',num));
    %pcshow(Ptcloud);
    time_table(num) = timestamp;

    num = num+1;
end

%stop(V);

