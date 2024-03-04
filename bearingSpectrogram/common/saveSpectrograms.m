function saveSpectrograms(signal, segmentLength, saveDir)
    if ~isfolder(saveDir)
        mkdir(saveDir);
    end
    
    segments = segmentSignal(signal, segmentLength);
    for i = 1:size(segments, 2)
        segment = segments(:, i);
        spec = computeSpectrogram(segment);
        file = fullfile(saveDir, sprintf("%04d.mat", i - 1));
        % Save spectrogram as it's computed on one segment for memory
        % suffieciency
        saveAs(file, spec);
    end
end


function segments = segmentSignal(signal, segmentLength)
    remainder = mod(length(signal), segmentLength);
    numSegments = floorDiv(length(signal), segmentLength);
    segments = reshape(signal(1:end - remainder), segmentLength, ...
        numSegments);
end


function spec = computeSpectrogram(segment)
    spec = abs(cqt(segment));
    spec = convertToDb(spec);
    % Keep only the negative frequency half
    spec = spec(1:floorDiv(size(spec, 1), 2), :);
end


function spec = convertToDb(spec)
    spec = 10 * log10(spec);
end


function saveAs(file, spec)
    data = spec;
    save(file, "data");
end