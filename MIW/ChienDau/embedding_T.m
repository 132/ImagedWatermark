function [WI Mang size_W KEY] = embedding(OI,watermark)
watermark = watermark(:);   size_W = length(watermark);
[c,r,uh,u] = crossset(OI);
% u pixel || uh predicted error
d = u - uh;     size_d = length(d); % eij  prediction error
Denta = 1;
DentaAm = 0-Denta;
w = 1;
i = 1;
%size_d = 10;
KEY = [];
% Shift prediciton error
while i <= size_d
    if i == 9982
        a='trideptrai';
    end
    %Check underflow and overflow
    if 255 - Denta > u(i) && u(i) > Denta
        if d(i) >= Denta || d(i) <= DentaAm
            if d(i) > 0
                d(i) = d(i) + Denta;
            elseif d(i) < 0
                d(i) = d(i) - Denta;
            end
        end
        i = i+1;
    else
        KEY = [KEY, i];
        i = i + 1;
    end
end

j = 1;
while w <= size_W && j <= size_d 
        % EMBEDDING WATERMARK
        if DentaAm < d(j) && d(j) < Denta && ismember(j,KEY)==0
            if watermark(w) == 1             % watermark = 0 (unchange)
                if d(j) >= 0
                    d(j) = d(j) + Denta;
                elseif d(j) < 0
                    d(j) = d(j) - Denta;
                end
            end
            w = w + 1;
            
        end
        j = j+1;
end
U = d + uh;
WI((c-1)*size(OI,1)+r)=U;
Mang = WI;
WI = OI;
WI((c-1)*size(WI,1)+r)=U;
end