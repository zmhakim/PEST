% generalizes pixel values to different display dimensions 
% NOT 100 % ACCURATE

function pixel = getPixels(d, p)
pixel = (round((p ./ d) .* d));
return
end