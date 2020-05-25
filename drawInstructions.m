% draws experiment instructions

function drawInstructions(window, instr, imageName, h)
% if image prompt -> draw image
if strcmp(instr, 'getImage')
    image = imread(strcat(pwd, imageName));
    imageTexture = Screen('MakeTexture', window, image);
    Screen('DrawTexture', window, imageTexture, [], [], 0);
    DrawFormattedText(window, 'Press Space to Continue', 'center',...
        getPixels(h, 700), [0 0 0]);
% else -> draw instruction
else
    DrawFormattedText(window, instr, 'center', 'center',...
        [255 255 255], [], [], [], 2);
    DrawFormattedText(window, 'Press Space to Continue', 'center',...
        getPixels(h, 950), [255 255 255]);
end
end