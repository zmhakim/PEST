% cycles through emails and records key responses

function [data, score, isFirst] = cycleEmails(emails, data, nCycles,...
    nEmails, window, w, h, score, isFirst, outFile1, outFile2)
emailCount = nEmails;

% randomize link vs attachment
hasLink = zeros(1, 160);
hasLink(81:160) = 1;
randNum = randperm(length(hasLink));
hasLink = hasLink(randNum);

isBreak = false;
maxScore = 160;

% iterate through emails
for i = 1:nCycles
    hasAtt = false;
    emailBody = emails(i, 3);
    if hasLink(i) == 0
        if ~strcmp(char(emails(i, 7)), 'Attachment Name')
            hasAtt = true;
            emailBody = emails(i, 9);
        end
    end
    drawEmail(w, h, char(emails(i,1)), char(emails(i,10)),...
        char(emailBody), window, emailCount - i, hasAtt,...
        char(emails(i,7)))
    Screen('Flip', window, [], 0);
    timeOn = GetSecs;
    keyNames = {'LeftShift' 'z' '/?' 'RightShift' 'q'};
    for j = 1:length(keyNames)
        keys(j) = KbName(keyNames{j});
    end
    validKeys = [1 2 3 4];
    timeOut = GetSecs+60;
    Pressed = 0;
    drawEmail(w, h, char(emails(i,1)), char(emails(i,10)),...
        char(emailBody), window, emailCount - i, hasAtt,...
        char(emails(i,7)));
    % record keyboard response
    while ~Pressed && (GetSecs < timeOut)
        [key, ~, keyCode] = KbCheck(-1);
        if key && sum(keyCode(keys))
            % save trial data on key press
            keyNum = find(keyCode(keys), 1);
            if keyNum == 1
                if strcmp(char(emails(i, 6)), 'Safe')
                    score = score + 2;
                elseif ~strcmp(char(emails(i, 6)), 'Safe')
                    score = score - 2;
                end
                [data] = appendData(timeOn, emails, hasAtt,...
                    data, score, window, 0, 1, i, w, h);
            elseif keyNum == 2
                if strcmp(char(emails(i, 6)), 'Safe')
                    score = score + 1;
                elseif ~strcmp(char(emails(i, 6)), 'Safe')
                    score = score - 1;
                end
                [data] = appendData(timeOn, emails, hasAtt,...
                    data, score, window, 300, 2, i, w, h);
            elseif keyNum == 3
                if strcmp(char(emails(i, 6)), 'Scam')
                    score = score + 1;
                elseif ~strcmp(char(emails(i, 6)), 'Scam')
                    score = score - 1;
                end
                [data] = appendData(timeOn, emails, hasAtt,...
                    data, score, window, 600, 3, i, w, h);
            elseif keyNum == 4
                if strcmp(char(emails(i, 6)), 'Scam')
                    score = score + 2;
                elseif ~strcmp(char(emails(i, 6)), 'Scam')
                    score = score - 2;
                end
                [data] = appendData(timeOn, emails, hasAtt,...
                    data, score, window, 900, 4, i, w, h);
            elseif keyNum == 5
                isBreak = true;
                break
            end
            if ~isempty(intersect(keyNum, validKeys))
                Pressed = 1;
            end
        end
    end
    % quit conditions
    if isBreak && i == 1
        isFirst = true;
        break
    elseif isBreak
        break
    end
    
    % write data output after each trial
    writetable(cell2table(data), outFile1);
    writetable(cell2table(data), outFile2);
    
    Screen('Flip', window, [], 0);
    WaitSecs(0.5);
    
    % if score threshold is met -> quit experiment
    if score >= maxScore
        break
    end
end
return
end