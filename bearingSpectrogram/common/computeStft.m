function data = computeStft(signal, samplingFrequency)
    data = stft(signal, samplingFrequency);
    data = data(floorDiv(size(data, 1), 2) + 1:end, :);
    data = abs(data);
    data = convertToDb(data);
end