function r = f_cleanstring (s)

%F_CLEANSTRING: Replace _ in string s with \_ for tex processor
%
% Usage: s = f_cleanstring (r)
%
% Inputs: 
%         r = string containing a file name
% Outputs: 
%          s = processed string with _ replaced by \_.

 n = length(s);
 k = find (s == '_');
 if ~isempty(k)
    r = [s(1:k-1) '\_' s(k+1:n)]; 
 else
    r = s;
end
