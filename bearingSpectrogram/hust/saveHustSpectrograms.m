function saveHustCqt(signalDir, cqtDir)
    signalFiles = listDir(fullfile(signalDir, "*.mat"));
    samplingFrequency = 51200;
    
    for i = 1:numel(signalFiles)
        [signal, shaftFrequency] = loadHustSignal(signalFiles(i));
        [~, fileName, ~] = fileparts(signalFiles(i));
        fprintf("Processing: %s.mat\n", fileName);
        segmentLength = ceilDiv(samplingFrequency, shaftFrequency);
        saveDir = fullfile(cqtDir, fileName);
        saveCqt(signal, segmentLength, saveDir);
    end
end