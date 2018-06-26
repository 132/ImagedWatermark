function [BinAm BinDuong GapAm GapDuong Histogram] = bin(c,r,uh,u, watermark)
size_W = length(watermark(:));
d = u-uh;
Nho = min(d);
Lon = max(d);
bins = Nho:1:Lon;
Histogram = hist(d,bins);
Histogram = [Histogram; bins];
% shift 1 cai thoi
Vua = [];
for i=1:length(Histogram)
    if Histogram(1,i) >= size_W/2
        Vua = [Vua, Histogram(2,i)];
    end
end

BinAm = Vua(1);
BinDuong = Vua(length(Vua));

viTriAm = find(Histogram(2,:)==BinAm);
viTriDuong = find(Histogram(2,:)==BinDuong);
% tim gap khoang trong de shift vao
for j=viTriAm:-1:1
    if Histogram(1,j)==0
        viTriGapAm = j;
        break;
    else
        viTriGapAm = 1;
    end
end
for t=viTriDuong:1:length(Histogram)
    if Histogram(1,t)==0
        viTriGapDuong = t;
        break;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%
TapDuong = [];
TapAm = [];
Bin0 = find(Histogram(2,:)==0);

for duong = Bin0:1:viTriGapDuong
    if Histogram(1,viTriAm) + Histogram(1,duong) >= size_W
        TapDuong = [TapDuong, duong];
    else
        break
    end
end

for am = Bin0:-1:viTriGapAm
    if Histogram(1,viTriDuong) + Histogram(1,am) >= size_W
        TapAm = [TapAm, am];
    else
        break
    end
end

Tong = [];
for index = 1:length(TapAm)
    Tong = [Tong; Histogram(1,TapAm(index)) + Histogram(1,TapDuong)];
end

Total = Tong(:);
TapViTrix =[];
TapViTriy =[];
%Minimum = Total(1);
for GiaTri = 1:length(Total)
    if Total(GiaTri) >= size_W %&& Total(GiaTri) < Minimum
      %  Minimum = Total(GiaTri);
        [x y] = find(Tong==Total(GiaTri));
        TapViTrix = [TapViTrix x(1)];
        TapViTriy = [TapViTriy y(1)];
        Tong(x(1),y(1)) = 0;
    end
end

%viTriBinAm = TapAm(x);
%viTriBinDuong = TapDuong(y);

viTriBinAm = TapAm(TapViTrix);
viTriBinDuong = TapDuong(TapViTriy);

BinAm = Histogram(2,viTriBinAm);
BinDuong = Histogram(2,viTriBinDuong);

GapAm = Histogram(2,viTriGapAm);
GapDuong = Histogram(2,viTriGapDuong);

for a = 1:length(BinAm)
    if a > length(BinAm)
        break
    end
    if BinAm(a) == BinDuong(a)
        BinAm(a) = [];
        BinDuong(a) =[];
       
    end
end
end