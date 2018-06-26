OI = imread('DataDacBiet\lena.bmp');
MaxPSNR =0;
for i=1:200
    i
watermark=randi([0 1],1,30000/2); % random watermark theo bpp
watermark= watermark(:);
Denta = 1;
m = 1;
watermark_Cross = watermark;
watermark_Dot = watermark;
Sum1_Cross = sum(watermark_Cross(:));
Sum0_Cross = length(watermark_Cross(:)) - Sum1_Cross;
Sum1_Dot = sum(watermark_Dot(:));
Sum0_Dot = length(watermark_Dot(:)) - Sum1_Dot;
%--------------------------------------------------------------------------
%   Emebedded

[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(OI);
[BinAmCross BinDuongCross GapAm_Cross GapDuong_Cross Histogram_Cross] = bin_CaiTien(c_Cross,r_Cross,uh_Cross,u_Cross,watermark_Cross);
MaxPSNR_Cross = 0;
for i = 1:length(BinAmCross)
    BinAm_Cross_Temp = BinAmCross(i);
    BinDuong_Cross_Temp = BinDuongCross(i);
    if Sum1_Cross > Sum0_Cross
        [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp] = embedding_Shitf0_dchiam_gap_Chung(Denta, m, BinAm_Cross_Temp, BinDuong_Cross_Temp, GapAm_Cross, GapDuong_Cross, OI ,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
    else
        [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp] = embedding_Shitf1_dchiam_gap_Chung(Denta, m, BinAm_Cross_Temp, BinDuong_Cross_Temp, GapAm_Cross, GapDuong_Cross, OI ,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
    end
    if PSNR(WI_Cross_Temp,OI) > MaxPSNR_Cross
        MaxPSNR_Cross = PSNR(WI_Cross_Temp,OI);
        WI_Cross = WI_Cross_Temp;
        KEY_Cross = KEY_Cross_Temp;
        Check_Cross = Check_Cross_Temp;
        BinAm_Cross = BinAm_Cross_Temp;
        BinDuong_Cross = BinDuong_Cross_Temp;
    end
end
%%%%%%%%%%%--
[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Cross);
[BinAmDot BinDuongDot GapAm_Dot GapDuong_Dot Histogram_Dot] = bin_CaiTien(c_Dot,r_Dot,uh_Dot,u_Dot,watermark_Dot);
MaxPSNR_Dot = 0;
for dot = 1:length(BinDuongDot)
    BinAm_Dot_Temp = BinAmDot(dot);
    BinDuong_Dot_Temp = BinDuongDot(dot);
    if Sum1_Dot > Sum0_Dot
        [WI_Dot_Temp, size_W_Dot, KEY_Dot_Temp Check_Dot_Temp]=embedding_Shitf0_dchiam_gap_Chung(Denta, m, BinAm_Dot_Temp, BinDuong_Dot_Temp, GapAm_Dot, GapDuong_Dot, WI_Cross,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
    else
        [WI_Dot_Temp, size_W_Dot, KEY_Dot_Temp Check_Dot_Temp]=embedding_Shitf1_dchiam_gap_Chung(Denta, m, BinAm_Dot_Temp, BinDuong_Dot_Temp, GapAm_Dot, GapDuong_Dot, WI_Cross,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
    end
    if PSNR(WI_Dot_Temp,OI) > MaxPSNR_Dot
        MaxPSNR_Dot = PSNR(WI_Dot_Temp,OI);
        WI_Dot = WI_Dot_Temp;
        KEY_Dot = KEY_Dot_Temp;
        Check_Dot = Check_Dot_Temp;
        BinAm_Dot = BinAm_Dot_Temp;
        BinDuong_Dot = BinDuong_Dot_Temp;
    end
end
if MaxPSNR_Dot>MaxPSNR
    MaxPSNR=MaxPSNR_Dot
end
%if MaxPSNR_Dot >= 70
%    break
%end
end