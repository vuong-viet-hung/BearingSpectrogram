function imfSum = sumImf(imfSum, numImf)
    imf = emd(imfSum);
    imfSum = sum(imf(:, 1:numImf), 2);
end