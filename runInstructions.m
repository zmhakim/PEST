% displays instruction sequence

function [instrWindow] = runInstructions(instructions)
% open window
screen = 0;
bgColor = [0 0 0];
[instrWindow, ~] = Screen('OpenWindow', screen, bgColor);
[~, h] = Screen('WindowSize', instrWindow);

% set text size
Screen('TextSize', instrWindow, 40);

% draw first instruction
drawInstructions(instrWindow, char(instructions(1, 1)),...
    char(instructions(1, 2)), h);
Screen('Flip', instrWindow, [], 0);

[r, ~] = size(instructions);
isBreak = false;

% cycle instruction sequence
for i = 2:r
    keyNames = {'space' 'q'};
    for j = 1:length(keyNames)
        keys(j) = KbName(keyNames{j});
    end
    validKeys = [1];
    timeOut = GetSecs+60;
    Pressed = 0;
    while ~Pressed && (GetSecs < timeOut)
            [key, ~, keyCode] = KbCheck(-1);
            if key && sum(keyCode(keys))
                keyNum = find(keyCode(keys), 1);
                if keyNum == 1
                    drawInstructions(instrWindow,...
                        char(instructions(i, 1)),...
                        char(instructions(i, 2)), h);
                elseif keyNum == 2
                    isBreak = true;
                    break
                end
                if ~isempty(intersect(keyNum, validKeys))
                    Pressed = 1;
                end
            end
    end
    if isBreak
        sca
    end
    Screen('Flip', instrWindow, [], 0);
    WaitSecs(0.5);
end
WaitSecs(2)
return
end