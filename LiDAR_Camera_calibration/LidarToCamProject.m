close all 
%clear all
clc
%% Image files
imageFilePaths = { 'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\1.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\2.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\3.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\4.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\5.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\6.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\7.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\8.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\9.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\10.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\11.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\12.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\13.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\14.JPG'; ...
    'C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\15.JPG'};

%% Load initial parameters
squareSize = 95;
padding = [0 0 0 0];
load("C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\results2.mat");
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


%% Script to project lidar image to lidar points

%% Load transform data

image = imread('C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\images\1.JPG');
ptCloud=pcread('C:\Users\arjun\Desktop\New folder\projects\MS_Proj\Test5\ptcloud\1.pcd');

%% Load 2D and 3D points
camToLidar = invert(tform) ;
p1 = pcdownsample(ptCloud, 'gridAverage', 0.05);
imPts = projectLidarPointsOnImage(p1,intrinsics,tform_new);



ptCloudOut = fuseCameraToLidar(image,ptCloud,intrinsics,camToLidar);

%% Plot results
close all
f1 = figure;
imshow(image)
hold on
plot(imPts(:,1),imPts(:,2),'.','Color','r');
hold off

f2 = figure;
pcshow(ptCloudOut)
title('Colored Point Cloud')

f3 = figure;
pcshow(ptCloud)
title('Original Point Cloud')