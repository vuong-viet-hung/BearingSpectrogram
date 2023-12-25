function saveCwruCqt(signalDir, cqtDir)
    normalFiles = listDir(fullfile(signalDir, "Normal/*.mat"));
    faultFiles = listDir(fullfile(signalDir, "12k_DE/*.mat"));
    signalFiles = vertcat([normalFiles, faultFiles]);
    samplingFrequency = 12000;
    rpms = [1797, 1772, 1750, 1730];
    
    for i = 1:numel(signalFiles)
        signal = loadCwruSignal(signalFiles(i));
        [~, fileName, ~] = fileparts(signalFiles(i));
        fprintf("Processing: %s.mat\n", fileName);
        subStrs = split(fileName, "_");
        hp = str2double(subStrs(2));
        rpm = rpms(hp + 1);
        segmentLength = computeSegmentLength(samplingFrequency, rpm);
        saveDir = fullfile(cqtDir, fileName);
        saveCqt(signal, segmentLength, saveDir);
    end
end