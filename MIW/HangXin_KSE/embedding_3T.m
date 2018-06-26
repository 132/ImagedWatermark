function [WI size_W KEY i S] = embedding(Denta, m, Am, Am_Duong, Duong, OI, watermark, c, r, uh, u)
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
if Am_Duong > 0
    while w <= size_W && i <= size_d/m                      % d/4
           if d(i) > Am_Duong && Am_Duong > Duong                     % d(i) > D2
                if -2 <= u(i) && u(i) <= 255-2
                    d(i) = d(i) + Denta + Denta;
                    DungLuongShift = DungLuongShift + 1;
                else
                    KEY = [KEY, i];
                end
            elseif d(i) < Am                 % && d(i) < 0
                if Denta <= u(i) && u(i) <= 255+Denta
                    d(i) = d(i) - Denta;
                    DungLuongShift = DungLuongShift + 1;
                else
                    KEY = [KEY, i];
                end
            elseif d(i) == Duong
                if -2 <= u(i) && u(i) <= 255-2
                    if watermark(w) == 1             % watermark = 0 (unchange)
                         d(i) = d(i) + Denta;
                    end
                    w = w + 1;
                else
                    KEY = [KEY, i];
                end
            elseif d(i) == Am_Duong
                if -2 <= u(i) && u(i) <= 255-2
                    if watermark(w) == 1             % watermark = 0 (unchange)
                         d(i) = d(i) + Denta + Denta;
                    elseif watermark(w) == 0
                        d(i) = d(i) + Denta;
                    end
                    w = w + 1;
                else
                    KEY = [KEY, i];
                end    
            elseif d(i) == Am
                if Denta <= u(i) && u(i) <= 255+Denta
                    if watermark(w) == 1
                        d(i) = d(i) - Denta;
                    end
                    w = w + 1;
                else
                    KEY = [KEY, i];
                end 
            end        
            i = i+1;
    end
end

if Am_Duong < 0
     while w <= size_W && i <= size_d/m                      % d/4
        %Check underflow and overflow
            if d(i) > Duong                      % d(i) > D1
                if DentaAm <= u(i) && u(i) <= 255-Denta
                    d(i) = d(i) + Denta;
                    DungLuongShift = DungLuongShift + 1;
                else
                    KEY = [KEY, i];
                end
            elseif d(i) < Am_Duong && Am_Duong < Am             % && d(i) < A2
                if 2 <= u(i) && u(i) <= 255+2
                    d(i) = d(i) - Denta - Denta;
                    DungLuongShift = DungLuongShift + 1;
                else
                    KEY = [KEY, i];
                end
            elseif d(i) == Duong
                if DentaAm <= u(i) && u(i) <= 255-Denta
                    if watermark(w) == 1             % watermark = 0 (unchange)
                         d(i) = d(i) + Denta;
                    end
                    w = w + 1;
                else
                    KEY = [KEY, i];
                end
            elseif d(i) == Am
                if 2 <= u(i) && u(i) <= 255+2
                    if watermark(w) == 1
                        d(i) = d(i) - Denta;
                    end
                    w = w + 1;
                else
                    KEY = [KEY, i];
                end 
            elseif d(i) == Am_Duong
                if 2 <= u(i) && u(i) <= 255+2
                    if watermark(w) == 0
                        d(i) = d(i) - Denta;
                    elseif watermark(w) == 1
                        d(i) = d(i) - Denta - Denta;
                    end
                    w = w + 1;
                else
                    KEY = [KEY, i];
                end 
            end        
            i = i+1;
    end
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