clc;
clear all;close all;
warning off all;
addpath('utils');

isImgDisplay = false; % flag to display the groundtruth and detections

datasetPath = '..\VisDrone2019-DET-test-challenge\'; % dataset path
resPath = '..\DET_results-test-challenge\'; % result path

gtPath = fullfile(datasetPath, 'annotations'); % annotation path
imgPath = fullfile(datasetPath, 'images'); % image name path
nameImgs = findImageList(gtPath); % image list
numImgs = length(nameImgs); % number of images

% process the annotations and groundtruth
[allgt, alldet] = saveAnnoRes(gtPath, resPath, imgPath, numImgs, nameImgs);

% show the groundtruth and detection results
displayImage(imgPath, numImgs, nameImgs, allgt, alldet, isImgDisplay);

% claculate average precision and recall over all 10 IoU thresholds (i.e., [0.50:0.05:0.95]) of all object categories
[AP_all, AP_50, AP_75, AR_1, AR_10, AR_100, AR_500] = calcAccuracy(numImgs, allgt, alldet);

% print the average precision and recall
disp(['Average Precision  (AP) @[ IoU=0.50:0.95 | maxDets=500 ] = ' num2str(roundn(AP_all,-2)) '%.']);
disp(['Average Precision  (AP) @[ IoU=0.50      | maxDets=500 ] = ' num2str(roundn(AP_50,-2)) '%.']);
disp(['Average Precision  (AP) @[ IoU=0.75      | maxDets=500 ] = ' num2str(roundn(AP_75,-2)) '%.']);

disp(['Average Recall     (AR) @[ IoU=0.50:0.95 | maxDets=  1 ] = ' num2str(roundn(AR_1,-2)) '%.']);
disp(['Average Recall     (AR) @[ IoU=0.50:0.95 | maxDets= 10 ] = ' num2str(roundn(AR_10,-2)) '%.']);
disp(['Average Recall     (AR) @[ IoU=0.50:0.95 | maxDets=100 ] = ' num2str(roundn(AR_100,-2)) '%.']);
disp(['Average Recall     (AR) @[ IoU=0.50:0.95 | maxDets=500 ] = ' num2str(roundn(AR_500,-2)) '%.']);
