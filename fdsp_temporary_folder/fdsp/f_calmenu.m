function f_calmenu (plotstr)

%F_CALMENU: Set up caliper menu item
%
% Usage: f_calmenu (plotstr)
%
% Inputs: 
%         plotstr = callback string to regenerate plot 
         
hm_2 = uimenu (gcf,'Label','Caliper');
cback1 = ['try, '...
          '[x0,y0] = ginput(1); hold on; plot(x0,y0,''k+''); hold off;'...
          's = sprintf(''  (x,y) = (%.2f,%.2f)'',x0,y0);'...
          'text(x0,y0,s); '...
          'catch, end;'];
hm21 = uimenu (hm_2,'Label','Use the mouse to select a measurement point on the plot.',...
               'Callback',cback1);
hm22 = uimenu (hm_2,'Label','Erase measured points from the plot area','Callback',plotstr);


 