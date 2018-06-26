function [Am2_Duong2 Histogram] = bin(c,r,uh,u, watermark)
size_W = length(watermark(:));
d = u-uh;
Nho = min(d);
Lon = max(d);
bins = Nho:1:Lon;
Histogram = hist(d,bins);
Histogram = [Histogram; bins];
viTriBin0 = find(Histogram(2,:)==0);
% 2 threshold
T1_Am = [];
T2_Am = [];
Tong_Am = [];
for tam = viTriBin0:-1:1
    for tam2 = tam:-1:1
        if Histogram(1,tam) ~= 0 && Histogram(1,tam2) ~= 0 && Histogram(2,tam) - Histogram(2,tam2) == 1 && tam ~= tam2
            T1_Am = [T1_Am, tam];
            T2_Am = [T2_Am, tam2];
            Tong_Am = [Tong_Am, Histogram(1,tam) + Histogram(1,tam2)];
        end
    end
end

T1_Duong = [];
T2_Duong = [];
Tong_Duong = [];
for tduong = viTriBin0:length(Histogram(1,:))
    for tduong2 = tduong:length(Histogram(1,:))
        if Histogram(1,tduong) ~= 0 && Histogram(1,tduong2) ~= 0 && Histogram(2,tduong2) - Histogram(2,tduong) == 1 && tduong ~= tduong2
            T1_Duong = [T1_Duong, tduong];
            T2_Duong = [T2_Duong, tduong2];
            Tong_Duong = [Tong_Duong, Histogram(1,tduong) + Histogram(1,tduong2)];
        end
    end
end

Threshold_Am = [T1_Am; T2_Am; Tong_Am];
Threshold_Duong = [T1_Duong; T2_Duong; Tong_Duong];

% Cac threshold co the
% 2 Am 1 Duong
viTriAm_1 = [];
viTriAm_2 = [];
viTriDuong_1 = [];
viTriDuong_2 = [];
Tong_Am2_Duong2 =[];
for T2am = 1:length(Threshold_Am(1,:))
    for T2duong = 1:length(Threshold_Duong(1,:))
        if size_W <= Threshold_Am(3,T2am) + Threshold_Duong(3,T2duong) && Histogram(2,Threshold_Duong(1,T2duong)) ~= Histogram(2,Threshold_Am(1,T2am)) && Histogram(2,Threshold_Duong(1,T2duong)) ~= Histogram(2,Threshold_Am(2,T2am)) && Histogram(2,Threshold_Duong(2,T2duong)) ~= Histogram(2,Threshold_Am(1,T2am)) && Histogram(2,Threshold_Duong(2,T2duong)) ~= Histogram(2,Threshold_Am(2,T2am))
            viTriAm_1 = [viTriAm_1, Histogram(2,Threshold_Am(1,T2am))];
            viTriAm_2 = [viTriAm_2, Histogram(2,Threshold_Am(2,T2am))];
            viTriDuong_1 = [viTriDuong_1, Histogram(2,Threshold_Duong(1,T2duong))];
            viTriDuong_2 = [viTriDuong_2, Histogram(2,Threshold_Duong(2,T2duong))];
            Tong_Am2_Duong2 = [Tong_Am2_Duong2, Threshold_Am(3,T2am) + Threshold_Duong(3,T2duong)];
        end
    end
end
Am2_Duong2 = [viTriAm_1; viTriAm_2; viTriDuong_1; viTriDuong_2; Tong_Am2_Duong2];

%{
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
%}
end