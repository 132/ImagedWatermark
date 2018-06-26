function [OI,imin,imax,size_w] = embeddingS(OI,w)
%OI = imread('boat.tiff');
%OI = imread('elaine.512.tiff');

%w = 'tridpetraivoidoi';
try     % co loi trong try thi lam` catch neu ko loi thi ra ngoai
    getQR();
catch 
    w = encode_qr(w, 'Character_set', 'ISO-8859-1');
end
a = w;
w = w(:);
b = w;
size_w = length(w);
Hist = imhist(OI);
[Max,imax] = max(Hist);
[Min,imin] = min(Hist);
[hang cot] = size(OI);
if imax > imin
    for i=1:hang
        for j=1:cot
            if imin<OI(i,j) && OI(i,j)<imax
                OI(i,j)= OI(i,j)-1;
            end
        end
    end
    t=1;
    for i=1:hang
        for j=1:cot
            if OI(i,j)==imax && w(t)==1
                OI(i,j) = OI(i,j) - 1;
                if t >= length(w)
                    break
                else
                    t=t+1;
                end
            elseif OI(i,j)==imax && w(t)==0
                OI(i,j) = OI(i,j);
                if t >= length(w)
                    break
                else
                    t=t+1;
                end
            end
        end
    end
else
    for i=1:hang
        for j=1:cot
            if imin>OI(i,j) && OI(i,j)>imax
                OI(i,j)= OI(i,j)+1;
            end
        end
    end
    t=1;
    for i=1:hang
        for j=1:cot
            if OI(i,j)==imax && w(t)==1
                OI(i,j) = OI(i,j) + 1;
                if t >= length(w)
                    break
                else
                    t=t+1;
                end
            elseif OI(i,j)==imax && w(t)==0
                OI(i,j) = OI(i,j);
                if t >= length(w)
                    break
                else
                    t=t+1;
                end
            end
        end
    end
end
WI = OI;
clear Hist;
end