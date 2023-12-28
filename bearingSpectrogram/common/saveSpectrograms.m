function saveSpectrograms(signal, segmentLength, saveDir)
    if ~isfolder(saveDir)
        mkdir(saveDir);
    end

    segments = segmentSignal(signal, segmentLength);
    for i = 1:size(segments, 1)
        segment = segments(i, :);
        spec = computeSpectrogram(segment);
        file = fullfile(saveDir, sprintf("%04d.mat", i - 1));
        % Save spectrogram as it's computed on one segment for memory
        % suffieciency.
        save(file, "spec");
    end
end


function segments = segmentSignal(signal, segmentLength)
    remainder = mod(length(signal), segmentLength);
    numSegments = floorDiv(length(signal), segmentLength);
    segments = reshape(signal(1:end - remainder), numSegments, ...
        segmentLength);
end


function spec = computeSpectrogram(segment)
    spec = abs(cqt(segment));
    % Keep only the negative frequency half
    spec = spec(1:floorDiv(size(spec, 1), 2), :);
end