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
P = Duong2 - Duong1;
N = Am2 - Am1;
while w <= size_W && i <= size_d/m                      % d/4
    %Check underflow and overflow
        if d(i) > Duong2 && Duong1 < Duong2                      % d(i) > Bin2
            if -P <= u(i) && u(i) <= 255-P
                d(i) = d(i) + P + 1;
                DungLuongShift = DungLuongShift + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) < Am2  && Am2 < Am1% && d(i) < 0
            if abs(N) <= u(i) && u(i) <= 255+abs(N)
                d(i) = d(i) + N - 1;
                DungLuongShift = DungLuongShift + 1;
            else
                KEY = [KEY, i];
            end
        elseif Duong1 <= d(i) && d(i) <= Duong2
            if -P <= u(i) && u(i) <= 255-P
                if watermark(w) == 0             % watermark = 0 (unchange)
                     d(i) = 2*(d(i) - Duong1) + Duong1 + 0;
                else
                     d(i) = 2*(d(i) - Duong1) + Duong1 + 1;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end
        elseif Am2 <= d(i) && d(i) <= Am1
            if abs(N) <= u(i) && u(i) <= 255+abs(N)
                if watermark(w) == 0             % watermark = 0 (unchange)
                     d(i) = 2*(d(i) - Am1) + Am1 -1 + 0;
                elseif watermark(w) == 1
                     d(i) = 2*(d(i) - Am1) + Am1 -1 + 1;
                end
                w = w + 1;
            else
                KEY = [KEY, i];
            end
        end
        i = i+1;
end


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