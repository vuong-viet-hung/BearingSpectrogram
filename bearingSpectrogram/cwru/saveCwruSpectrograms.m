function saveCwruSpectrograms(signalDir, spectrogramDir)
    normalFiles = listDir(fullfile(signalDir, "Normal", "*.mat"));
    faultFiles = listDir(fullfile(signalDir, "12k_DE", "*.mat"));
    signalFiles = vertcat([normalFiles, faultFiles]);
    samplingFreq = 12000;
    
    for i = 1:length(signalFiles)
        [~, fileName, ~] = fileparts(signalFiles(i));
        fprintf("Processing: %s.mat\n", fileName);

        signal = loadCwruSignal(signalFiles(i));
        shaftFreq = shaftFreqFrom(fileName);
        segmentLength = ceilDiv(samplingFreq, shaftFreq);
        saveDir = fullfile(spectrogramDir, fileName);
        saveSpectrograms(signal, segmentLength, saveDir);
    end
end


function shaftFreq = shaftFreqFrom(fileName)
    hps = ["0", "1", "2", "3"];
    rpms = [1797, 1772, 1750, 1730];
    hpToRpm = containers.Map(hps, rpms);
    subStrs = split(fileName, "_");
    hp = subStrs(2);
    rpm = hpToRpm(hp);
    shaftFreq = rpm / 60;
end