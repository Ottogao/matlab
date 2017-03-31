function k = f_regreader 

% F_REGREADER: Register the Adobe Acrobat Reader with FDSP
%
% Usage: k =f_regreader
%
% Description:
%              The Problems menu option of f_dsp and the 
%              Solutions menu option of g_homework allow       
%              users to access PDF files which contain 
%              solutions to end of chapter problems.  To 
%              activate this option you must have an Adobe 
%              Acrobat Reader installed, and you must 
%              register the reader file with FDSP using the
%              Problems/Register of f_dsp or the Solutions/
%              Register option of g_homework. If you do not
%              have an Adobe Acrobat Reader installed, you 
%              can download a free copy of the Acrobat Reader
%              using the Problems/Download menu option, or by
%              directly accessing the Adobe web site:
%
%              www.adobe.com/products/acrobat/readermain.html
% Outputs: 
%          k = integer that is nonzero if a reader file was 
%              found and zero if it was not.
%
% Notes:
%        The homework builder module, g_homework, is only
%        available with the Instructor's version of f_dsp.

% Initialize

adobe = 'c:\Program Files\Adobe';
reader_file = 'AcroRd32.exe';

% Change directories

work_dir = pwd;
cd (adobe)

% Get reader location

title = 'Select Adobe Acrobat Reader program and click Open...';
[reader_file,reader_path] = uigetfile (reader_file,title);
m = length(reader_file);
if m > 4
     reader_file(m-3:m) = '';          % remove .exe
     k = 1;

% Save reader location in preferences

   setpref ('FDSP_preferences','reader_path',reader_path)
   setpref ('FDSP_preferences','reader_file',reader_file)
   
else
   helpwin ('f_regreader')
   k = 0;
end
   
% Finalize

cd (work_dir)
