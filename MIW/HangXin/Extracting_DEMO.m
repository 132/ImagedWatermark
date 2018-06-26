function [OImage, W] = Extracting_DEMO(SUM, Check_Dot, BinAm_Dot, BinDuong_Dot, GapAm_Dot, GapDuong_Dot, WI_Dot, size_W_Dot, KEY_Dot, Check_Cross, BinAm_Cross, BinDuong_Cross, GapAm_Cross, GapDuong_Cross, WI_Cross,size_W_Cross,KEY_Cross)
Denta = 1;
m = 1;
%--------------------------------------------------------------------------
%   Extracted
[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Dot);
if SUM ==0
    [WI_Cross, watermark_Dot] = extracting_Shift0_dchiam_gap_Chung(Denta, m, Check_Dot, BinAm_Dot, BinDuong_Dot, GapAm_Dot, GapDuong_Dot, WI_Dot, size_W_Dot, KEY_Dot, c_Dot, r_Dot, uh_Dot, u_Dot);
else
    [WI_Cross, watermark_Dot] = extracting_Shift1_dchiam_gap_Chung(Denta, m, Check_Dot, BinAm_Dot, BinDuong_Dot, GapAm_Dot, GapDuong_Dot, WI_Dot, size_W_Dot, KEY_Dot, c_Dot, r_Dot, uh_Dot, u_Dot);
end
%---------------------------------------------------
[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(WI_Cross);
if SUM==0
    [OImage, watermark_Cross] = extracting_Shift0_dchiam_gap_Chung(Denta, m, Check_Cross, BinAm_Cross, BinDuong_Cross, GapAm_Cross, GapDuong_Cross, WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
else
    [OImage, watermark_Cross] = extracting_Shift1_dchiam_gap_Chung(Denta, m, Check_Cross, BinAm_Cross, BinDuong_Cross, GapAm_Cross, GapDuong_Cross, WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
end

W = [watermark_Cross;watermark_Dot];
end
