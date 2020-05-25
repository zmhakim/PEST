% prompts for subject age

function subjectAge = getSubjectAge()
subjectAge = [];

% record subject age
while isempty(subjectAge)
    subjectAge = input('Subject Age: ');
end
return
end