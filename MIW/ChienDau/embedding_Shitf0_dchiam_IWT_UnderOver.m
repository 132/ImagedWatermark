function [WI size_W KEY j] = embedding(Denta, m, OI, watermark, c, r, uh, u)
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
while i <= size_d/m                       % d/4
    %Check underflow and overflow
        if d(i) >= Denta % && d(i) > 0
            if -382-Denta <= u(i) && u(i) <= 510-Denta
                d(i) = d(i) + Denta;
                DungLuongShift = DungLuongShift + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) <= DentaAm % && d(i) < 0
            if -382+Denta <= u(i) && u(i) <= 510+Denta
                d(i) = d(i) - Denta;
                DungLuongShift = DungLuongShift + 1;
            else
                KEY = [KEY, i];
            end
        end
        i = i+1;
end

j = 1;
while w <= size_W && j <= size_d/m
        % EMBEDDING WATERMARK
        
        if 0 <= d(j) && d(j) < Denta
            if -382-Denta <= u(j) && u(j) <= 510-Denta
                if watermark(w) == 0             % watermark = 0 (unchange)
                     d(j) = d(j) + Denta;
                end
                w = w + 1;
            else
                KEY = [KEY, j];
            end
        elseif DentaAm < d(j) && d(j) <= 0  
            if -382+Denta <= u(j) && u(j) <= 510+Denta
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
if w <= size_W
    check = 'chua nhung het'
end
%WI = OI;
U = d + uh;
%WI((c-1)*size(OI,1)+r)=U;
WI = OI;
WI((c-1)*size(WI,1)+r)=U;
KEY = sort(KEY);
end