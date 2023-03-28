close all
clear all
clc;

%% Declare Lidar object

MAX_TIMEOUT_LIDAR = 30; %seconds before no response an communication is closed
V = velodynelidar('PuckHiRes','Timeout',MAX_TIMEOUT_LIDAR); 
%V = velodynelidar('VLP16');

%start(V);



%% Calibration to find FPS of LiDAR

num_testFrames = 100; % Tunable

[test_frames, test_timestamps] = read(V,num_testFrames);

test_fps = round(1/mean(seconds(diff(test_timestamps))));


%% Calculate total time of recording in seconds
mins = 20; %Tunable
Max_time = 60*mins;
clear V;
V = velodynelidar('PuckHiRes','Timeout',Max_time+120);


ALL = read(V,Max_time*test_fps);
