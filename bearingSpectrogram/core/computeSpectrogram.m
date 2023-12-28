function spec = computeSpectrogram(signal)
    spec = abs(cqt(signal));
    spec = spec(floorDiv(size(spec, 1), 2) + 1:end, :);
end