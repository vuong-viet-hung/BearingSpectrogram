function saveCqt(signal, segmentLength, saveDir)
    if ~isfolder(saveDir)
        mkdir(saveDir);
    end

    numSegments = floorDiv(numel(signal), segmentLength);
    for i = 1:numSegments
        segment = signal(i:i + segmentLength - 1);
        data = computeCqt(segment);
        file = fullfile(saveDir, sprintf("%04d.mat", i - 1));
        save(file, "data");
    end
end