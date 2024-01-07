function saveHustSpectrograms(signalDir, spectrogramDir)
    downloadTo(signalDir);

    files = listHustDir(signalDir);
    samplingFreq = 51200;
    
    for i = 1:length(files)
        [~, fileName, ~] = fileparts(files(i));
        fprintf("Processing: %s.mat\n", fileName);
        
        [signal, shaftFreq] = loadSignal(files(i));

        segmentLength = ceilDiv(samplingFreq, shaftFreq);
        saveDir = fullfile(spectrogramDir, fileName);
        saveSpectrograms(signal, segmentLength, saveDir);
    end
end


function downloadTo(signalDir)
    if isfolder(signalDir)
        return
    end

    downloadUrl = "https://prod-dcd-datasets-cache-zipfiles.s3.eu-west-1.amazonaws.com/cbv7jyx4p9-3.zip";
    downloadFile = "HUST bearing a practical dataset for ball bearing fault diagnosis.zip";
    extractDir = "HUST bearing a practical dataset for ball bearing fault diagnosis";

    fprintf("Downloading to: %s\n", signalDir);
    websave(downloadFile, downloadUrl);
    unzip(downloadFile);
    movefile(fullfile(extractDir, "HUST bearing dataset"), signalDir);
    
    delete(downloadFile);
    rmdir(extractDir, "s");
end


function files = listHustDir(signalDir)
    files = [ ...
        listDir(fullfile(signalDir, "N5*.mat"))
        listDir(fullfile(signalDir, "N6*.mat"))
        listDir(fullfile(signalDir, "N7*.mat"))
        listDir(fullfile(signalDir, "I5*.mat"))
        listDir(fullfile(signalDir, "I6*.mat"))
        listDir(fullfile(signalDir, "I7*.mat"))
        listDir(fullfile(signalDir, "O6*.mat"))
        listDir(fullfile(signalDir, "O5*.mat"))
        listDir(fullfile(signalDir, "O7*.mat"))
        listDir(fullfile(signalDir, "B5*.mat"))
        listDir(fullfile(signalDir, "B6*.mat"))
        listDir(fullfile(signalDir, "B7*.mat"))];
end


function [signal, shaftFreq] = loadSignal(dataFilePath)
    data = load(dataFilePath);
    signal = data.data;
    shaftFreq = data.fs;
end