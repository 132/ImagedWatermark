function [PhanLoai] = bin_PhanLoai(c,r,uh,u, watermark)
%Phan loai 2 threshold 3 threshold 3 threshold
size_W = length(watermark(:));
d = u-uh;
Nho = min(d);
Lon = max(d);
bins = Nho:1:Lon;
Histogram = hist(d,bins);
Histogram = [Histogram; bins];
Histogram_Temp = Histogram;
[Max1,ViTri1] = max(Histogram_Temp(1,:));   Histogram_Temp(:,ViTri1)=[];    
[Max2,ViTri2] = max(Histogram_Temp(1,:));   Histogram_Temp(:,ViTri2)=[];    
[Max3,ViTri3] = max(Histogram_Temp(1,:));   Histogram_Temp(:,ViTri3)=[];    
[Max4,ViTri4] = max(Histogram_Temp(1,:));   Histogram_Temp(:,ViTri4)=[];
[Max5,ViTri5] = max(Histogram_Temp(1,:));   Histogram_Temp(:,ViTri5)=[];
[Max6,ViTri6] = max(Histogram_Temp(1,:));   Histogram_Temp(:,ViTri6)=[];
[Max7,ViTri7] = max(Histogram_Temp(1,:));   Histogram_Temp(:,ViTri7)=[];
[Max8,ViTri8] = max(Histogram_Temp(1,:));   Histogram_Temp(:,ViTri8)=[];
if size_W < Max1 % Truong hop 1 threshold
    PhanLoai = [1, Max1];
elseif size_W < Max1 + Max2 % Truong hop 2 threshold
    PhanLoai = [2, Max1 + Max2];    
elseif size_W < Max1 + Max2 + Max3 % Truong hop 3 threshold
    PhanLoai = [3, Max1 + Max2 + Max3];    
elseif size_W < Max1 + Max2 + Max3 + Max4 % Truong hop 4 threshold
    PhanLoai = [4, Max1 + Max2 + Max3 + Max4];    
elseif size_W < Max1 + Max2 + Max3 + Max4 + Max5
    PhanLoai = [5, Max1 + Max2 + Max3 + Max4 + Max5];
elseif size_W < Max1 + Max2 + Max3 + Max4 + Max5 + Max6
    PhanLoai = [6, Max1 + Max2 + Max3 + Max4 + Max5 + Max6];
elseif size_W < Max1 + Max2 + Max3 + Max4 + Max5 + Max6 + Max7
    PhanLoai = [7, Max1 + Max2 + Max3 + Max4 + Max5 + Max6 + Max7];
elseif size_W < Max1 + Max2 + Max3 + Max4 + Max5 + Max6 + Max7 + Max8
    PhanLoai = [8, Max1 + Max2 + Max3 + Max4 + Max5 + Max6 + Max7 + Max8];
else
    PhanLoai = 0;
  %  disp('other value')
end

end