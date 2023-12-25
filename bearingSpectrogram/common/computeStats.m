function [pxMean, pxStd, pxMin, pxMax] = computeStats(cfsDir)
    cfsFiles = listDir(fullfile(cfsDir, "*.mat"));
    pxMin = inf;
    pxMax = -inf;
    pxSum = 0.0;
    pxSumSquare = 0.0;
    numPx = 0;
    for i = 1:numel(cfsFiles)
        data = load(cfsFiles(i));
        cfs = data.cfs;
        pxMin = min(pxMin, min(cfs, [], "all"));
        pxMax = max(pxMax, max(cfs, [], "all"));
        pxSum = pxSum + sum(cfs, "all");
        pxSumSquare = pxSumSquare + sum(cfs.^2, "all");
        numPx = numPx + numel(cfs);
    end
    pxMean = pxSum / numPx;
    pxVar = pxSumSquare / numPx - pxMean;
    pxStd = sqrt(pxVar);
end