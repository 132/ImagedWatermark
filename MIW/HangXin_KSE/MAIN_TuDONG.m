%OI = imread('DataDacBiet\lena.bmp');
%watermark=randi([0 1],1,80000/2); % random watermark theo bpp
%watermark= watermark(:);
function [MaxPSNR_Cross, MaxPSNR_Dot, WI_Cross, WI_Dot, T_Cross, T_Dot, ABCD] = BangChinhThuc(OI,watermark)
watermark_LSB=randi([0 1],1,51); % random watermark theo bpp
watermark_LSB = watermark_LSB(:);
Denta = 1;
m = 1;
watermark_Cross = [watermark_LSB; watermark];
watermark_Dot = [watermark_LSB; watermark];

[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(OI);
[PhanLoai] = bin_PhanLoai(c_Cross,r_Cross,uh_Cross,u_Cross, watermark_Cross);
[ABCD Histogram] = bin_CaiTien_TuDOng_XaiDuoc(c_Cross,r_Cross,uh_Cross,u_Cross, watermark_Cross, PhanLoai(1));

MaxPSNR_Cross = 0;
for i = 1:length(ABCD(1,:))            
    Am1_Temp = ABCD(1,i);
    Am2_Temp = ABCD(2,i);
    Duong1_Temp = ABCD(3,i);
    Duong2_Temp = ABCD(4,i);
    %if 
    [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp S] = embedding__TuDong_Cross(Denta, m, Am1_Temp, Am2_Temp, Duong1_Temp, Duong2_Temp, OI ,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross, watermark_LSB);
    if S ==0
        continue
    end
    if PSNR(WI_Cross_Temp,OI) > MaxPSNR_Cross
        MaxPSNR_Cross = PSNR(WI_Cross_Temp,OI);
        WI_Cross = WI_Cross_Temp;
        KEY_Cross = KEY_Cross_Temp;
        Check_Cross = Check_Cross_Temp;
        Am1_Cross = Am1_Temp;
        Am2_Cross = Am2_Temp;
        Duong1_Cross = Duong1_Temp;
        Duong2_Cross = Duong2_Temp;
    end
end
T_Cross = [Am1_Cross; Am2_Cross; Duong1_Cross; Duong2_Cross];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Cross);
[PhanLoai_Dot] = bin_PhanLoai(c_Dot,r_Dot,uh_Dot,u_Dot, watermark_Dot);
[ABCD_Dot Histogram_Dot] = bin_CaiTien_TuDOng_XaiDuoc(c_Dot,r_Dot,uh_Dot,u_Dot,watermark_Dot, PhanLoai_Dot(1));
MaxPSNR_Dot = 0;
for i = 1:length(ABCD_Dot(1,:))            
    Am1_Temp = ABCD_Dot(1,i);
    Am2_Temp = ABCD_Dot(2,i);
    Duong1_Temp = ABCD_Dot(3,i);
    Duong2_Temp = ABCD_Dot(4,i);

    [WI_Dot_Temp size_W_Dot KEY_Dot_Temp Check_Dot_Temp S_] = embedding__TuDong_Cross(Denta, m, Am1_Temp, Am2_Temp, Duong1_Temp, Duong2_Temp, WI_Cross ,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot,watermark_LSB);
    if S_==0
        continue
    end
    if PSNR(WI_Dot_Temp,OI) > MaxPSNR_Dot
        MaxPSNR_Dot = PSNR(WI_Dot_Temp,OI);
        WI_Dot = WI_Dot_Temp;
        KEY_Dot = KEY_Dot_Temp;
        Check_Dot = Check_Dot_Temp;
        Am1_Dot = Am1_Temp;
        Am2_Dot = Am2_Temp;
        Duong1_Dot = Duong1_Temp;
        Duong2_Dot = Duong2_Temp;
    end
end
T_Dot = [Am1_Dot; Am2_Dot; Duong1_Dot; Duong2_Dot];
end