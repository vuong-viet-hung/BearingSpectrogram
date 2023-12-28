function segments = segmentSignal(signal, segmentLength)
    remainder = mod(length(signal), segmentLength);
    numSegments = floorDiv(length(signal), segmentLength);
    segments = reshape(signal(1:end - remainder), numSegments, ...
        segmentLength);
end