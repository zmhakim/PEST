% pulls n emails from emailSet

function [emailData] = getEmails(emailSet, n)
% randomize email set
emailData = [];
randNum = randperm(size(emailSet, 1));
emailSet = emailSet(randNum, :);

% iterate through email set
for i = 1:n
    temp = [emailSet(i, 1), emailSet(i, 2), emailSet(i, 3),...
        emailSet(i, 4), emailSet(i, 5), emailSet(i, 6), emailSet(i, 7)...
        emailSet(i, 8), emailSet(i, 9), emailSet(i, 10)];
    % vertically concatenate email data
    emailData = [emailData; temp];
end
return
end