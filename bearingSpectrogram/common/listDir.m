function files = listDir(name)
    listing = dir(name);
    files = string([numel(listing), 1]);
    for i = 1:numel(listing)
        fileDir = listing(i).folder;
        fileName = listing(i).name;
        files(i) = fullfile(fileDir, fileName);
    end
    files = files';
end