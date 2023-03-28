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

test_fps = round(1/mean(seconds(diff(test_timestamps))))


%% Calculate total time of recording in seconds
mins = 1; %Tunable
Max_time = 60*mins;

%% Create an empty array sheet of timestamps
time_table  = NaT(Max_time*test_fps,1,'TimeZone','America/New_York');

%time_table = cell(0);

%% Keypress handler
figure;
ButtonHandle = uicontrol('Style', 'PushButton','String', 'Stop loop','Callback', 'delete(gcbf)');
pause(5);

%% Start timer for data recording
start_time = tic;


num = 1;
while(ishandle(ButtonHandle))
    [Ptcloud,timestamp] = read(V);
    
    pcwrite(Ptcloud,sprintf('Dataset/ptcloud_%d.pcd',num));
    time_table(num) = timestamp;

    num = num+1;
    if ~ishandle(ButtonHandle)
        disp('Loop stopped by user');
        break;
    end
end
%stop(V);



