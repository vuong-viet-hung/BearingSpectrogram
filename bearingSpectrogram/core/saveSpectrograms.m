function saveSpectrograms(signal, segmentLength, saveDir)
    if ~isfolder(saveDir)
        mkdir(saveDir);
    end

    segments = segmentSignal(signal, segmentLength);
    for i = 1:size(segments, 1)
        segment = segments(i, :);
        spec = abs(cqt(segment));
        % To keep only the positive frequency
        spec = spec(floorDiv(size(spec, 1), 2) + 1:end, :);
        file = fullfile(saveDir, sprintf("%04d.mat", i - 1));
        save(file, "spec");
    end
end