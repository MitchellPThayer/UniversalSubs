efunction [ strBar ] = BarMeter(FracDone,qWrite2CommandWindow)
%BARMETER: Visual representation of [model?] progress
% input:
%     FracDone: fraction of something; e.g. [.5]
%     qWrite2CommandWindow: whether to disp() bar. 1 to enable
%
% output: string with display
%   e.g. [=====-----]

if ~isnumeric(FracDone) 
    strBar = 'BarMeter requires input of # on [0, 1]...';
    if qWrite2CommandWindow == 1
        disp(strBar)
    end
    return
end

if FracDone < 0 || FracDone > 1
    strBar = 'BarMeter requires input of # on [0, 1]...';
    if qWrite2CommandWindow == 1
        disp(strBar)
    end    
    return
end

if nargin < 2
    qWrite2CommandWindow = 1;
end

i = floor(FracDone*10);
strBar = ['[', char(61*ones(1,i)),char(45*ones(1,10-i)),']'];

if qWrite2CommandWindow == 1
    disp(strBar)
end

end

