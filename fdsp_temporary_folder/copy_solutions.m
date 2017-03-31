function copy_solutions (k)

% COPY_SOLUTIONS: Copy problem solution files from chapter k to solutions directory
%
% Inputs:
%         k = chapter number

clc
source = sprintf ('c:\\book4\\chap%d\\prob',k);
CD_drive = 'c:\book4';
ps_dir  = [CD_drive filesep 'solutions' filesep 'ps'];
pdf_dir = [CD_drive filesep 'solutions' filesep 'pdf'];
fprintf ('Copy solution files for chapter %d.',k)
f_wait

% copy files

fprintf ('Copying ps solution files for chapter %d ...\n',k);
copyfile ([source filesep 'prob*.ps'],ps_dir)

fprintf ('Copying pdf solution files for chapter %d ...\n',k);
copyfile ([source filesep 'prob*.pdf'],pdf_dir)
