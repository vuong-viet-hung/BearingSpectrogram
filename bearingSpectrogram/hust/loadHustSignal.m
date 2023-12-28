function [signal, shaftFreq] = loadHustSignal(dataFilePath)
    data = load(dataFilePath);
    signal = data.data;
    shaftFreq = data.fs;
end