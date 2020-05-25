% gets email data and passes it to cycleEmails function

function [data, score, isFirst] = runTask(emailSet1, emailSet2,...
    emailSet3, emailSet4, window, w, h, score, isFirst, outFile1,...
    outFile2)
% pull 40 emails from each set
[emailData] = getEmails(emailSet1, 40);
[emailData] = [emailData; getEmails(emailSet2, 40)];
[emailData] = [emailData; getEmails(emailSet3, 40)];
[emailData] = [emailData; getEmails(emailSet4, 40)];

% randomize emails
randNum = randperm(size(emailData, 1));
emailData = emailData(randNum, :);

[r, ~] = size(emailData);
data = [];

% iterate through emails
[data, score, isFirst] = cycleEmails(emailData, data, r, r,...
    window, w, h, score, isFirst, outFile1, outFile2);
return
end