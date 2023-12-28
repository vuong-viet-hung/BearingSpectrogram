function saveSpectrograms(signal, segmentLength, saveDir)
    if ~isfolder(saveDir)
        mkdir(saveDir);
    end

    segments = segmentSignal(signal, segmentLength);
    for i = 1:size(segments, 1)
        segment = segments(i, :);
        spec = abs(cqt(segment));
        % Keep only the negative frequency half
        spec = spec(1:floorDiv(size(spec, 1), 2), :);
        file = fullfile(saveDir, sprintf("%04d.mat", i - 1));
        save(file, "spec");
    end
end