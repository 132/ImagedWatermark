function testAttack()

W = 'trideptraivodoi';

TapCover = dir('cover\*.bmp');
for i = 1:length(TapCover)
    cover = imread(strcat('cover\',TapCover(i).name));
        
    [WI,imin,imax,size_w] = embeddingS(cover,W)

    p = PSNR(cover, WI);
    
    imwrite(WI,strcat('WI\',TapCover(i).name));
    imwrite(WI,strcat('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Input\Images\Set1\',TapCover(i).name));

    w = extractingS(WI,imin,imax,size_w)

    fid = fopen(strcat(TapCover(i).name,'.txt')','w');
    if w
        fprintf(fid,'Truoc attack Rut duoc %s\r\n',w);
    end
    
cd 'C:\Users\Administrator\Desktop\MyWork\stirmark\Bin\Benchmark\';
system('"C:\Users\Administrator\Desktop\MyWork\stirmark\Bin\Benchmark\StirMark Benchmark.exe"');
cd 'C:\Users\Administrator\Desktop\MyWork\MIW\HS';

movefile('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Output\Images\Set1',TapCover(i).name);
mkdir('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Output\Images','Set1');
delete(strcat('C:\Users\Administrator\Desktop\MyWork\stirmark\Media\Input\Images\Set1\',TapCover(i).name));

    src = dir(strcat(TapCover(i).name,'\*.bmp'));

    for j = 1:length(src)
    filename = strcat(TapCover(i).name,'\',src(j).name);
    I = imread(filename);
    try
    w = extractingS(I,imin,imax,size_w);
    fprintf(fid,'%s\r\t ',src(j).name);
    if w
        fprintf(fid,'Rut duoc %s\r\n',w);
    end
    
    catch
    disp('An error occurred while retrieving information from the internet.');
    disp('Execution will continue.');
    end
    
   
    
    
    end
 fclose(fid);
end