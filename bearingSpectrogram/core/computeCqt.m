function data = computeCqt(signal)
    data = cqt(signal);
    data = data(floorDiv(size(data, 1), 2) + 1:end, :);
    data = abs(data);
    data = 10 * log10(data);
end