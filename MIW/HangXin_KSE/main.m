OI = imread('DataSet\CT-MONO2-8-abdo.dcm.bmp');
OI = imread('DataSet\CT-MONO2-16-brain.dcm.bmp');
OI = imread('DataDacBiet\lena.bmp');
% w = 
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
Denta = 1;          % T
m = 1;              % d/m

watermark_Cross = watermark;
watermark_Dot = watermark;

Sum1_Cross = sum(watermark_Cross(:));
Sum0_Cross = length(watermark_Cross(:)) - Sum1_Cross;

Sum1_Dot = sum(watermark_Dot(:));
Sum0_Dot = length(watermark_Dot(:)) - Sum1_Dot;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% embedded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(OI);
if Sum1_Cross > Sum0_Cross
    [WI_Cross size_W_Cross KEY_Cross Check_Cross] = embedding_Shitf0_dchiam(Denta, m, OI,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
else
    [WI_Cross, size_W_Cross KEY_Cross Check_Cross] = embedding_Shitf1_dchiam(Denta, m, OI,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
end
%-------------------------------------------------
[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Cross); 
if Sum1_Dot > Sum0_Dot
    [WI_Dot, size_W_Dot, KEY_Dot Check_Dot]=embedding_Shitf0_dchiam(Denta, m, WI_Cross,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
else
    [WI_Dot, size_W_Dot, KEY_Dot Check_Dot]=embedding_Shitf1_dchiam(Denta, m, WI_Cross,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Dot);
if Sum1_Cross > Sum0_Cross
    [WI_Cross, watermark_Dot] = extracting_Shift0_dchiam(Denta, m, Check_Dot, WI_Dot,size_W_Dot,KEY_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
else
    [WI_Cross, watermark_Dot] = extracting_shift1_dchiam(Denta, m, Check_Dot, WI_Dot,size_W_Dot,KEY_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
end
%-------------------------------------------------
[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(WI_Cross);
if Sum1_Dot > Sum0_Dot
    [OImage, watermark_Cross] = extracting_Shift0_dchiam(Denta, m, Check_Cross, WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
else
    [OImage, watermark_Cross] = extracting_Shift1_dchiam(Denta, m, Check_Cross, WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
end