clc;
clear all;close all;
warning off; %#ok<WNOFF>

datasetPath = 'VisDrone2018-VID-test-challenge\'; % dataset path
resPath = 'Faster-RCNN_results-test-challenge\'; % result path

gtPath = fullfile(datasetPath, 'annotations'); % annotation path
seqPath = fullfile(datasetPath, 'sequences'); % sequence path
nameSeqs = findSeqList(gtPath); % seq list
numSeqs = length(nameSeqs);

%% process the annotations and groundtruth
allgt = cell(1,numSeqs);
alldet = cell(1,numSeqs);

for idSeq = 1:numSeqs
    oldgt = load(fullfile(gtPath, nameSeqs{idSeq}));
    det = load(fullfile(resPath, nameSeqs{idSeq}));
    % remove the objects in ignored regions or labeled as others
    gt = oldgt;
    gt(oldgt(:,7) == 0, 7) = 1;
    gt(oldgt(:,7) == 1, 7) = 0; 
    [~, id] = sort(-det(:,7));
    allgt{idSeq} = gt(:,1:8);
    alldet{idSeq} = det(id,1:8);
end

%% claculate average precision and recall over all 10 IoU thresholds (i.e., [0.5:0.05:0.95]) of all object categories
AP = zeros(10, 10);
AR = zeros(10, 10, 4);

for idClass = 1:10
    x = 0;
    for thr = 0.5:0.05:0.95
        x = x + 1;
        y = 0;
        for maxDets = [1 10 100 500]
            y = y + 1;
            gtMatch = [];
            detMatch = [];    
            for idImg = 1:numSeqs
                gt = allgt{numSeqs};
                det = alldet{numSeqs};  
                frs = unique(gt(:,1));
                for i = 1:numel(frs)
                    idxGtCurClass = gt(:, 1) == frs(i) & gt(:, 8) == idClass;
                    idxDetCurClass = det(:, 1) == frs(i) & det(:, 8) == idClass;
                    gt0 = gt(idxGtCurClass,3:7);
                    dt0 = det(idxDetCurClass,3:7); 
                    if(~isempty(dt0))
                        dt0 = dt0(1:min(size(dt0,1),maxDets),:);
                    end
                    [gt1, dt1] = evalRes(gt0, dt0, thr);
                    gtMatch = cat(1, gtMatch, gt1(:,5));
                    detMatch = cat(1, detMatch, dt1(:,5:6));
                end
            end 

            [~,idrank] = sort(-detMatch(:,1));
            tp = cumsum(detMatch(idrank,2)==1);
            rec = tp/max(1,numel(gtMatch));
            if(~isempty(rec))
                AR(idClass, x, y) = max(rec)*100;
            end
        end
        fp = cumsum(detMatch(idrank,2)==0);        
        prec = tp./max(1,(fp+tp));
        AP(idClass, x) = VOCap(rec,prec)*100;
    end
end

AP_all = mean2(AP); % calculate APmax=0.50:0.95
AP_50 = mean2(AP(:,1)); % calculate APmax=0.50
AP_75 = mean2(AP(:,6)); % calculate APmax=0.75
AR_1 = mean2(AR(:,:,1)); % the maximum recall given 1 detection per frame
AR_10 = mean2(AR(:,:,2)); % the maximum recall given 10 detections per frame
AR_100 = mean2(AR(:,:,3)); % the maximum recall given 100 detections per frame
AR_500 = mean2(AR(:,:,4)); % the maximum recall given 500 detections per frame

%% print the average precision and recall
disp(['Average Precision  (AP) @[ IoU=0.50:0.95 | maxDets=500 ] = ' num2str(roundn(AP_all,-2)) '%.']);
disp(['Average Precision  (AP) @[ IoU=0.50      | maxDets=500 ] = ' num2str(roundn(AP_50,-2)) '%.']);
disp(['Average Precision  (AP) @[ IoU=0.75      | maxDets=500 ] = ' num2str(roundn(AP_75,-2)) '%.']);

disp(['Average Recall     (AR) @[ IoU=0.50:0.95 | maxDets=  1 ] = ' num2str(roundn(AR_1,-2)) '%.']);
disp(['Average Recall     (AR) @[ IoU=0.50:0.95 | maxDets= 10 ] = ' num2str(roundn(AR_10,-2)) '%.']);
disp(['Average Recall     (AR) @[ IoU=0.50:0.95 | maxDets=100 ] = ' num2str(roundn(AR_100,-2)) '%.']);
disp(['Average Recall     (AR) @[ IoU=0.50:0.95 | maxDets=500 ] = ' num2str(roundn(AR_500,-2)) '%.']);