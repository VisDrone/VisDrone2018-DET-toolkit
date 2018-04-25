function nameImgs = findImageList(gtPath)

d = dir(gtPath);
nameImgs = {d.name}';
nameImgs(ismember(nameImgs,{'.','..'})) = [];