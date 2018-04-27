function [allgt, alldet] = saveAnnoRes(gtPath, resPath, imgPath, numImgs, nameImgs, isNMS, nmsThre)
%% process the annotations and groundtruth
allgt = cell(1,numImgs);
alldet = cell(1,numImgs);

for idImg = 1:numImgs
    oldgt = load(fullfile(gtPath, nameImgs{idImg}));
    det = load(fullfile(resPath, nameImgs{idImg}));
    % remove the objects in ignored regions or labeled as others
    img = imread(fullfile(imgPath, [nameImgs{idImg}(1:end-4) '.jpg']));
    [imgHeight, imgWidth, ~] = size(img);     
    newgt = dropObjectsInIgr(oldgt, imgHeight, imgWidth);
    gt = newgt;
    gt(newgt(:,5) == 0, 5) = 1;
    gt(newgt(:,5) == 1, 5) = 0; 
    % NMS
    if(isNMS)
        pick = nms(det, nmsThre);
        det = det(pick,:);
    end
    [~, id] = sort(-det(:,5));
    allgt{idImg} = gt;
    alldet{idImg} = det(id,:);
end