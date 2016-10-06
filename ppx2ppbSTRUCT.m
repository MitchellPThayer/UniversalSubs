% Converts measurements from ppmv or pptv to ppbv
% Feed in a full struct w/ units in name
% Returns struct with individual fields tweaked

% To do:
% Change evals to struct.(fieldname). No change to functionality, just cleaner

% 2016.05.17

function StructOut = ppx2ppbSTRUCT(StructIn)

StructOut = struct;

%%% This section loops over all the fields
% If the field name includes 'pp{m,t}', converts to 'ppb' and converts
% if field name not include 'pp{m,t}', copy straight over
vfields = fields(StructIn);
for vf = 1:length(vfields)
    vfield = vfields{vf};   
    ippm = strfind(vfield,'ppm');
    ippt = strfind(vfield,'ppt');
    
    if length(ippm) > 0 % if ppm       
        NewName = vfield;
        NewName(ippm:ippm+2) = 'ppb';
        s = ['StructOut.',NewName,' = StructIn.',vfield,'*1e3;'];
        eval(s);
        
    elseif length(ippt) > 0 % if ppt
        NewName = vfield;
        NewName(ippt:ippt+2) = 'ppb';
        s = ['StructOut.',NewName,' = StructIn.',vfield,'/1e3;'];
        eval(s);   
        
    else
        s = ['StructOut.',vfield,' = StructIn.',vfield,';'];
        eval(s);
    end
end

%%% Likewise, flip over the names in FillMask
% This is for a specific structure used in GoAmazon analysis
% Generally this entire chunk of code will catch and skip, no big deal.
try
    vfields = fields(StructIn.misc.FillMask);
    for vf = 1:length(vfields)
        vfield = vfields{vf};
        ippm = strfind(vfield,'ppm');
        if length(ippm) > 0
            NewName = vfield;
            NewName(ippm:ippm+2) = 'ppb';
            StructOut.misc.FillMask.(NewName) = StructIn.misc.FillMask.(vfield);
            StructOut.misc.FillMask = rmfield(StructOut.misc.FillMask, vfield);
        end
    end
catch
    % Catches here. 
end

end
