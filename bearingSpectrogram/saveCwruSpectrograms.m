function saveCwruSpectrograms(signalDir, spectrogramDir)
    downloadTo(signalDir)
    
    files = listCwruDir(signalDir);
    samplingFreq = 12000;
    
    for i = 1:length(files)
        [~, fileName, ~] = fileparts(files(i));
        fprintf("Processing: %s.mat\n", fileName);

        signal = loadSignal(files(i));

        shaftFreq = shaftFreqFrom(fileName);
        segmentLength = ceilDiv(samplingFreq, shaftFreq);
        saveDir = fullfile(spectrogramDir, fileName);
        saveSpectrograms(signal, segmentLength, saveDir);
    end
end


function downloadTo(signalDir)
    if isfolder(signalDir)
        return
    end

    downloadUrl = "https://github.com/XiongMeijing/CWRU-1/archive/refs/heads/master.zip";
    downloadFile = "CWRU-1-master.zip";
    extractDir = "CWRU-1-master";

    fprintf("Downloading to: %s\n", signalDir);
    websave(downloadFile, downloadUrl);
    unzip(downloadFile);
    movefile(fullfile(extractDir, "Data"), signalDir);
    
    delete(downloadFile);
    rmdir(extractDir, "s");
end


function files = listCwruDir(signalDir)
    normalFiles = listDir(fullfile(signalDir, "Normal", "*.mat"));
    faultFiles = listDir(fullfile(signalDir, "12k_DE", "*.mat"));
    files = [normalFiles; faultFiles];
end


function signal = loadSignal(dataFilePath)
    data = load(dataFilePath);
    fieldNames = fieldnames(data);
    signalFieldName = "";
    for i = 1:length(fieldNames)
        if endsWith(fieldNames(i), "DE_time")
            signalFieldName = strjoin(fieldNames(i), "");
        end
    end
    signal = data.(signalFieldName);
end


function shaftFreq = shaftFreqFrom(fileName)
    hps = ["0" "1" "2" "3"];
    rpms = [1797 1772 1750 1730];
    hpToRpm = containers.Map(hps, rpms);

    subStrs = split(fileName, "_");
    hp = subStrs(2);
    rpm = hpToRpm(hp);
    shaftFreq = rpm / 60;
end