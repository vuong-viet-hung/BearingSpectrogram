function data = computeStft(signal)
    data = stft(signal);
    data = data(floorDiv(size(data, 1), 2) + 1:end, :);
    data = abs(data);
    data = convertToDb(data);
end