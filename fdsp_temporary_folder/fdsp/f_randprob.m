function [prob,np] = f_randprob (np,sec,problems,mode,nums)

%F_GENHOME: Create pushbutton for selecting a random set of homework problems
%
% Usage: [prob,np,sec] = f_randprob (np,sec,problems,mode,nums)
%
% Inputs: 
%          np       = default number of number problems 
%          sec      = 1 by 2 array containing default first and last sections from which
%                     the problems are to be taken.  Here sec(k) = chapter.section.
%                     For example, sec = [1.1, 2.3];
%          problems = n by 5 cell array of homework problems
%          mode     = if mode <> 0, prompt for number of problems,
%                     otherwise use np
%          nums     = string array containing selections for the number of problems
% Outputs:
%          prob = array of length np the row subscripts of the generated problems.
%          np   = number of problems 

% Get number of problems                     

if mode
   [s,v] = listdlg('PromptString','Select the number of homework problems.',...
                   'ListSize',[200 300],...
                   'SelectionMode','single',...
                   'ListString',nums,...
                   'InitialValue',f_clip(np,1,length(nums)));
   np = str2double(nums{s}); 
end

% Check range of problems

cprobs = f_probrange (sec,problems);
nc = length(cprobs);

if nc < np
    s = sprintf (...
        'The number of requested problems exceeds the %d candidate problems in Sections %s to %s. ',...
        nc,sec{1},sec{2});
    warndlg (s,'','non-modal')
    prob = [];
    np =0;
    return
end

% Generate random problems

rand('state',sum(100*clock)) 
prob = zeros (1,np);
for i = 1 : np
    q = 1;
    while q
        k = 1 + round((nc-1)*rand);
        j = cprobs(k);
        q = any(ismember(j,prob(1:i-1)));
    end
    prob(i) = cprobs(k);
end
prob = sort(prob);
 