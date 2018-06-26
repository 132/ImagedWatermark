function [WI size_W KEY i S] = embedding(Denta, m, Am1, Am2, Duong1, Duong2, OI, watermark, c, r, uh, u, watermark_LSB)
watermark = watermark(:);   size_W = length(watermark);
% u pixel || uh predicted error
d = u - uh;     size_d = length(d); % eij  prediction error
DentaAm = 0-Denta;
w = 1;
i = 52;
%size_d = 10;
KEY = [];
DungLuongShift= 0;
% Shift prediciton error
for lsb = 1:51
    if d(lsb) < 0
        PixelBw = dec2bin(typecast(int8(d(lsb)),'uint8'));
    else
        PixelBw= dec2bin(d(lsb),7);
    end
    tem = num2str(watermark_LSB(lsb));
    PixelBw(length(PixelBw))=tem;
    d(lsb) = typecast(uint8(bin2dec(PixelBw)), 'int8');
end
P = Duong2 - Duong1 +1;
N = Am2 - Am1 -1;
while w <= size_W && i <= size_d/m                      % d/4
    %Check underflow and overflow
        if d(i) > Duong2 && Duong1 < Duong2                      % d(i) > Bin2
            if -P <= u(i) && u(i) <= 255-P
                d(i) = d(i) + P;
                DungLuongShift = DungLuongShift + 1;
            else
                KEY = [KEY, i];
            end
        elseif d(i) < Am2  && Am2 < Am1% && d(i) < 0
            if abs(N) <= u(i) && u(i) <= 255+abs(N)
                d(i) = d(i) + N;
                DungLuongShift = DungLuongShift + 1;
            else
                KEY = [KEY, i];
            end
        elseif Duong1 <= d(i) && d(i) <= Duong2
            
            if watermark(w) == 0             % watermark = 0 (unchange)
                 temp = 2*(d(i) - Duong1) + Duong1 + 0;
            else
                 temp = 2*(d(i) - Duong1) + Duong1 + 1;
            end
            Shift_D = temp - d(i);
            if -Shift_D <= u(i) && u(i) <= 255-Shift_D
                d(i) = temp;
                w = w + 1;
            else
                KEY = [KEY, i];
            end
        elseif Am2 <= d(i) && d(i) <= Am1
            
            if watermark(w) == 0             % watermark = 0 (unchange)
                 temp = 2*(d(i) - Am1) + Am1 -1 + 0;
            elseif watermark(w) == 1
                 temp = 2*(d(i) - Am1) + Am1 -1 + 1;
            end
            Shift_A = temp - d(i);
            if abs(Shift_A) <= u(i) && u(i) <= 255+abs(Shift_A)
                d(i) = temp;
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