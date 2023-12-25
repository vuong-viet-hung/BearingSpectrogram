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
    
    for i = 1:numel(signalFiles)
        signal = loadCwruSignal(signalFiles(i));
        [~, fileName, ~] = fileparts(signalFiles(i));
        fileName = fileName + ".mat";
        [trainSplit, valSplit] = splitSignal(signal, 0.2);
        disp("Preprocessing: " + fileName);
        signalSplits = {signal, trainSplit, valSplit};
        for j = 1:numel(splits)
            imfSum = sumImf(signalSplits{j}, 3);
            cfs = createCfs(imfSum, samplingFrequency);
            cfsFile = fullfile(cfsDir, splits(j), fileName);
            save(cfsFile, "cfs");
        end
    end
end