OI = imread('DataSet\CT-MONO2-8-abdo.dcm.bmp');
OI = imread('DataSet\CT-MONO2-16-brain.dcm.bmp');
OI = imread('DataDacBiet\lena.bmp');
% w = 0.09
w = 'trideptraivodoitri';
try     % co loi trong try thi lam` catch neu ko loi thi ra ngoai
    getQR();
catch 
    watermark = encode_qr(w, 'Character_set', 'ISO-8859-1');
end
%watermark = w;      % watermark

Denta = 1;          % T
m = 1;              % d/m

[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(OI);
[WI_Cross, size_W, KEY, Check] = embedding_Shitf0_dchiam(Denta, m, OI, watermark, c_Cross, r_Cross, uh_Cross, u_Cross);
[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(WI_Cross);
[OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, WI_Cross, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Ket hop Dot 
watermark_Cross = w;
watermark_Dot = w;
% embedded
[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(OI);
[WI_Cross size_W_Cross KEY_Cross] = embedding(OI,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);

[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Cross); 
[WI_Dot, size_W_Dot, KEY_Dot]=embedding(WI_Cross,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
% extracted
[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Dot); 
[WI_Cross, watermark_Dot] = extracting(WI_Dot,size_W_Dot,KEY_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);

[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(WI_Cross);
[OImage, watermark_Cross] = extracting(WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555555

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   IWT     CR an ko can watemrraked_Error
% Embedded
LS = liftwave('cdf2.2','Int2Int');
[CA,CH,CV,CD] = lwt2(double(OI),LS);

[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(CD);
[CD_Modi size_W KEY Check] = embedding_Shitf0_dchiam_IWT_(Denta, m, CD,watermark,c_Cross,r_Cross,uh_Cross,u_Cross);

watermarkedImage = ilwt2(CA,CH,CV,CD_Modi,LS);
watermarkedImage_Uint8 = uint8(watermarkedImage);
watermarkedImage_Error = watermarkedImage - double(watermarkedImage_Uint8);

% extracting
watermarkedImage_Dung = double(watermarkedImage_Uint8) + watermarkedImage_Error; 
LS = liftwave('cdf2.2','Int2Int');
[CA,CH,CV,CD_Modi_] = lwt2(double(watermarkedImage_Dung),LS);

[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(CD_Modi_);
[CD_OI, watermark] = extracting_Shift0_dchiam_IWT_(Denta, m, Check, CD_Modi_, size_W,KEY,c_Cross,r_Cross,uh_Cross,u_Cross);

OImage = ilwt2(CA,CH,CV,CD_OI,LS);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xem histogram Array
subplot(3,1,1)
xbins1 = -4:4;  % bin
hist(x,xbins1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%% test code IWT  %%%%
BanGoc = OI(:);                 % chuyen sang dang cot
BanPhu = watermarkedImage(:);   % chuyen sang dang cot
BanPhuTru1 = find(BanPhu==-1);  % cac vi tri gia tri -1 trong watermarkedImage
BanPhu256 = find(BanPhu==256);  % cac vi tri gia tri 256 trong watermarkedImage

TongBanGocTru1 = sum(BanGoc(BanPhuTru1)); % Tong gia tri ben BanGoc = -1
TongBanGoc256 = sum(BanGoc(BanPhu256));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Shift 0 unchange 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(OI);
[WI_Cross, size_W, KEY] = embedding_Shitf0(Denta, OI, watermark, c_Cross, r_Cross, uh_Cross, u_Cross);
[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(WI_Cross);
[OImage, Watermark] = extracting_Shift0(Denta, WI_Cross, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Shift 0 unchange 1 - d/2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(OI);
[WI_Cross, size_W, KEY] = embedding_Shitf0_dchia2(Denta, OI, watermark, c_Cross, r_Cross, uh_Cross, u_Cross);
[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(WI_Cross);
[OImage, Watermark] = extracting_Shift0_dchia2(Denta, WI_Cross, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

% Khong Sorting
[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset_KhongSort(OI);
[WI_Cross, size_W, KEY] = embedding_Shitf0_dchia2(Denta, OI, watermark, c_Cross, r_Cross, uh_Cross, u_Cross);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Shift 0 unchange 1 - d/4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(OI);
[WI_Cross, size_W, KEY] = embedding_Shitf0_dchia4(Denta, OI, watermark, c_Cross, r_Cross, uh_Cross, u_Cross);
[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(WI_Cross);
[OImage, Watermark] = extracting_Shift0_dchia4(Denta, WI_Cross, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Shift 0 unchange 1 - d/m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(OI);
[WI_Cross, size_W, KEY] = embedding_Shitf0_dchiam(Denta, m, OI, watermark, c_Cross, r_Cross, uh_Cross, u_Cross);
[c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(WI_Cross);
[OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, WI_Cross, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               combine CH,CV,CD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LS = liftwave('cdf2.2','Int2Int');
[CA,CH,CV,CD] = lwt2(double(OI),LS);

[c_Cross, r_Cross, uh_Cross, u_Cross, subband] = crosset_Combine(CD,CV,CH);
[CD_M, CV_M, CH_M, size_W, KEY, Check] = embedding_Shitf0_dchiam_IWT_Combine(Denta, m, CD,CV,CH, watermark, c_Cross, r_Cross, uh_Cross, u_Cross, subband);

watermarkedImage = ilwt2(CA,CH_M,CV_M,CD_M,LS);
watermarkedImage_Uint8 = uint8(watermarkedImage);
watermarkedImage_Error = watermarkedImage - double(watermarkedImage_Uint8);

% extracting
watermarkedImage_Dung = double(watermarkedImage_Uint8) + watermarkedImage_Error; 
LS = liftwave('cdf2.2','Int2Int');
[CA,CH_Modi_,CV_Modi_,CD_Modi_] = lwt2(double(watermarkedImage_Dung),LS);

[c_Cross, r_Cross, uh_Cross, u_Cross, subband] = crosset_Combine(CD_Modi_,CV_Modi_,CH_Modi_);
[CD_OI,CV_OI,CH_OI, watermark] = extracting_Shift0_dchiam_IWT_Combine(Denta, m, Check, CD_Modi_,CV_Modi_,CH_Modi_, size_W,KEY,c_Cross,r_Cross,uh_Cross,u_Cross, subband);

OImage = ilwt2(CA,CH_OI,CV_OI,CD_OI,LS);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Gaussian local variance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
