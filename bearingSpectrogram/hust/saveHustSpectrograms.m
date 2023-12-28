function saveHustSpectrograms(signalDir, spectrogramDir)
    signalFiles = listDir(fullfile(signalDir, "*.mat"));
    samplingFreq = 51200;
    
    for i = 1:length(signalFiles)
        [~, fileName, ~] = fileparts(signalFiles(i));
        fprintf("Processing: %s.mat\n", fileName);
        
        [signal, shaftFreq] = loadHustSignal(signalFiles(i));
        segmentLength = ceilDiv(samplingFreq, shaftFreq);
        saveDir = fullfile(spectrogramDir, fileName);
        saveSpectrograms(signal, segmentLength, saveDir);
    end
end