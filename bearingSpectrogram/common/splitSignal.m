function [trainSplit, valSplit] = splitSignal(signal, valFraction)
    valSize = ceil(numel(signal) * valFraction);
    trainSize = numel(signal) - valSize;
    valSplit = signal(trainSize + 1:end);
    trainSplit = signal(1:trainSize);
end