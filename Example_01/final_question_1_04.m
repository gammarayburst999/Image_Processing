clear all
close all
clc
I = imread('toysflash.png');

BW_02_01=CM2(I); % for the second object
BW_01_01=CM1(I);% for the first object
BW_02_02 = bwareafilt(BW_02_01,1); %filter out the biggest image
BW_01_02 = bwareafilt(BW_01_01,1);

se1 = strel('square', 4);
se2 = strel('square', 2);
% refine the images with the help of erode and dilate function
closeBW_01 =imerode(BW_01_02,se1);
closeBW_02 =imdilate(BW_02_02,se2);
%addition of two binary images.
Z=or(closeBW_01,closeBW_02);

%copy of RGB image
maskedRGBImage_03 = I;
figure
%extracting the two objects from the RGB image
maskedRGBImage_03(repmat(~Z,[1 1 3])) = 0;
%display
imshow(maskedRGBImage_03)

%%%%%%Function to generate the mask for the white ball object%%%%%%%%%%%%%
function [BW] = CM2(RGB)

I = RGB;

% Define thresholds for red
red_min = 170.000;
red_max = 255.000;

% Define thresholds for green
green_min = 137.000;
green_max = 255.000;

% Define thresholds for blue
blue_min = 54.000;
blue_max = 255.000;

% Mask Created
sBW = (I(:,:,1) >= red_min ) & (I(:,:,1) <= red_max) & ...
    (I(:,:,2) >= green_min ) & (I(:,:,2) <= green_max) & ...
    (I(:,:,3) >= blue_min ) & (I(:,:,3) <= blue_max);
BW = sBW;
end

%%%%%%Function to generate the mask for the blue object%%%%%%%%%%%%%
function [BW] = CM1(RGB)

I = RGB;
% Define thresholds for red
red_min = 0.000;
red_max = 93.000;

% Define thresholds for green
green_min = 0.000;
green_max = 154.000;

% Define thresholds for blue
blue_min = 51.000;
blue_max = 255.000;

% Mask Created
sBW = (I(:,:,1) >= red_min ) & (I(:,:,1) <= red_max) & ...
    (I(:,:,2) >= green_min ) & (I(:,:,2) <= green_max) & ...
    (I(:,:,3) >= blue_min ) & (I(:,:,3) <= blue_max);
BW = sBW;
end
