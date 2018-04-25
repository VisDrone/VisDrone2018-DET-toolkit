function [allgt, alldet] = saveAnnoRes(gtPath, resPath, numImgs, nameImgs)
% process the annotations and groundtruth
allgt = cell(1,numImgs);
alldet = cell(1,numImgs);

for idImg = 1:numImgs
    oldgt = load(fullfile(gtPath, nameImgs{idImg}));
    det = load(fullfile(resPath, nameImgs{idImg}));
    % remove the objects in ignored regions or labeled as others
    gt = oldgt;
    gt(oldgt(:,5) == 0, 5) = 1;
    gt(oldgt(:,5) == 1, 5) = 0; 
    [~, id] = sort(-det(:,5));
    allgt{idImg} = gt;
    alldet{idImg} = det(id,:);
end
