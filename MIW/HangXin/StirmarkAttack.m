TapCover = dir('DataSet\*.bmp');
for i = 1:length(TapCover)
    OI = imread(strcat('DataSet\',TapCover(i).name));
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
    
    % embedded
    [c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(OI);
    [WI_Cross, size_W, KEY, Check] = embedding_Shitf0_dchiam(Denta, m, OI, watermark, c_Cross, r_Cross, uh_Cross, u_Cross);

    p = PSNR(OI, WI_Cross)
    
    imwrite(WI_Cross,strcat('WI\',TapCover(i).name));
    imwrite(WI_Cross,strcat('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Input\Images\Set1\',TapCover(i).name));

    % extracted
    [c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(WI_Cross);
    [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, WI_Cross, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);

    fid = fopen(strcat(TapCover(i).name,'.txt')','w');
    fprintf(fid,'Truoc attack PSNR: %.3f ',PSNR(OI,OImage));
    %if watermark_Dot
        if Watermark
            fprintf(fid,'watermark attack: %s\r\n',Watermark);
        end
   % end
    
cd 'C:\Users\Administrator\Desktop\MyWork\stirmark\Bin\Benchmark\';
system('"C:\Users\Administrator\Desktop\MyWork\stirmark\Bin\Benchmark\StirMark Benchmark.exe"');
cd 'C:\Users\Administrator\Desktop\MyWork\MIW\ChienDau';

movefile('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Output\Images\Set1',TapCover(i).name);
mkdir('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Output\Images','Set1');
delete(strcat('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Input\Images\Set1\',TapCover(i).name));

    src = dir(strcat(TapCover(i).name,'\*.bmp'));
    for j = 1:length(src)
    filename = strcat(TapCover(i).name,'\',src(j).name);
    I = imread(filename);
    try
    % extracted
    [c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(I);
    [OImage, Watermark] = extracting_Shift0_dchiam(Denta, m, Check, I, size_W, KEY, c_Cross, r_Cross, uh_Cross, u_Cross);
    dc = decode_qr(Watermark);
    fprintf(fid,'\r\n %s ',src(j).name);
    fprintf(fid,'PSNR: %.3f ',PSNR(OI,OImage));
    fprintf(fid,'NC: %.3f ',NC(w,Watermark));
    if dc
        fprintf(fid,'watermark: %s',dc);
    end
    
    catch
    disp('An error occurred while retrieving information from the internet.');
    disp('Execution will continue.');
    end
    end
 fclose(fid);
  clearvars -except TapCover
end