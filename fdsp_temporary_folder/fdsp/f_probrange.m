function [cprobs,clist] = f_probrange (sec,problems)

%F_PROBRANGE: Find start and stop subscripts from problems within a specified section range.
%
% Usage: [cprobs,clist] = f_probrange (sec,problems);
%
% Inputs: 
%          sec      = 1 by 2 cell array of strings containing the first and last 
%                     sections from which the homework problems are to be taken.  
%                     Here sec{k} = 'chapter.section'. For example, sec = {'1.5','2.10'}
%          problems = n by 4 cell array of homework problems
% Outputs:
%          cprobs = an array containing the row subsripts of the candidate
%                   problems from the speciified sections.  Solved problems
%                   are not included.
%          clist  = cell array of problems numbers for use with listdlg

% Initialize 

n = size(problems,1);
nc = 0;

% Compute section values 

section = f_secvalue (sec);

% Find row subscripts of problems in specified sections

for i = 1 : n
    seci = f_secvalue (problems(i,1));
    if (seci >= section(1)) & (seci <= section(2)) & ~problems{i,4}
        nc = nc + 1;
        cprobs(nc) = i;
    end
end
if nc == 0
   hw = warndlg ('There are no homework problems in the selected sections.','','modal');
   cprobs = [];
   clist = [];
   return
end

% Create cell array of problem numbers with problem type suffix

clist = cell(nc,1);
for i = 1 : nc
    j = cprobs(i);
    switch problems{j,3}
        case 1, clist(i) = {sprintf('%4s, Section %4s, Analysis',problems{j,2},problems{j,1})};
        case 2, clist(i) = {sprintf('%4s, Section %4s, GUI Simulation',problems{j,2},problems{j,1})};
        case 3, clist(i) = {sprintf('%4s, Section %4s, Computation',problems{j,2},problems{j,1})};
    end
end

