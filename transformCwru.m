function transformCwru(signalFolder, spectrogramFolder, subset)
    if ~isfolder(signalFolder)
        downloadCwru(signalFolder)
    end
    if ~isfolder(fullfile(spectrogramFolder, subset))
        mkdir(fullfile(spectrogramFolder, subset))
    end
    normalFileInfos = dir(fullfile(signalFolder, "Normal", "**/*.mat"));
    faultFileInfos = dir(fullfile(signalFolder, subset, "**/*.mat"));
    fileInfos = vertcat(normalFileInfos, faultFileInfos);
    substrs = split(subset, '_');
    samplingRate = substrs(1);
    dataEnd = substrs(2);
    if samplingRate == "12k"
        samplingRate = 12000;
    else
        samplingRate = 48000;
    end
    rpms = [1797, 1772, 1750, 1730];
    for i = 1:numel(fileInfos)
        fileFolder = fileInfos(i).folder;
        fileName = fileInfos(i).name;
        filePath = fullfile(fileFolder, fileName);
        data = load(filePath);
        fieldNames = fieldnames(data);
        signalFieldName = "";
        for j = 1:numel(fieldNames)
            if endsWith(fieldNames(j), dataEnd + "_time")
                signalFieldName = strjoin(fieldNames(j), "");
            end
        end
        signal = data.(signalFieldName);
        signalShape = size(signal);
        signalLength = signalShape(1);
        [~, fileNameNoExt, ~] = fileparts(filePath);
        substrs = split(fileNameNoExt, "_");
        hp = substrs(2);
        rpm = rpms(str2double(hp) + 1);
        segmentLength = floorDiv(samplingRate * 60, rpm);
        numSegments = floorDiv(signalLength, segmentLength);
        for k = 1:numSegments
            segment = signal( ...
                segmentLength * (k - 1) + 1:segmentLength * k);
            spectrogram = cqt(segment, "SamplingFrequency", samplingRate);
            segmentIdx = sprintf("%04d", k - 1);
            spectrogramFilePath = fullfile( ...
                spectrogramFolder, subset, ...
                fileNameNoExt + "_" + segmentIdx + ".mat");
            save(spectrogramFilePath, "spectrogram");
        end
    end
end