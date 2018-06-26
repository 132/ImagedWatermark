function [OI, watermark] = extracting(Denta, m, Check, BinAm, BinDuong, GapAm, GapDuong, WI,size_W,KEY,c,r,uh,u)
%[c,r,uh,u] = crossset(WI);
d = u - uh;          size_d = length(d);
DentaAm = 0-Denta;
i = 1;
W = [];
%start = clock;
%e = clock;
while length(W) <= size_W && d(i) <= size_d/m
   % Rut watermark ra truoc
   Xoa = ismember(i,KEY); 
   if Xoa==0
       if d(i) == BinDuong + Denta %BinDuong < d(i) && 
           W = [W, 1];
           d(i) = d(i) - Denta;
       elseif BinAm + DentaAm == d(i)% && d(i) < BinAm
           W = [W, 1];
           d(i) = d(i) - DentaAm;
       elseif BinAm == d(i) || d(i) == BinDuong
           W = [W, 0];
       elseif (BinDuong + Denta < d(i) && d(i) <= GapDuong) || (GapAm <= d(i) && d(i)< BinAm - Denta)
            if d(i) > 0
                d(i) = d(i) - Denta;
            elseif d(i) < 0
                d(i) = d(i) - DentaAm;
            end
       end
       if length(W) == size_W || i > Check 
           break;
       end
   else
       KEY(Xoa)=[];
   end
   i = i+1;
 %   e = clock;
end
%{
j = 1;
%starts = clock;
%endt = clock;

while j <= size_d/m     % && etime(endt,starts)<20
    Xoa2 = ismember(j,KEY);

    if Xoa2==0
        if (BinDuong + Denta < d(j) && d(j) <= GapDuong) || (GapAm <= d(j) && d(j)< BinAm - Denta)
            if d(j) > 0
                d(j) = d(j) - Denta;
            elseif d(j) < 0
                d(j) = d(j) - DentaAm;
            end
         end
        j = j+1;
    else
        KEY(Xoa2)=[];
        j = j+1;
    end
    %endt = clock;
end
%}
while length(W) < size_W
    W = [W, 0];
end

x = W;
%W = vec2mat(W,sqrt(size_W))';
watermark = W(:);
%watermark = decode_qr(watermark);
U = d + uh;
OI = WI;
OI((c-1)*size(OI,1)+r)=U;
end