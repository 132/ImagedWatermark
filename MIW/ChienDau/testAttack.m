function testAttack()
w = 'trideptraivodoi';
W = 'trideptraivodoi';
try     % co loi trong try thi lam` catch neu ko loi thi ra ngoai
    getQR();
catch 
    w = encode_qr(w, 'Character_set', 'ISO-8859-1');
end
watermark = w;
TapCover = dir('DataSet\*.bmp');
for i = 1:length(TapCover)
    cover = imread(strcat('DataSet\',TapCover(i).name));
        
    watermark_Cross = w;
    watermark_Dot = w;
    % embedded
    [c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(cover);
    [WI_Cross size_W_Cross KEY_Cross] = embedding(cover,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);

    [c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Cross); 
    [WI_Dot, size_W_Dot, KEY_Dot]=embedding(WI_Cross,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);


    p = PSNR(cover, WI_Dot)
    
    imwrite(WI_Dot,strcat('WI\',TapCover(i).name));
    imwrite(WI_Dot,strcat('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Input\Images\Set1\',TapCover(i).name));

    % extracted
    [c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Dot); 
    [WI_Cross, watermark_Dot] = extracting(WI_Dot,size_W_Dot,KEY_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);

    [c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(WI_Cross);
    [OImage, watermark_Cross] = extracting(WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);


    fid = fopen(strcat(TapCover(i).name,'.txt')','w');
    fprintf(fid,'Truoc attack PSNR cua anh reversible %.3f',PSNR(cover,OImage));
    if watermark_Dot 
        if watermark_Cross
            fprintf(fid,'Truoc attack Rut duoc watermark_Dot - Cross %s - %s\r\n',watermark_Dot,watermark_Cross);
        end
    end
    
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
    [c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(I); 
    [WI_Cross, watermark_Dot] = extracting(I,size_W_Dot,KEY_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);

    [c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(WI_Cross);
    [OImage, watermark_Cross] = extracting(WI_Cross,size_W_Cross,KEY_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);

    fprintf(fid,'%s\r\t ',src(j).name);
    fprintf(fid,'PSNR  %.3f ',PSNR(cover,OImage));
    if watermark_Dot || watermark_Cross
        fprintf(fid,'Truoc attack Rut duoc watermark_Dot %s - %s\r\n',watermark_Dot,watermark_Cross);
    end
    
    catch
    disp('An error occurred while retrieving information from the internet.');
    disp('Execution will continue.');
    end
    end
 fclose(fid);
end