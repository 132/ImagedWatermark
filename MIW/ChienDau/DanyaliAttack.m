%OI = imread('DataSet\CT-MONO2-8-abdo.dcm.bmp');
w = 'trideptraivodoi';
try     % co loi trong try thi lam` catch neu ko loi thi ra ngoai
    getQR();
catch 
    w = encode_qr(w, 'Character_set', 'ISO-8859-1');
end
watermark = w;      % watermark
Denta = 1;          % T
m = 1;              % d/m

TapCover =  dir('DataSet\*.bmp');
for i = 1:length(TapCover)
    cover = strcat('DataSet\',TapCover(i).name)
    OI = imread(cover);
    
    % Embedded %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(OI);
    [WI_Cross, size_W, KEY Check] = embedding_Shitf0_dchiam(Denta, m, OI, watermark, c_Cross, r_Cross, uh_Cross, u_Cross);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fid = fopen(strcat('DataSet',TapCover(i).name,'.txt'),'w');
    
    %average filtering
    h = fspecial('average', [5, 5]);
    meanImageAttacked = filter2(h, WI_Cross);
    % Extracting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(meanImageAttacked);
        [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, meanImageAttacked, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);
    dc = decode_qr(Watermark);
    fprintf(fid,'\r\n average filtering ');
    fprintf(fid,'NC: %12.8f ',NC(w,Watermark));
    if dc
        fprintf(fid,'Rut duoc-%s \t',dc);
    end
    fprintf(fid,'PSNR: %12.8f',PSNR(OImage,OI));

    %motion blur
    LEN = 21;
    THETA = 11;
    PSF = fspecial('motion', LEN, THETA);
    blurred = imfilter(WI_Cross, PSF, 'conv', 'circular');
    %[watermark_1_extracted] = watermark_extraction_1(blurred, RoiMap, Uw1, Vw1, key1);
    % Extracting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(blurred);
        [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, blurred, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

    dc = decode_qr(Watermark);
    fprintf(fid,'\r\n motion blur ');
    fprintf(fid,'NC: %12.8f ',NC(w,Watermark));
    if dc
        fprintf(fid,'Rut duoc-%s \t',dc);
    end
    fprintf(fid,'PSNR: %12.8f',PSNR(OI,OImage));

    %hisogram equa
    histogram = histeq(WI_Cross);
    %[watermark_1_extracted] = watermark_extraction_1(histogram, RoiMap, Uw1, Vw1, key1);
    % Extracting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(histogram);
        [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, histogram, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

    dc = decode_qr(Watermark);
    fprintf(fid,'\r\n hisogram equa ');
    fprintf(fid,'NC: %12.8f ',NC(w,Watermark));
    if dc
        fprintf(fid,'Rut duoc-%s \t',dc);
    end
    fprintf(fid,'PSNR: %12.8f',PSNR(OI,OImage));

    %median fileter
    medianfilter = medfilt2(WI_Cross,[15 15]);
    %[watermark_1_extracted] = watermark_extraction_1(medianfilter, RoiMap, Uw1, Vw1, key1);
    % Extracting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(medianfilter);
        [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, medianfilter, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

    dc = decode_qr(Watermark);
    fprintf(fid,'\r\n median fileter ');
    fprintf(fid,'NC: %12.8f ',NC(w,Watermark));
    if dc
        fprintf(fid,'Rut duoc-%s \t',dc);
    end
    fprintf(fid,'PSNR: %12.8f',PSNR(OI,OImage));

    %Sharpen
    temp = uint8(WI_Cross);
    SH = Sharpen(temp);
    %[watermark_1_extracted] = watermark_extraction_1(SH, RoiMap, Uw1, Vw1, key1);
    % Extracting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(SH);
        [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, SH, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

    dc = decode_qr(Watermark);
    fprintf(fid,'\r\n Sharpen ');
    fprintf(fid,'NC: %12.8f ',NC(w,Watermark));
    if dc
        fprintf(fid,'Rut duoc-%s \t',dc);
    end
    fprintf(fid,'PSNR: %12.8f',PSNR(OI,OImage));

    %resize
    [h c] = size(OI);
    reimg = imresize(WI_Cross,[64 64]);
    reimg = imresize(reimg,[h c]);
    %[watermark_1_extracted] = watermark_extraction_1(reimg, RoiMap, Uw1, Vw1, key1);
    % Extracting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(reimg);
        [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, reimg, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

    dc = decode_qr(Watermark);
    fprintf(fid,'\r\n resize ');
    fprintf(fid,'NC: %12.8f ',NC(w,Watermark));
    if dc
       fprintf(fid,'Rut duoc-%s \t',dc);
    end
    fprintf(fid,'PSNR: %12.8f',PSNR(OI,OImage));

    %rotation 
    rotationImageAttacked = imrotate(WI_Cross, 70, 'crop');
    %[watermark_1_extracted] = watermark_extraction_1(rotationImageAttacked, RoiMap, Uw1, Vw1, key1);
    % Extracting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(rotationImageAttacked);
        [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, rotationImageAttacked, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

    dc = decode_qr(Watermark);
    fprintf(fid,'\r\n rotation ');
    fprintf(fid,'NC: %12.8f ',NC(w,Watermark));
    if dc
       fprintf(fid,'Rut duoc-%s \t',dc);
    end
    fprintf(fid,'PSNR: %12.8f',PSNR(OI,OImage));

    %contrast adjustment
    contrastImage = imadjust(WI_Cross, [0 0.8], [0 1]);
    %[watermark_1_extracted] = watermark_extraction_1(contrastImage, RoiMap, Uw1, Vw1, key1);
   % [watermark_1_extracted, watermark_2_extracted] = watermark_extraction(contrastImage);
    % Extracting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(contrastImage);
        [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, contrastImage, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

    dc = decode_qr(Watermark);
    fprintf(fid,'\r\n contrast adjustment ');
    fprintf(fid,'NC: %12.8f ',NC(w,Watermark));
    if dc
       fprintf(fid,'Rut duoc-%s \t',dc);
    end
    fprintf(fid,'PSNR: %12.8f',PSNR(OImage,OI));
    
    %CROP Attack
    test= crop(WI_Cross,4);
    %[watermark_1_extracted] = watermark_extraction_1(contrastImage, RoiMap, Uw1, Vw1, key1);
    %[watermark_1_extracted, watermark_2_extracted] = watermark_extraction(test);
    % Extracting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [c_Cross, r_Cross, uh_Cross, u_Cross] = crossset(test);
        [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, test, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

    dc = decode_qr(Watermark);
    fprintf(fid,'\r\n Crop1/4 ');
    fprintf(fid,'NC: %12.8f ',NC(w,Watermark));
    if dc
       fprintf(fid,'Rut duoc-%s \t',dc);
    end
    fprintf(fid,'PSNR: %12.8f',PSNR(OI,OImage));
    
    fclose(fid);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   IWT


% Extracting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%watermarkedImage_Dung = double(watermarkedImage_Uint8) + watermarkedImage_Error; 
%LS = liftwave('cdf2.2','Int2Int');
%[CA,CH,CV,CD_Modi_] = lwt2(double(watermarkedImage_Dung),LS);

%[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(CD_Modi_);
%[CD_OI, watermark] = extracting_Shift0_dchiam(Denta, m, CD_Modi_, size_W,KEY,c_Cross,r_Cross,uh_Cross,u_Cross);

%OImage = ilwt2(CA,CH,CV,CD_OI,LS);