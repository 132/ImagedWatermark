function [W,OI] = extracted(WI,last_bit,LC,c,r,uh,uhdd)
% c (col)
% r (row)
% uh (predicted value)
% u (gia tri pixel cua anh goc)
% Pload (watermark)
% T (Tn va Tp)
% image_out (anh goc
% LC (location map)
% EC (so bit encode)
%dd = uhdd - uh;
%b = mod(dd,2);
%d = floor(dd/2);
%u = uh+d;
%if histogram
%    if U == uh;
%    end
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Rut 34LSB dau tien
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LSB = mod(u(1:34),2)';
Tp = LSB(1:7);        Tp = num2str(Tp);       Tp = bin2dec(Tp);
Tn = LSB(8:14);       Tn = num2str(Tn);       Tn = bin2dec(Tn);
p_m = LSB(15:34);     p_m = num2str(p_m);     p_m = bin2dec(p_m);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u =zero(uh);
dd= uhdd - uh;
i = 34; % vi tri 34 cua U
LC= 0;
%Pload;
while i<last_bit
    i = i+1;
    if dd(i) > 2*Tp + 1
        d(i) = dd(i) - Tp - 1;
       % u(i) = d(i) + uh(i);
    else if dd(i) >= 0
            d(i) = mod(dd(i)/2);
            
        end
    else if dd(i) >= 2*Tn
            d(i) = mod(dd(i)/2);
            if uhdd(i)==uh(i)
            else
                
                
            end
        end
    else if dd(i) < 2*Tn
            d(i) = dd(i) - Tn;
    end
end


end