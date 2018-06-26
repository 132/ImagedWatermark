function [WI size_W KEY i S] = embedding(Denta, m, Am1, Am2, Duong1, Duong2, OI, watermark, c, r, uh, u)
watermark = watermark(:);   size_W = length(watermark);
% u pixel || uh predicted error
d = u - uh;     size_d = length(d); % eij  prediction error
DentaAm = 0-Denta;
w = 1;
i = 1;
%size_d = 10;
KEY = [];
DungLuongShift= 0;
% Shift prediciton error
%if length(BinAm) ==1
while w <= size_W && i <= size_d/m                      % d/4
    %Check underflow and overflow
        if d(i) > Duong2 && Duong1 < Duong2                      % d(i) > Bin2
            if -2 <= u(i) && u(i) <= 255-2
                d(i) = d(i) + Denta + Denta;
                DungLuongShift = DungLuongShift + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) < Am2  && Am2 < Am1% && d(i) < 0
            if 2 <= u(i) && u(i) <= 255+2
                d(i) = d(i) - Denta - Denta;
                DungLuongShift = DungLuongShift + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) == Duong1
            if -2 <= u(i) && u(i) <= 255-2
                if watermark(w) == 0             % watermark = 0 (unchange)
                     d(i) = d(i) + Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) == Duong2
            if -2 <= u(i) && u(i) <= 255-2
                if watermark(w) == 1             % watermark = 0 (unchange)
                     d(i) = d(i) + Denta;
                elseif watermark(w) == 0
                     d(i) = d(i) + Denta + Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) == Am1
            if 2 <= u(i) && u(i) <= 255+2
                if watermark(w) == 0
                    d(i) = d(i) - Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) == Am2
            if 2 <= u(i) && u(i) <= 255+2
                if watermark(w) == 1
                    d(i) = d(i) - Denta;
                elseif watermark(w) == 0
                    d(i) = d(i) - Denta - Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end 
        end        
        i = i+1;
end

%{
j = 1;
while w <= size_W && j <= size_d/m
        % EMBEDDING WATERMARK
    %    if  BinDuong < d(j) && d(j) <= BinDuong + Denta
       if d(j) == BinDuong
            if DentaAm <= u(j) && u(j) <= 255-Denta
                if watermark(w) == 0             % watermark = 0 (unchange)
                     d(j) = d(j) + Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, j];
            end
        %elseif BinAm - Denta <= d(j) && d(j) < BinAm
        elseif d(j) == BinAm
            if Denta <= u(j) && u(j) <= 255+Denta
                if watermark(w) == 0
                    d(j) = d(j) - Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, j];
            end
        end        
    j = j+1;
end
%}
if w <= size_W
    check = 'chua nhung het'
    S =0;
else
    S = 1;
end
%WI = OI;
U = d + uh;
%WI((c-1)*size(OI,1)+r)=U;
WI = OI;
WI((c-1)*size(WI,1)+r)=U;
KEY = sort(KEY);
end