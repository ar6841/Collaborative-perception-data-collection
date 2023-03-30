%% Image files
imageFilePaths = { 'C:\Users\arjun\Desktop\New folder\projects\LiDAR_cam_data\Test3\images\point_cloud10.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\LiDAR_cam_data\Test3\images\point_cloud11.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\LiDAR_cam_data\Test3\images\point_cloud12.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\LiDAR_cam_data\Test3\images\point_cloud13.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\LiDAR_cam_data\Test3\images\point_cloud14.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\LiDAR_cam_data\Test3\images\point_cloud3.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\LiDAR_cam_data\Test3\images\point_cloud4.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\LiDAR_cam_data\Test3\images\point_cloud5.JPG' };
%% Load initial parameters
squareSize = 95;
padding = [0 0 0 0];
%% Compute camera intrinsics
% Detect calibration pattern
[imagePoints, boardSize] = detectCheckerboardPoints(imageFilePaths);
% Generate world coordinates of the corners of the squares
worldPoints = generateCheckerboardPoints(boardSize, squareSize);
% Calibrate the camera
I = imread(imageFilePaths{1});
imageSize = [size(I, 1), size(I, 2)];
params = estimateCameraParameters(imagePoints, worldPoints, 'ImageSize', imageSize);
intrinsics = params.Intrinsics;