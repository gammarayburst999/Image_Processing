clear all
close all
clc
%read the images
I1 = imread('chess_knights_run.png');
I2 = imread('knight.png');
I3  = flipdim(I2 ,2); %flipped the main image
%convert them to gray
I1_01=rgb2gray(I1);
I2_02=rgb2gray(I2);
I3_02=rgb2gray(I3);
%detecting SURF features
points1 = detectSURFFeatures(I1_01);
points2 = detectSURFFeatures(I2_02);
points3 = detectSURFFeatures(I3_02);
%Extracting the features from the images
[f1, valid_points1] = extractFeatures(I1_01, points1);
[f2, valid_points2] = extractFeatures(I2_02, points2);
[f3, valid_points3] = extractFeatures(I3_02, points3);
%Matching the features
[indexPairs_01,matchmetric_01] = matchFeatures(f1, f2, 'Unique', true);
[indexPairs_02,matchmetric_02] = matchFeatures(f1, f3,...
    'MatchThreshold', 0.02);
%matched points between main image and the knights image
matchedPoints1_01 = valid_points1(indexPairs_01(:,1)); %main image
matchedPoints1_02 = valid_points2(indexPairs_01(:,2));
matchedPoints2_01 = valid_points1(indexPairs_02(:,1)); %main image
matchedPoints2_02 = valid_points3(indexPairs_02(:,2));
%finding the mean of the locations of both knights
A1=mean(matchedPoints1_01.Location);
A2=mean(matchedPoints2_01.Location);

p=[A1;A2];
%calculating the distance between the two knights in pixel
distance_in_pixel=pdist(p);
% x and y co-ordinates of both knight
point01=[A1(1) A2(1)];
point02=[A1(2) A2(2)];
%display
figure; 
showMatchedFeatures(I1_01,I2_02,matchedPoints1_01,matchedPoints1_02);
hold on;
legend('matched points 1','matched points 2');
plot(A1(1), A1(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
plot(A2(1), A2(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
plot(point01,point02,'k', 'LineWidth', 4)