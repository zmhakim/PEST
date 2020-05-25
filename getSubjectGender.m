% prompts for subject gender

function subjectGender = getSubjectGender()
subjectGender = [];

% record subject gender
while isempty(subjectGender)
    subjectGender = input('Subject Gender (M/F): ', 's');
end
return
end