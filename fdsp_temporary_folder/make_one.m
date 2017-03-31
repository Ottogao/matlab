% Make the self-extracting FDSP executable file one.exe for CD

% Initialize

clear
clc
fdsp_file   = 'one'; 
temp_folder = 'c:\fdsp_temporary_folder';
winzipdir   = 'c:\Program Files\WinZip';
wzipsedir   = 'c:\Program Files\WinZip Self-Extractor';
fdspdir     = 'c:\fdsp';
zipdir      = 'c:\zipped';
cmd1        = ['wzzip -p -r ' zipdir '\' fdsp_file '.zip ' fdspdir];
cmd2        = ['wzipse32 ' zipdir '\' fdsp_file ' -d ' temp_folder ' -auto'];  

% Create zip file

cd (zipdir)
delete ([fdsp_file '.zip'])
delete ([fdsp_file '.exe'])
cd (fdspdir)
delete ([fdsp_file '.exe'])
cd (winzipdir)
system (cmd1);

% Create executable

cd (wzipsedir)
system (cmd2);
copyfile ([zipdir '\' fdsp_file '.exe'],fdspdir);
cd (fdspdir)
d = dir([fdsp_file '.exe'])
what
 