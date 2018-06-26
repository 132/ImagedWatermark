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
for j=viTriAm:-1:1
    if Histogram(1,j)==0
        viTriGapAm = j;
        break;
    end
end
for t=viTriDuong:1:length(Histogram)
    if Histogram(1,t)==0
        viTriGapDuong = t;
        break;
    end
end
GapAm = Histogram(2,viTriGapAm);
GapDuong = Histogram(2,viTriGapDuong);
end