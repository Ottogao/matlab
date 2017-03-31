function x = f_secvalue (sec)

%F_SECVALUE: Convert the chapter-based section number to a numerical value
%
% Usage: x = f_secvalue (sec);
%
% Inputs: 
%          sec = cell array of strings specifying two-part section numbers with 
%                a decimal point separating chapter number from section number.
%                For example, sec = {'1.5','2.10'}
% Outputs:
%          x = an array of numerical values based on two-digit section 
%              numbers.  For example x = [1.05, 2.10].  This preserves
%              the proper numerical section ordering.

% Initialize 

n = length(sec);
x = zeros(size(sec));

% Insert a zero before single digit section numbers  

for i = 1 : n
    secnum = str2double(sec{i});
    chapter = floor(secnum);
    if chapter < 10
        nchap = 1;
    else
        nchap = 2;
    end
    if (length(sec{i}) - nchap) > 2
        section = secnum - chapter;
    else
        section = (secnum - chapter)/10;
    end
    x(i) = chapter + section;
end
 