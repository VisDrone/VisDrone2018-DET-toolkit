function displayImage(imgPath, numImgs, nameImgs, allgt, alldet, isImgDisplay) 
%% show the groundtruth and detection results
if(isImgDisplay)
    for idImg = 1:numImgs
        img = imread(fullfile(imgPath, [nameImgs{idImg}(1:end-4) '.jpg']));
        [height, width, ~] = size(img);
        mask = false(height, width);
        gt = allgt{idImg};
        det = alldet{idImg};      
        % show the ignored regions
        idxIgnore = find(gt(:,6) == 0);
        for k = 1:numel(idxIgnore)
            ignorePos = gt(idxIgnore(k),1:4);
            mask(max(1,ignorePos(2)):min(height,ignorePos(2)+ignorePos(4)), max(1,ignorePos(1)):min(width,ignorePos(1)+ignorePos(3))) = true;
        end
        for c = 1:3
            tmp = img(:,:,c);
            tmp(mask) = max(0,tmp(mask) - 100);
            img(:,:,c) = tmp;
        end
        figure(1),imshow(img); hold on;
        % show the detections
        for k = 1:size(det,1)
            rectangle('position', det(k,1:4), 'linewidth', 1, 'edgecolor', 'r');            
        end          
        % show the groundtruth
        idxObject = find(gt(:,6) ~= 0);
        for k = 1:numel(idxObject)
            rectangle('position', gt(idxObject(k),1:4), 'linewidth', 2, 'edgecolor', 'g');
        end

        title(['#' num2str(idImg) '/' num2str(numImgs) '-->{\color{black}ignored / \color{green}groundtruth / \color{red}detection}']);
        pause(0.5);
%         close all;
    end
end