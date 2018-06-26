TapCover = dir('DataSet\*.bmp');
for i = 1:length(TapCover)
    w = 'trideptraivodoi';
    try     % co loi trong try thi lam` catch neu ko loi thi ra ngoai
        getQR();
    catch 
        w = encode_qr(w, 'Character_set', 'ISO-8859-1');
    end
    %watermark = w;      % watermark
    Denta = 1;          % T
    m = 1;              % d/m
    watermark = w;
    OI = imread(strcat('DataSet\',TapCover(i).name));
        
    % Embedded %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    LS = liftwave('cdf2.2','Int2Int');
    [CA,CH,CV,CD] = lwt2(double(OI),LS);
    [c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(CD);
    [CD_Modi size_W KEY Check] = embedding_Shitf0_dchiam_IWT_(Denta, m, CD,watermark,c_Cross,r_Cross,uh_Cross,u_Cross);
    watermarkedImage = ilwt2(CA,CH,CV,CD_Modi,LS);
    watermarkedImage_Uint8 = uint8(watermarkedImage);
    watermarkedImage_Error = watermarkedImage - double(watermarkedImage_Uint8);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    p = PSNR(OI, watermarkedImage_Uint8)
    
    imwrite(watermarkedImage_Uint8,strcat('WI_IWT\',TapCover(i).name));
    imwrite(watermarkedImage_Uint8,strcat('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Input\Images\Set1\',TapCover(i).name));

    % extracted
    % extracting
        watermarkedImage_Dung = double(watermarkedImage_Uint8) + watermarkedImage_Error; 
        LS = liftwave('cdf2.2','Int2Int');
        [CA,CH,CV,CD_Modi_] = lwt2(double(watermarkedImage_Dung),LS);

        [c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(CD_Modi_);
        [CD_OI, watermark] = extracting_Shift0_dchiam_IWT_(Denta, m, Check, CD_Modi_, size_W,KEY,c_Cross,r_Cross,uh_Cross,u_Cross);

        OImage = ilwt2(CA,CH,CV,CD_OI,LS);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    fid = fopen(strcat(TapCover(i).name,'_IWT.txt')','w');
    fprintf(fid,'\s\n Truoc attack PSNR: %.3f ',PSNR(OI,OImage));
    fprintf(fid,'Truoc attack PSNR: %.3f ',PSNR(OI,OImage));
    %if watermark_Dot
    giai = decode_qr(watermark);
    if giai
        fprintf(fid,'Truoc attack Cross %s',giai);
    end
   % end
    
cd 'C:\Users\Administrator\Desktop\MyWork\stirmark\Bin\Benchmark\';
system('"C:\Users\Administrator\Desktop\MyWork\stirmark\Bin\Benchmark\StirMark Benchmark.exe"');
cd 'C:\Users\Administrator\Desktop\MyWork\MIW\ChienDau';

movefile('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Output\Images\Set1',strcat(TapCover(i).name,'_IWT'));
mkdir('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Output\Images','Set1');
delete(strcat('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Input\Images\Set1\',TapCover(i).name));

    src = dir(strcat(TapCover(i).name,'_IWT\*.bmp'));
    for j = 1:length(src)
    filename = strcat(TapCover(i).name,'_IWT\',src(j).name);
    I = imread(filename);
    try
    % extracted
        watermarkedImage_Dung = double(I) + watermarkedImage_Error; 
        LS = liftwave('cdf2.2','Int2Int');
        [CA,CH,CV,CD_Modi_] = lwt2(double(watermarkedImage_Dung),LS);

        [c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(CD_Modi_);
        [CD_OI, watermark] = extracting_Shift0_dchiam_IWT_(Denta, m, Check, CD_Modi_, size_W,KEY,c_Cross,r_Cross,uh_Cross,u_Cross);

        OImage = ilwt2(CA,CH,CV,CD_OI,LS);    
    
    dc = decode_qr(watermark);
    fprintf(fid,'\r\n %s',src(j).name);
    fprintf(fid,' PSNR: %.3f',PSNR(OI,OImage));
    fprintf(fid,' NC: %.3f',NC(w,watermark));
    if dc
        fprintf(fid,' watermark: %s',dc);
    end
    
    catch
    disp('An error occurred while retrieving information from the internet.');
    disp('Execution will continue.');
    end
    end
 fclose(fid);
clearvars -except TapCover
end