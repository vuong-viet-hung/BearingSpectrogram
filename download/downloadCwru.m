function downloadCwru(dataDir)
    url = "https://github.com/XiongMeijing/CWRU-1/archive/refs/heads/master.zip";
    zipFilePath = "CWRU-1-master.zip";
    downloadDir = "CWRU-1-master";
    websave(zipFilePath, url);
    unzip(zipFilePath);
    movefile(fullfile(downloadDir, "Data"), dataDir);
    delete(zipFilePath);
    rmdir(downloadDir, 's');
end