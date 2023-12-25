function downloadHust(signalDir)
    downloadUrl = "https://github.com/XiongMeijing/CWRU-1/archive/refs/heads/master.zip";
    downloadFile = "CWRU-1-master.zip";
    extractDir = "CWRU-1-master";

    websave(downloadFile, downloadUrl);
    unzip(downloadFile);
    movefile(fullfile(extractDir, "Data"), signalDir);
    delete(downloadFile);
    rmdir(extractDir, "s");
end