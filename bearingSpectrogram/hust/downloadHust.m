function downloadHust(signalDir)
    downloadUrl = "https://prod-dcd-datasets-cache-zipfiles.s3.eu-west-1.amazonaws.com/cbv7jyx4p9-3.zip";
    downloadFile = "HUST bearing a practical dataset for ball bearing fault diagnosis.zip";
    extractDir = "HUST bearing a practical dataset for ball bearing fault diagnosis";

    websave(downloadFile, downloadUrl);
    unzip(downloadFile);
    movefile(fullfile(extractDir, "HUST bearing dataset"), signalDir);
    delete(downloadFile);
    rmdir(extractDir, "s");
end