function signal = loadCwruSignal(dataFilePath)
    data = load(dataFilePath);
    fieldNames = fieldnames(data);
    signalFieldName = "";
    for i = 1:numel(fieldNames)
        if endsWith(fieldNames(i), "DE_time")
            signalFieldName = strjoin(fieldNames(i), "");
        end
    end
    signal = data.(signalFieldName);
end