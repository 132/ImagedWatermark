function [Bin Histogram] = bin(c,r,uh,u, watermark)
size_W = length(watermark(:));
d = u-uh;
Nho = min(d);
Lon = max(d);
bins = Nho:1:Lon;
Histogram = hist(d,bins);
Histogram = [Histogram; bins];
viTriBin0 = find(Histogram(2,:)==0);

% Ham tao tat ca cac theshold tu -255 255 gia tri tu dong dua histogram
AB = [];
for i = 0:-1:-255
    a = zeros(1,256-abs(i));
    a(:) = i;
    b = [i:-1:-255];
    AB = [AB, [a; b]];
end
ABCD=[];
for c=1:255
    for d=c:255
        CD=zeros(2,length(AB));
        CD(1,:)=c;
        CD(2,:)=d;
        ABCD=[ABCD,[AB; CD]];
    end
end
CD = [];
for j = 1:255
    c = zeros(1,256-j);
    c(:) = j;
    d = [j:255];
    CD = [CD, [c; d]];
end



ABCD = [];
for j = 1:255
    c = zeros(1,256-j);
    c(:) = j;
    d = [j:255];
    CD = [CD, [c; d]];
end


temp = zeros(2, length(AB));
for k = 1:length(CD)
    CDK(:) =CD(:,k); 
    ABCD = [ABCD, [CDK; AB]];
end


%for a =viTriBin0:length(Histogram(1,:))
%    for b = a:length(Histogram(1,:))
%        for c = viTriBin0:-1:1
%            for d = c:-1:1
%                
%            end
%        end
%    end
%end
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
    end
end
for t=viTriDuong:1:length(Histogram)
    if Histogram(1,t)==0
        viTriGapDuong = t;
        break;
    end
end

viTriBinAm = [];
viTriBinDuong = [];
viTriBin0 = find(Histogram(2,:)==0);
for am = viTriGapAm:viTriBin0
    if Histogram(1,am) >= size_W
        viTriBinAm = [viTriBinAm, am];
    end
end
for duong = viTriBin0:viTriGapDuong
    if Histogram(1,duong) >= size_W
        viTriBinDuong = [viTriBinDuong, duong];
    end
end

BinAm = Histogram(2,viTriBinAm);
BinDuong = Histogram(2,viTriBinDuong);

GapAm = Histogram(2,viTriGapAm);
GapDuong = Histogram(2,viTriGapDuong);

BinAm(2,:) = GapAm;
BinDuong(2,:) = GapDuong;

Bin = [BinAm, BinDuong];
%%%%%%%%%%%%%%%%%%%%%%%
%{
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

BinAm(2,:) = GapAm;
BinDuong(2,:) = GapDuong;

Bin = (BinAm, BinDuong);

for a = 1:length(BinAm)
    if a > length(BinAm)
        break
    end
    if BinAm(a) == BinDuong(a)
        BinAm(a) = [];
        BinDuong(a) =[];
       
    end
end
%}
end