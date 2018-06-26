function [ABCD Histogram] = bin(c,r,uh,u, watermark, So_Threshold)
if So_Threshold ==1
    So_Threshold = 2;
end
size_W = length(watermark(:));
d = u-uh;
Nho = min(d);
Lon = max(d);
bins = Nho:1:Lon;
Histogram = hist(d,bins);
Histogram = [Histogram; bins];
%viTriBin0 = find(Histogram(2,:)==0);
%viTriBin1 = find(Histogram(2,:)==1);
%viTriBinLon = find(Histogram(2,:)==Lon);
%viTriBinNho = find(Histogram(2,:)==Nho);
Threshold_1 = round(So_Threshold/2);
Threshold_2 = So_Threshold - Threshold_1;
SoLuongBinDuong = Lon;
SoLuongBinAm = Nho + 1;
%{
    % So Nguong Chan
if Threshold_1 == Threshold_2
    Threshold_Real = Threshold_1 - 1;

    AB = zeros(2,SoLuongBinAm-1);  % so luong cac bin tu 0 -> -nho nhat
    %Tong_AB = zeros(1,length(AB));
    for a = 0:-1:Nho
        b = a - abs(Threshold_Real);
        if b >= Nho && ismember(a,Histogram(2,:)) && ismember(b,Histogram(2,:))
            AB(:, abs(a)+1) = [a; b];      % Mang bat dau tu 1
            %Tong_AB(abs(a)+1) = Histogram(1,find(Histogram(2,:)==a))+ Histogram(1,find(Histogram(2,:)==b));
        end
    end
    CD = zeros(2,SoLuongBinDuong-1);
    %Tong_CD = zeros(1,length(CD));
    for c=1:1:Lon
        d = c + Threshold_Real;
        if d <= Lon && ismember(c,Histogram(2,:)) && ismember(d,Histogram(2,:))
            CD(:,c) = [c; d];
            %Tong_AB(c) = Histogram(1,find(Histogram(2,:)==c))+ Histogram(1,find(Histogram(2,:)==d));
        end
    end
    ABCD = zeros(4,length(AB(1,:))*length(CD(1,:)));
    start = 1;
    finish = length(CD(1,:));
    for ab = 1:length(AB(1,:))
        XX = zeros(2,length(CD(1,:)));
        for cd = 1:length(CD(1,:))
            XX(:,cd) = AB(:,ab); 
        end
        ABCD(:,start:finish)= [XX; CD];
        start = start + length(CD(1,:));;
        finish = finish + length(CD(1,:));;
    end

    % So Nguong Le
else
    Threshold_Lon = max(Threshold_1,Threshold_2)-1;
    Threshold_Nho = min(Threshold_1,Threshold_2)-1;
    % Nguong lon ben Am
    AB_1 = zeros(2,SoLuongBinAm-1);
    for a = 0:-1:Nho
        b = a - abs(Threshold_Lon);
        if b >= Nho && ismember(a,Histogram(2,:)) && ismember(b,Histogram(2,:))
            AB_1(:, abs(a)+1) = [a; b];      % Mang bat dau tu 1
        end
    end
    CD_1 = zeros(2,SoLuongBinDuong-1);
    for c=1:1:Lon
        d = c + Threshold_Nho;
        if d <= Lon && ismember(c,Histogram(2,:)) && ismember(d,Histogram(2,:))
            CD_1(:,c) = [c; d];
        end
    end
    ABCD_1 = zeros(4,length(AB_1(1,:))*length(CD_1(1,:)));
    start = 1;
    finish = length(CD_1(1,:));
    for ab = 1:length(AB_1(1,:))
        XX = zeros(2,length(CD_1(1,:)));
        for cd = 1:length(CD_1(1,:))
            XX(:,cd) = AB_1(:,ab); 
        end
        ABCD_1(:,start:finish)= [XX; CD_1];
        start = start + length(CD_1(1,:));;
        finish = finish + length(CD_1(1,:));;
    end
    % Nguong lon ben duong
    AB_2 = zeros(2,SoLuongBinAm-1);
    for a = 0:-1:Nho
        b = a - abs(Threshold_Nho);
        if b >= Nho && ismember(a,Histogram(2,:)) && ismember(b,Histogram(2,:))
            AB_2(:, abs(a)+1) = [a; b];      % Mang bat dau tu 1
        end
    end
    CD_2 = zeros(2,SoLuongBinDuong-1);
    for c=1:1:Lon
        d = c + Threshold_Lon;
        if d <= Lon && ismember(c,Histogram(2,:)) && ismember(d,Histogram(2,:))
            CD_2(:,c) = [c; d];
        end
    end
    ABCD_2 = zeros(4,length(AB_2(1,:))*length(CD_2(1,:)));
    start = 1;
    finish = length(CD_2(1,:));
    for ab = 1:length(AB_2(1,:))
        XX = zeros(2,length(CD_2(1,:)));
        for cd = 1:length(CD_2(1,:))
            XX(:,cd) = AB_2(:,ab); 
        end
        ABCD_2(:,start:finish)= [XX; CD_2];
        start = start + length(CD_2(1,:));;
        finish = finish + length(CD_2(1,:));;
    end
    ABCD = [ABCD_1 ABCD_2];
end
T = '';
for j = length(ABCD(1,:)):-1:1
    a1 = find(Histogram(2,:)==ABCD(1,j));
    a2 = find(Histogram(2,:)==ABCD(2,j));
    d1 = find(Histogram(2,:)==ABCD(3,j));
    d2 = find(Histogram(2,:)==ABCD(4,j));
    if a1 == a2 && d1 ~= d2
        Tong = Histogram(1,a1) + Histogram(1,d1) + Histogram(1,d2);
    elseif a1 == a2 && d1==d2
        Tong = Histogram(1,a1) + Histogram(1,d1);
    elseif a1 ~= a2 && d1~=d2
        Tong = Histogram(1,a1) + Histogram(1,a2) + Histogram(1,d1) + Histogram(1,d2);
    elseif a1 ~= a2 && d1==d2
        Tong = Histogram(1,a1) + Histogram(1,a2) + Histogram(1,d1);
    end
    if Tong < size_W
        ABCD(:,j) = [];
    end
end
%}
% Thu nghiem
% Ham tao tat ca cac theshold tu -255 255 gia tri tu dong dua histogram
AB = [];
for a = 0:-1:Nho
    for b = a:-1:Nho
        if ismember(b,Histogram(2,:)) && ismember(a,Histogram(2,:))
            AB = [AB, [a; b]];
        end
    end
end
ABCD=[];
for c=1:Lon
    for d=c:Lon
        if ismember(c,Histogram(2,:)) && ismember(d,Histogram(2,:))
            CD=zeros(2,length(AB));
            CD(1,:)=c;
            CD(2,:)=d;
            ABCD=[ABCD,[AB; CD]];
        end
    end
end
for j = length(ABCD(1,:)):-1:1
    a1 = find(Histogram(2,:)==ABCD(1,j));
    a2 = find(Histogram(2,:)==ABCD(2,j));
    d1 = find(Histogram(2,:)==ABCD(3,j));
    d2 = find(Histogram(2,:)==ABCD(4,j));
    if a1 == a2 && d1 ~= d2
        Tong = Histogram(1,a1) + Histogram(1,d1) + Histogram(1,d2);
    elseif a1 == a2 && d1==d2
        Tong = Histogram(1,a1) + Histogram(1,d1);
    elseif a1 ~= a2 && d1~=d2
        Tong = Histogram(1,a1) + Histogram(1,a2) + Histogram(1,d1) + Histogram(1,d2);
    elseif a1 ~= a2 && d1==d2
        Tong = Histogram(1,a1) + Histogram(1,a2) + Histogram(1,d1);
    end
    if Tong < size_W
        ABCD(:,j) = [];
    end
end
%CD = [];
%for j = 1:255
%    c = zeros(1,256-j);
%    c(:) = j;
 %   d = [j:255];
 %   CD = [CD, [c; d]];
%end

%{

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
%}

end