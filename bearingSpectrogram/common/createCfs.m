function cfs = createCfs(signal, samplingFrequency)
    cfs = cqt(signal, 'SamplingFrequency', samplingFrequency);
    cfs = cfs(floorDiv(size(cfs, 1), 2) + 1:end, :);
    cfs = abs(cfs);
    cfs = convertToDb(cfs);
end