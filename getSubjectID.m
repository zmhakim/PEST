% prompts for subject id

function subjectID = getSubjectID()
subjectID = [];

% record subject id
while isempty(subjectID)
    subjectID = input('Subject ID: ');
end
return
end