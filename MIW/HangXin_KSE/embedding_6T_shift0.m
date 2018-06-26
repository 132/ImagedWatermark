function [WI size_W KEY i S] = embedding(Denta, m, Am1, Am2, Am3, Duong1, Duong2, Duong3, OI, watermark, c, r, uh, u)
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
        if d(i) > Duong3 && Duong1 < Duong2 && Duong2 < Duong3                      % d(i) > Bin2
            if -3 <= u(i) && u(i) <= 255-3
                d(i) = d(i) + Denta + Denta + Denta;
                DungLuongShift = DungLuongShift + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) < Am3  && Am2 < Am1 && Am3 < Am2% && d(i) < 0
            if 3 <= u(i) && u(i) <= 255+3
                d(i) = d(i) - Denta - Denta - Denta;
                DungLuongShift = DungLuongShift + 1;
            else
                KEY = [KEY, i];
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif d(i) == Duong1
            if -3 <= u(i) && u(i) <= 255-3
                if watermark(w) == 0             % watermark = 0 (unchange)
                     d(i) = d(i) + Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) == Duong2
            if -3 <= u(i) && u(i) <= 255-3
                if watermark(w) == 1             % watermark = 0 (unchange)
                     d(i) = d(i) + Denta;
                elseif watermark(w) == 0
                     d(i) = d(i) + Denta + Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end
         elseif d(i) == Duong3
            if -3 <= u(i) && u(i) <= 255-3
                if watermark(w) == 1             % watermark = 0 (unchange)
                     d(i) = d(i) + Denta + Denta;
                elseif watermark(w) == 0
                     d(i) = d(i) + Denta + Denta + Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) == Am1
            if 3 <= u(i) && u(i) <= 255+3
                if watermark(w) == 0
                    d(i) = d(i) - Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) == Am2
            if 3 <= u(i) && u(i) <= 255+3
                if watermark(w) == 1
                    d(i) = d(i) - Denta;
                elseif watermark(w) == 0
                    d(i) = d(i) - Denta - Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end 
        elseif d(i) == Am3
            if 3 <= u(i) && u(i) <= 255+3
                if watermark(w) == 1
                    d(i) = d(i) - Denta - Denta;
                elseif watermark(w) == 0
                    d(i) = d(i) - Denta - Denta - Denta;
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