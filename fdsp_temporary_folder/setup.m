function setup

%SETUP: This is the MATLAB installation file for the FDSP toolbox.  
%       It requires MATLAB Version 6.1 or later.
%
% Usage: 
%
%    cd E:\           % if CD is in drive E
%    setup

% Programming notes:

% Initialize

clear
clc
fdsp_file = 'one.exe';
toolbox = [matlabroot filesep 'toolbox'];
fdspdir = [toolbox filesep 'fdsp'];
fdsp    = [fdspdir filesep 'fdsp'];
exam    = [fdspdir filesep 'examples'];
fig     = [fdspdir filesep 'figures'];
prob    = [fdspdir filesep 'problems'];
work    = [matlabroot filesep 'work'];
local   = [matlabroot filesep 'toolbox' filesep 'local'];
temp_fdspdir = 'c:\fdsp_temporary_folder';
temp_fdsp    = [temp_fdspdir filesep 'fdsp'];
temp_exam    = [temp_fdspdir filesep 'examples'];
temp_fig     = [temp_fdspdir filesep 'figures'];
temp_prob    = [temp_fdspdir filesep 'problems'];
   
% Check MATLAB version

matlab_ver = 6.1;
ver = version;
ver_num = str2num(ver(1:3));
if ver_num < matlab_ver
   fprintf ('The FDSP Toolbox installation file requires MATLAB Version %.1f or later.\n\n',matlab_ver);
   return;
end

% Display menu

choice = menu ('Please select one:','Install FDSP toolbox','Uninstall FDSP toolbox','Exit');

switch (choice)
    
    case 1,            % Install FDSP    

% Remove old FDSP toolbox and all references to FDSP from path

    if exist(fdsp_file)
     
        fprintf ('\nPreparing to install FDSP toolbox ...\n')  
        found = delete_fdsp;
        cleanpath
    
% Save backup copy of startup.m (once)

        if exist('startup') & ~exist('startup_save')
            copyfile ([local filesep 'startup.m'],[local filesep 'startup_save.m'])
            fprintf ('Saving original startup.m in startup_save.m\n')
        end

% Run self-extracting zip file

        fprintf (['Installing FDSP toolbox ...\n'])  
        source = which(fdsp_file);
        CD_drive = source(1:2);
        clear functions 
        if ver_num >= 7.0
            warning off MATLAB:mir_warning_unrecognized_pragma
        end
        system (fdsp_file);
        if ver_num >= 7.0
            warning on MATLAB:mir_warning_unrecognized_pragma
        end
    
    else
        
        msg{1} = 'To install the FDSP toolbox, you must first change the current';
        msg{2} = 'directory to the directory containing the FDSP installation files.';
        msg{3} = 'For example, if the distribution CD is in drive E, enter the';
        msg{4} = 'following in the MATLAB command window:';
        msg{5} = '';
        msg{6} = ['  cd E:' filesep];
        msg{7} = '  setup';
        msg{8} = '';
        warndlg (msg,'FDSP Toolbox Installation');
        return
        
    end

% Create FDSP directories in MATLAB toolbox directory

   if ver_num <= 6.1
       warning off
   end
   fprintf ('Creating directories in MATLAB toolbox folder ...\n')
   mkdir (toolbox,'fdsp')
   mkdir (toolbox,['fdsp' filesep 'fdsp'])
   mkdir (toolbox,['fdsp' filesep 'examples'])
   mkdir (toolbox,['fdsp' filesep 'figures'])
   mkdir (toolbox,['fdsp' filesep 'problems'])
   if ver_num <= 6.1
       warning on
   end
   
% Copy toolbox files   
   
   if ver_num > 6.1
       fprintf ('Copying FDSP files. Please wait ...\n')
       h_wait = waitbar (0,'Copying FDSP: utilities');
       copyfile (temp_fdspdir,fdspdir)
       waitbar (0.2,h_wait,'Copying FDSP: functions')
       copyfile (temp_fdsp,fdsp)
       waitbar (0.4,h_wait,'Copying FDSP: examples')
       copyfile (temp_exam,exam)
       waitbar (0.6,h_wait,'Copying FDSP: figures')
       copyfile (temp_fig,fig)
       waitbar (0.8,h_wait,'Copying FDSP: problems')
       copyfile (temp_prob,prob)
       waitbar (1,h_wait,'FDSP files copied')
       delete(h_wait)
   else
       system (['copy ' temp_fdspdir filesep '*.* ' fdspdir]);
       system (['copy ' temp_fdsp filesep '*.* ' fdsp]);
       system (['copy ' temp_exam filesep '*.* ' exam]);
       system (['copy ' temp_fig filesep '*.* ' fig]);
       system (['copy ' temp_prob filesep '*.* ' prob]);
   end   
   
   rehash toolbox
   rehash toolboxcache
   
% Save backup copy of startup.m (once)

    fprintf ('Updating startup.m ...\n')
    local = [matlabroot filesep 'toolbox' filesep 'local'];
    if exist('startup') & ~exist('startup_save')
        copyfile ([local filesep 'startup.m'],[local filesep 'startup_save.m'])
    end

% Update startup.m

    comment = '% Inserted by FDSP';
    startup = [local filesep 'startup.m'];
    temp    = [local filesep 'temp.m'];
    f_temp  = fopen (temp,'w');
    if exist(startup) 
         f_start = fopen (startup,'r');
         while (~feof(f_start))
             clear s q
             s = fgetl (f_start);
             n = length(s);
             if isempty(strfind(s,comment)) & (n > 0) & (s ~= -1)
                 j = 1;
                 for i = 1 : n
                     if (s(i) == '\')                 % Convert \ to \\       
                         q(j:j+1) = '\\';
                         j = j+2;
                     elseif (s(i) == '%')             % Convert % to %%
                         q(j:j+1) = '%%';
                         j = j+ 2;
                     else
                         q(j) = s(i);
                         j = j+1;
                     end
                 end
                 fprintf (f_temp,q);
                 fprintf (f_temp,'\n');
             end
         end
         fclose (f_start);
    end
    fprintf (f_temp,'\nformat short  %s',comment);
    fprintf (f_temp,'\nformat compact %s',comment);
    fprintf (f_temp,'\npath(path,''%s'')  %s',fdspdir,comment);
    fprintf (f_temp,'\npath(path,''%s'')  %s',fdsp,comment);
    fprintf (f_temp,'\npath(path,''%s'')  %s',exam,comment);
    fprintf (f_temp,'\npath(path,''%s'')  %s',fig,comment);
    fprintf (f_temp,'\npath(path,''%s'')  %s',prob,comment);
    fclose (f_temp);
    copyfile (temp,startup);
    delete (temp);
   
% Copy user M-files to work

    fprintf ('Copying data files ... \n');
    copyfile ([fdsp filesep 'u_sample1.m'],work);
    copyfile ([fdsp filesep 'u_reconstruct1.m'],work);
    copyfile ([fdsp filesep 'u_fir1.m'],work);

% Copy user MAT-files to work

    copyfile ([fdsp filesep 'u_system1.mat'],work);
    copyfile ([fdsp filesep 'u_spectra1.mat'],work);
    copyfile ([fdsp filesep 'u_correlate1.mat'],work);
    copyfile ([fdsp filesep 'u_filters1.mat'],work);
    copyfile ([fdsp filesep 'u_fir1.mat'],work);
    copyfile ([fdsp filesep 'u_multirate1.mat'],work);
    copyfile ([fdsp filesep 'u_iir1.mat'],work);
    copyfile ([fdsp filesep 'u_adapt1.mat'],work);

% Configure this session of MATLAB

    fprintf ('Configuring this MATLAB session to use FDSP...\n')
    format short;
    format compact;
    path(path,fdspdir);
    path(path,fdsp);
    path(path,exam);
    path(path,fig);
    path(path,prob);
   
% Make contents files

    if ver_num >= 7.0
        warning off MATLAB:dispatcher:InexactMatch
    end
    cd(fdsp),    makecontents ('FDSP toolbox functions','f')
    cd(exam),    makecontents ('FDSP toolbox examples','f')
    cd(fig),     makecontents ('FDSP toolbox figures','f')
    cd(prob),    makecontents ('FDSP toolbox problems (PDF files)')
    cd(fdspdir), makecontents ('FDSP toolbox')
    cd (work);
    if ver_num >= 7.0
        warning on MATLAB:dispatcher:InexactMatch
    end

% Update FDSP preferences

    if ~isempty(getpref('FDSP_preferences'))
        rmpref ('FDSP_preferences')
    end
    setpref ('FDSP_preferences','CD_drive',CD_drive)
    setpref ('FDSP_preferences','screen_warning',1)

% Delete temporary files

   fprintf ('Cleaning up ...\n')
   
   if ver_num >= 7.0
       warning off
   end
   delete ([temp_fdsp filesep '*.*'])
   delete ([temp_exam filesep '*.*'])
   delete ([temp_fig filesep '*.*'])
   delete ([temp_prob filesep '*.*'])
   delete ([temp_fdspdir filesep '*.*'])
   if ver_num >= 7.0
       warning on
   end
   
   if ver_num > 6.1
       rmdir (temp_fdsp)
       rmdir (temp_exam)
       rmdir (temp_fig)
       rmdir (temp_prob)
       rmdir (temp_fdspdir)
   else
       system (['rmdir ' temp_fdsp]);
       system (['rmdir ' temp_exam]);
       system (['rmdir ' temp_fig]);
       system (['rmdir ' temp_prob]);
       system (['rmdir ' temp_fdspdir]);
   end
   
% Finalize

    rehash toolbox
    rehash toolboxcache   
    clc
    fprintf ('\n\nThe installation of the FDSP toolbox is complete.\n')
    fprintf ('To run GUI modules, or browse examples, figures, and \n')
    fprintf ('problems, issue the FDSP driver module command:\n\n')
    fprintf ('f_dsp\n\n')
 
case 2,          % Uninstall FDSP

    fprintf ('\nUninstalling FDSP toolbox ...\n')
    found = delete_fdsp;
    if ~found
        
        fprintf ('The FDSP toolbox was not found.\n')
        return
    
    else
       
% Clean startup.m of FDSP lines

      comment = '% Inserted by FDSP';
      startup = [local filesep 'startup.m'];
      temp    = [local filesep 'temp.m'];
      f_temp  = fopen (temp,'w');
      if exist(startup) 
           f_start = fopen (startup,'r');
           while (~feof(f_start))
               clear s q;
               s = fgetl (f_start);
               n = length(s);
               if isempty(strfind(s,comment)) & (n > 0) & (s ~= -1)
                   j = 1;
                   for i = 1 : length(s)
                       if (s(i) == '\')                 % Convert \ to \\       
                           q(j:j+1) = '\\';
                           j = j+2;
                       elseif (s(i) == '%')             % Convert % to %%
                           q(j:j+1) = '%%';
                           j = j+ 2;
                       else
                           q(j) = s(i);
                           j = j+1;
                       end
                   end
                   if exist('q')
                       fprintf (f_temp,q);
                   end
                   fprintf (f_temp,'\n');
               end
           end
           fclose (f_start);
      end
      fclose (f_temp);
      copyfile (temp,startup);
      delete (temp);
      fprintf ('The FDSP toolbox has been removed.\n') 
   end
   
end

% Display completion window

if choice == 1

% Display menu

   msg = {'The FDSP toolbox has been installed in',...
           fdspdir,...
          'Please select one:'};
 
   nchoice = menu (msg,'Run driver module: f_dsp','Exit');

   if nchoice == 1
      f_dsp
   end
   
end


function found = delete_fdsp

% DELETE_FDSP: Delete the FDSP files and remove FDSP directories  
%
% Usage: found = delete_fdsp
%
% Outputs:
%          found = true if FDSP file f_dsp was found 

% Initialize

fdspdir = [matlabroot filesep 'toolbox' filesep 'fdsp'];
fdsp    = [fdspdir filesep 'fdsp'];
exam    = [fdspdir filesep 'examples'];
fig     = [fdspdir filesep 'figures'];
prob    = [fdspdir filesep 'problems'];
ver = version;
ver_num = str2num(ver(1:3));

% Determine if FDSP toolbox exists

if exist(fdspdir,'dir')
    found = 1;
else
    found = 0;
end
    
if found
    
   warning off 
    
% Remove FDSP from MATLAB path
    
   rmpath (fdsp)
   rmpath (exam)
   rmpath (fig)
   rmpath (prob)
   rmpath (fdspdir)
   rehash toolbox
   rehash toolboxcache

% Delete the files and directories

   delete ([fdsp filesep '*.*'])
   delete ([exam filesep '*.*'])
   delete ([fig filesep '*.*'])
   delete ([prob filesep '*.*'])
   delete ([fdspdir filesep '*.*'])
   
   system (['rmdir ' fdsp]);
   system (['rmdir ' exam]);
   system (['rmdir ' fig]);
   system (['rmdir ' prob]);
   system (['rmdir ' fdspdir]);

   warning on
  
end

function cleanpath
% CLEANPATH: Remove all references to FDSP from the current MATLAB path

matpath = [matlabroot filesep 'toolbox' filesep 'fdsp'];
local = 'c:\fdsp';
ver = version;
ver_num = str2num(ver(1:3));
warning off

% Remove MATLAB version fdsp from MATLAB path

rmpath (matpath)
rmpath ([matpath filesep 'fdsp'])
rmpath ([matpath filesep 'examples'])
rmpath ([matpath filesep 'figures'])
rmpath ([matpath filesep 'problems'])

% Remove local version of fdsp from MATLAB path

rmpath (local)
rmpath ([local filesep 'fdsp'])
rmpath ([local filesep 'examples'])
rmpath ([local filesep 'figures'])
rmpath ([local filesep 'problems'])

% Finalize

warning on
