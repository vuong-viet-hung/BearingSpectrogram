function score = correlate(signal, imf)
    num = dot(signal, imf);
    det = norm(signal) * norm(imf);
    score = num / det;
end