OI = imread('DataDacBiet\lena.bmp');
watermark=randi([0 1],1,20000/2); % random watermark theo bpp
watermark= watermark(:);
[MaxPSNR_Cross, MaxPSNR_Dot, WI_Cross, WI_Dot] = BangChinhThuc(OI,watermark);


Am1_Temp = Am2_Duong2(1,1);
            Am2_Temp = Am2_Duong2(2,1);
            Duong1_Temp = Am2_Duong2(3,1);
            Duong2_Temp = Am2_Duong2(4,1);
[WI_Cross_Temp_ size_W_Cross KEY_Cross_Temp Check_Cross_Temp k] = embedding__TuDong(Denta, m, Am1_Temp, Am2_Temp, Duong1_Temp, Duong2_Temp, OI, watermark_Cross, c_Cross, r_Cross, uh_Cross, u_Cross);


OI = imread('DataDacBiet\lena.bmp');
OI = double(OI);
I = OI(:);
Min = min(I);
Max = max(I);
binnn = Min:1:Max;
figure;
hist(I,binnn,0:1000:25000)
ylim([0 21000]);

figure;
hist(d,bins)
ylim([0 21000]);