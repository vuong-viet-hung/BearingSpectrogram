function saveCwruCfs(signalDir, cfsDir)
    splits = ["all", "train", "val"];
    for i = 1:numel(splits)
        subdir = fullfile(cfsDir, splits(i));
        if ~isfolder(subdir)
            mkdir(subdir)
        end
    end

    normalFiles = listDir(fullfile(signalDir, "Normal/*.mat"));
    faultFiles = listDir(fullfile(signalDir, "12k_DE/*.mat"));
    signalFiles = vertcat([normalFiles, faultFiles]);
    samplingFrequency = 12000;
    rpms = [1797, 1772, 1750, 1730];
    
    for i = 1:numel(signalFiles)
        signal = loadCwruSignal(signalFiles(i));
        [~, fileName, ~] = fileparts(signalFiles(i));
        [trainSplit, valSplit] = splitSignal(signal, 0.2);
        fprintf("Processing: %s.mat\n", fileName);
        signalSplits = {signal, trainSplit, valSplit};
        for j = 1:numel(splits)
            imfSum = sumImf(signalSplits{j}, 3);
            subStrs = split(fileName, "_");
            hp = str2double(subStrs(2));
            rpm = rpms(hp + 1);
            segmentLength = computeSegmentLength(samplingFrequency, rpm);
            saveDir = fullfile(cfsDir, splits(j), fileName);
            saveCfs(imfSum, segmentLength, samplingFrequency, saveDir);
        end
    end
end