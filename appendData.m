% appends trial data and draws key press feedback

function [data] = appendData(timeOn, emails, hasAtt, data, score,...
    window, shift, num, i, w, h)
timeOff = GetSecs - timeOn;

% append trial data
temp = [num2str(num), timeOff, emails(i,4), emails(i,5),...
    hasAtt, emails(i,6), emails(i,2), score];
data = [data; temp];

% key press visual feedback
Screen('FillRect', window, [255 0 0], [getPixels(w, (550 + shift))...
    getPixels(h, 930) getPixels(w, (650 + shift)) getPixels(h, 1000)]);
DrawFormattedText(window, num2str(num), getPixels(w, 595 + shift),...
    getPixels(h, 970), [255 255 255], 100);
return
end