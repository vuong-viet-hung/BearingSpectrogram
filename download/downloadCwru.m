function downloadCwru
    url = "https://github.com/XiongMeijing/CWRU-1/archive/refs/heads/master.zip";
    compressedFilePath = "CWRU-1-master.zip";
    repoDir = "CWRU-1-master";
    srcDataDir = fullfile(repoDir, "Data");
    dstDataDir = "data";
    if isfile(dstDataDir)
        return;
    end
    websave(compressedFilePath, url);
    unzip(compressedFilePath);
    movefile(srcDataDir, dstDataDir);
    delete(compressedFilePath);
    rmdir(repoDir, 's');
end