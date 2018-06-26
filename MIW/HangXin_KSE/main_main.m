OI = imread('DataDacBiet\lena.bmp');
% 117*117
w = ['trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitr' ...
    'ideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptrai' ...
    'vodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraitrideptraitrideptraitrideptraitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitridep'];
% 113*113
w = ['trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitr' ...
    'ideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptrai' ...
    'vodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraitrideptraitr'];
% 109*109
w = ['trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitr' ...
    'ideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptrai' ...
    'vodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi'];
%105*105
w = ['trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitr' ...
    'ideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptrai' ...
    'vodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi'];
% 101*101
w = ['trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitr' ...
    'ideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptrai' ...
    'vodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi'];
%97*97
w = ['trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitr' ...
    'ideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptrai' ...
    'vodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptrai'];
try     % co loi trong try thi lam` catch neu ko loi thi ra ngoai
    getQR();
catch 
    watermark = encode_qr(w, 'Character_set', 'ISO-8859-1');
end
watermark=randi([0 1],1,3000/2); % random watermark theo bpp
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
[BinAmCross BinDuongCross GapAm_Cross GapDuong_Cross Histogram_Cross] = bin_CaiTien_2(c_Cross,r_Cross,uh_Cross,u_Cross,watermark_Cross);
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
%--------------------------------------------------------------------------
%   Extracted
[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Dot);
if Sum1_Cross > Sum0_Cross
    [WI_Cross, watermark_Dot] = extracting_Shift0_dchiam_gap_Chung(Denta, m, Check_Dot, BinAm_Dot, BinDuong_Dot, GapAm_Dot, GapDuong_Dot, WI_Dot, size_W_Dot, KEY_Dot, c_Dot, r_Dot, uh_Dot, u_Dot);
else
    [WI_Cross, watermark_Dot] = extracting_Shift1_dchiam_gap_Chung(Denta, m, Check_Dot, BinAm_Dot, BinDuong_Dot, GapAm_Dot, GapDuong_Dot, WI_Dot, size_W_Dot, KEY_Dot, c_Dot, r_Dot, uh_Dot, u_Dot);
end
%---------------------------------------------------
[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(WI_Cross);
if Sum1_Dot > Sum0_Dot
    [OImage, watermark_Cross] = extracting_Shift0_dchiam_gap_Chung(Denta, m, Check_Cross, BinAm_Cross, BinDuong_Cross, GapAm_Cross, GapDuong_Cross, WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
else
    [OImage, watermark_Cross] = extracting_Shift1_dchiam_gap_Chung(Denta, m, Check_Cross, WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
end