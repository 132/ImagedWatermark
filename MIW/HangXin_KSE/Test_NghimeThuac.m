OI = imread('DataDacBiet\lena.bmp');
%OI = imread('DataSet\CT-MONO2-8-abdo.dcm.bmp');
w = ['trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitr' ...
    'ideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptrai' ...
    'vodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoi' ...
    'trideptraitrideptraitrideptraitrideptraitrideptraivodoitrideptraivodoitrideptraivodoitrideptraivodoitridep'];
try     % co loi trong try thi lam` catch neu ko loi thi ra ngoai
    getQR();
catch 
    watermark = encode_qr(w, 'Character_set', 'ISO-8859-1');
end
%watermark = w;      % watermark

watermark=randi([0 1],1,28836/2); % random watermark theo bpp
watermark= watermark(:);
Denta = 1;
m = 1;

watermark_Cross = watermark;
watermark_Dot = watermark;

Sum1_Cross = sum(watermark_Cross(:));
Sum0_Cross = length(watermark_Cross(:)) - Sum1_Cross;

Sum1_Dot = sum(watermark_Dot(:));
Sum0_Dot = length(watermark_Dot(:)) - Sum1_Dot;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% embedded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------
[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(OI);
%[c_Cross_Sort,r_Cross_Sort,uh_Cross_Sort,u_Cross_Sort] = crossset_Sort(OI);
[BinAm_Cross BinDuong_Cross GapAm_Cross GapDuong_Cross Histogram_Cross] = bin_CaiTien(c_Cross,r_Cross,uh_Cross,u_Cross,watermark_Cross);

%[BinAm_Cross BinDuong_Cross GapAm_Cross GapDuong_Cross Histogram_Cross] = bin(c_Cross,r_Cross,uh_Cross,u_Cross,watermark_Cross);
if Sum1_Cross > Sum0_Cross
    [WI_Cross size_W_Cross KEY_Cross Check_Cross] = embedding_Shitf0_dchiam_gap_Chung(Denta, m, BinAm_Cross, BinDuong_Cross, GapAm_Cross, GapDuong_Cross, OI,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
else
    [WI_Cross size_W_Cross KEY_Cross Check_Cross] = embedding_Shitf1_dchiam_gap_Chung(Denta, m, BinAm_Cross, BinDuong_Cross, GapAm_Cross, GapDuong_Cross, OI,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
end
%-------------------------------------------------
[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Cross);
%[bin1_Dot bin2_Dot Histogram_Dot] = bin(c_Dot,r_Dot,uh_Dot,u_Dot,watermark_Dot);
[BinAm_Dot BinDuong_Dot GapAm_Dot GapDuong_Dot Histogram_Dot] = bin_CaiTien(c_Dot,r_Dot,uh_Dot,u_Dot,watermark_Dot);
if Sum1_Dot > Sum0_Dot
    [WI_Dot, size_W_Dot, KEY_Dot Check_Dot]=embedding_Shitf0_dchiam_gap_Chung(Denta, m, BinAm_Dot, BinDuong_Dot, GapAm_Dot, GapDuong_Dot, WI_Cross,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
else
    [WI_Dot, size_W_Dot, KEY_Dot Check_Dot]=embedding_Shitf1_dchiam_gap_Chung(Denta, m, BinAm_Dot, BinDuong_Dot, GapAm_Dot, GapDuong_Dot, WI_Cross,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
end
%[c_Cross1,r_Cross1,uh_Cross1,u_Cross1] = crossset(WI_Dot);
%[c_Cross_Sort,r_Cross_Sort,uh_Cross_Sort,u_Cross_Sort] = crossset_Sort(OI);
%[BinAm_Cross1 BinDuong_Cross1 GapAm_Cross1 GapDuong_Cross1 Histogram_Cross1] = bin_CaiTien(c_Cross1,r_Cross1,uh_Cross1,u_Cross1,watermark_Cross);
%if Sum1_Cross > Sum0_Cross
%    [WI_Cross1 size_W_Cross1 KEY_Cross1 Check_Cross1] = embedding_Shitf0_dchiam_gap_Chung(Denta, m, BinAm_Cross1, BinDuong_Cross1, GapAm_Cross1, GapDuong_Cross1, WI_Dot,watermark_Cross,c_Cross1,r_Cross1,uh_Cross1,u_Cross1);
%else
%    [WI_Cross1 size_W_Cross1 KEY_Cross1 Check_Cross1] = embedding_Shitf1_dchiam_gap(Denta, m, BinAm_Cross1, BinDuong_Cross1, GapAm_Cross1, GapDuong_Cross1, WI_Dot,watermark_Cross,c_Cross1,r_Cross1,uh_Cross1,u_Cross1);
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Dot);
if Sum1_Cross > Sum0_Cross
    [WI_Cross, watermark_Dot] = extracting_Shift0_dchiam_gap_Chung(Denta, m, Check_Dot, BinAm_Dot, BinDuong_Dot, GapAm_Dot, GapDuong_Dot, WI_Dot, size_W_Dot, KEY_Dot, c_Dot, r_Dot, uh_Dot, u_Dot);
else
    [WI_Cross, watermark_Dot] = extracting_Shift1_dchiam_gap_Chung(Denta, m, Check_Dot, BinAm_Dot, BinDuong_Dot, GapAm_Dot, GapDuong_Dot, WI_Dot, size_W_Dot, KEY_Dot, c_Dot, r_Dot, uh_Dot, u_Dot);
end
%---------------------------------------------------
%[bin1 bin2] = bin(c_Cross,r_Cross,uh_Cross,u_Cross,watermark);
[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(WI_Cross);
if Sum1_Dot > Sum0_Dot
%BinAm_Cross BinDuong_Cross GapAm_Cross GapDuong_Cross Histogram_Cross] = bin(c_Cross,r_Cross,uh_Cross,u_Cross,watermark_Cross);
    [OImage, watermark_Cross] = extracting_Shift0_dchiam_gap_Chung(Denta, m, Check_Cross, BinAm_Cross, BinDuong_Cross, GapAm_Cross, GapDuong_Cross, WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
else
    [OImage, watermark_Cross] = extracting_Shift1_dchiam_gap_Chung(Denta, m, Check_Cross, WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
end