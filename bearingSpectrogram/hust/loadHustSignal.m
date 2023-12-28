function [signal, shaftFrequency] = loadHustSignal(dataFilePath)
    data = load(dataFilePath);
    signal = data.data;
    shaftFrequency = data.fs;
end