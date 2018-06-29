function [newgt, newdet] = dropObjectsInIgr(gt, det, imgHeight, imgWidth)
%% drop annotations and detections in ignored region

% parse objects
idxFr = gt(:, 6) ~= 0;
curgt = gt(idxFr,:);
% parse ignored regions
idxIgr = gt(:, 6) == 0;
igrRegion = max(1,gt(idxIgr, 1:4));
if(~isempty(igrRegion))
    igrMap = zeros(imgHeight, imgWidth);
    numIgr = size(igrRegion,1);
    for j = 1:numIgr
        igrMap(igrRegion(j,2):min(imgHeight,igrRegion(j,2)+igrRegion(j,4)),igrRegion(j,1):min(imgWidth,igrRegion(j,1)+igrRegion(j,3))) = 1;
    end
    intIgrMap = createIntImg(double(igrMap));
    idxLeftGt = [];
    for i = 1:size(curgt, 1)
        pos = max(1,round(curgt(i,1:4)));
        x = max(1, min(imgWidth, pos(1)));
        y = max(1, min(imgHeight, pos(2)));
        w = pos(3);
        h = pos(4);
        tl = intIgrMap(y, x);
        tr = intIgrMap(y, min(imgWidth,x+w));
        bl = intIgrMap(max(1,min(imgHeight,y+h)), x);
        br = intIgrMap(max(1,min(imgHeight,y+h)), min(imgWidth,x+w));
        igrVal = tl + br - tr - bl; 
        if(igrVal/(h*w)<0.5)
            idxLeftGt = cat(1, idxLeftGt, i);
        end
    end
    curgt = curgt(idxLeftGt, :);
    
    idxLeftDet = [];
    for i = 1:size(det, 1)
        pos = max(1,round(det(i,1:4)));
        x = max(1, min(imgWidth, pos(1)));
        y = max(1, min(imgHeight, pos(2)));
        w = pos(3);
        h = pos(4);
        tl = intIgrMap(y, x);
        tr = intIgrMap(y, min(imgWidth,x+w));
        bl = intIgrMap(max(1,min(imgHeight,y+h)), x);
        br = intIgrMap(max(1,min(imgHeight,y+h)), min(imgWidth,x+w));
        igrVal = tl + br - tr - bl; 
        if(igrVal/(h*w)<0.5)
            idxLeftDet = cat(1, idxLeftDet, i);
        end
    end
    det = det(idxLeftDet, :);    
end
newgt = curgt;
newdet = det;
