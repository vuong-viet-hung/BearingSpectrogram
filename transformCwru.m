function transformCwru(dataFolder)
    if ~isfolder(dataFolder)
        downloadCwru(dataFolder)
    end
    dataFileInfos = dir(fullfile(dataFolder, "**/*.mat"));
    for i = 1:numel(dataFileInfos)
        dataFileInfo = dataFileInfos(i);
        dataFileFolder = dataFileInfo.folder;
        dataFileName = dataFileInfo.name;
        dataFilePath = fullfile(dataFileFolder, dataFileName);
        data = load(dataFilePath);
        disp(data);
    end
end