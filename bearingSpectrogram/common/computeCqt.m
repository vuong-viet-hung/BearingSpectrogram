function data = computeCqt(signal, samplingFrequency)
    data = cqt(signal, 'SamplingFrequency', samplingFrequency);
    data = data(floorDiv(size(data, 1), 2) + 1:end, :);
    data = abs(data);
    data = convertToDb(data);
end