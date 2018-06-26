function [Am3_Duong3 Histogram] = bin(c,r,uh,u, watermark)
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
T3_Am = [];
Tong_Am = [];
for tam = viTriBin0:-1:1
    for tam2 = tam:-1:1
        for tam3 = tam2:-1:1
            if Histogram(1,tam) ~= 0 && Histogram(1,tam2) ~= 0 && Histogram(1,tam3) ~= 0...
               Histogram(2,tam) - Histogram(2,tam2) == 1 && Histogram(2,tam2) - Histogram(2,tam3) == 1 ...
               && tam ~= tam2 && tam2 ~= tam3
                T1_Am = [T1_Am, tam];
                T2_Am = [T2_Am, tam2];
                T3_Am = [T3_Am, tam3];
                Tong_Am = [Tong_Am, Histogram(1,tam) + Histogram(1,tam2) + Histogram(1,tam3)];
            end
        end
    end
end

T1_Duong = [];
T2_Duong = [];
T3_Duong = [];
Tong_Duong = [];
for tduong = viTriBin0:length(Histogram(1,:))
    for tduong2 = tduong:length(Histogram(1,:))
        for tduong3 = tduong2:length(Histogram(1,:))
            if Histogram(1,tduong) ~= 0 && Histogram(1,tduong2) ~= 0 && Histogram(1,tduong3) ~= 0 ...
               && Histogram(2,tduong2) - Histogram(2,tduong) == 1 && Histogram(2,tduong3) - Histogram(2,tduong2) == 1...
               && tduong ~= tduong2 && tduong3 ~= tduong2
                T1_Duong = [T1_Duong, tduong];
                T2_Duong = [T2_Duong, tduong2];
                T3_Duong = [T3_Duong, tduong3];
                Tong_Duong = [Tong_Duong, Histogram(1,tduong) + Histogram(1,tduong2) + Histogram(1,tduong3)];
            end
        end
    end
end

Threshold_Am = [T1_Am; T2_Am; T3_Am; Tong_Am];
Threshold_Duong = [T1_Duong; T2_Duong; T3_Duong; Tong_Duong];

% Cac threshold co the
% 3 Am 3 Duong
viTriAm_1 = [];
viTriAm_2 = [];
viTriAm_3 = [];
viTriDuong_1 = [];
viTriDuong_2 = [];
viTriDuong_3 = [];
Tong_Am3_Duong3 =[];
for T2am = 1:length(Threshold_Am(1,:))
    for T2duong = 1:length(Threshold_Duong(1,:))
        if size_W <= Threshold_Am(4,T2am) + Threshold_Duong(4,T2duong) ...
           && Histogram(2,Threshold_Duong(1,T2duong)) ~= Histogram(2,Threshold_Am(1,T2am)) ...
           && Histogram(2,Threshold_Duong(1,T2duong)) ~= Histogram(2,Threshold_Am(2,T2am)) ...
           && Histogram(2,Threshold_Duong(1,T2duong)) ~= Histogram(2,Threshold_Am(3,T2am)) ...
           && Histogram(2,Threshold_Duong(2,T2duong)) ~= Histogram(2,Threshold_Am(1,T2am)) ...
           && Histogram(2,Threshold_Duong(2,T2duong)) ~= Histogram(2,Threshold_Am(2,T2am)) ...
           && Histogram(2,Threshold_Duong(2,T2duong)) ~= Histogram(2,Threshold_Am(3,T2am)) ...
           && Histogram(2,Threshold_Duong(3,T2duong)) ~= Histogram(2,Threshold_Am(1,T2am)) ...
           && Histogram(2,Threshold_Duong(3,T2duong)) ~= Histogram(2,Threshold_Am(2,T2am)) ...
           && Histogram(2,Threshold_Duong(3,T2duong)) ~= Histogram(2,Threshold_Am(3,T2am))
            viTriAm_1 = [viTriAm_1, Histogram(2,Threshold_Am(1,T2am))];
            viTriAm_2 = [viTriAm_2, Histogram(2,Threshold_Am(2,T2am))];
            viTriAm_3 = [viTriAm_3, Histogram(2,Threshold_Am(3,T2am))];

            viTriDuong_1 = [viTriDuong_1, Histogram(2,Threshold_Duong(1,T2duong))];
            viTriDuong_2 = [viTriDuong_2, Histogram(2,Threshold_Duong(2,T2duong))];
            viTriDuong_3 = [viTriDuong_3, Histogram(2,Threshold_Duong(3,T2duong))];
            Tong_Am3_Duong3 = [Tong_Am3_Duong3, Threshold_Am(4,T2am) + Threshold_Duong(4,T2duong)];
        end
    end
end
Am2_Duong2 = [viTriAm_1; viTriAm_2; viTriAm_3; viTriDuong_1; viTriDuong_2; viTriDuong_3; Tong_Am3_Duong3];


end