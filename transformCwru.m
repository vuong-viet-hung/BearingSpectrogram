function transformCwru(dataDir)
    if ~isfolder(dataDir)
        downloadCwru(dataDir)
    end
end