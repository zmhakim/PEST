% displays subject score

function runScore(totalScore)
% open new window
whichScreen = 0;
bgColor = [0 0 0];
[window, ~] = Screen('OpenWindow', whichScreen, bgColor);

% set text size
Screen('TextSize', window, 50);

% draw subject score
drawScore(window, totalScore);
Screen('Flip', window, [], 0);
WaitSecs(5)
end
