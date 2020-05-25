% main experiment execution

clear;

% log subject info
subjectID = getSubjectID();
subjectAge = getSubjectAge();
subjectGender = upper(getSubjectGender());

% format date
rng('shuffle');
str = datestr(now);
str(str=='-') = '';
str(str==':') = '';
str(str==' ') = '';

% define output files

% cloud data store
outFile1 = strcat('PATH_TO_OUT/pestdata_', num2str(subjectID), '_',...
    str, '_', num2str(subjectAge), '_', subjectGender, '.dat');

% local data store
outFile2 = strcat(pwd, '/data/pestdata_', num2str(subjectID), '_',...
    str, '_', num2str(subjectAge), '_', subjectGender, '.dat');

% read excel files
[~, instructions] = xlsread('resources/instructions.xlsx', 'instructions');
[~, simPhish] = xlsread('resources/emails/sim-phish.xlsx', 'emails');
[~, simSafe] = xlsread('resources/emails/sim-safe.xlsx', 'emails');
[~, realPhish] = xlsread('resources/emails/real-phish.xlsx', 'emails');
[~, realSafe] = xlsread('resources/emails/real-safe.xlsx', 'emails');

Screen('Preference', 'SkipSyncTests', 1)

% run instruction sequence
[instrWindow] = runInstructions(instructions);
WaitSecs(2);
Screen('Close', instrWindow);

% open window
screen = 0;
bgColor = [255 255 255];
[window, rect] = Screen('OpenWindow', screen, bgColor);
[w, h] = Screen('WindowSize', window);

% set text font and size
oldTextFont = Screen('TextFont', window, 'Calibri');
oldTextSize = Screen('TextSize', window, 20);

score = 0;
isFirst = false;

% run task sequence
[data, score, isFirst] = runTask(simPhish, simSafe,...
    realPhish, realSafe, window, w, h, score, isFirst,...
    outFile1, outFile2);

% if first trial -> quit experiment
if isFirst
    Screen('CloseAll')
    sca
end

% convert data to table for writing
data = cell2table(data, 'VariableNames', {'userId', 'reactTime',...
    'category', 'type', 'hasAtt', 'realId', 'emailCode', 'score'});

% write data output
writetable(data, outFile1);
writetable(data, outFile2);

% run subject score
runScore(score);

% end experiment
Screen('CloseAll');
sca