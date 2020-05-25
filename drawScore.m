% displays score at the end of the experiment

function drawScore(window, score)
DrawFormattedText(window, strcat('Your Score: ',...
    num2str(score)), 'center', 'center', [255 255 255]);
end