function segmentLength = computeSegmentLength(samplingFrequency, rpm)
    segmentLength = ceilDiv(samplingFrequency * 60, rpm);
end