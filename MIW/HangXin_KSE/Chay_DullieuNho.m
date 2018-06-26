TapCover = dir('Sosanh_Sachnev_Hwang\*.bmp');
Bpp = [264 2622 5244 7886]; % 130000 140000];
parfor index = 1:length(TapCover)
    fid = fopen(strcat(TapCover(index).name,'_PSNR2.txt')','w');
    OI = imread(strcat('Sosanh_Sachnev_Hwang\',TapCover(index).name));
    A = strcat('Sosanh_Sachnev_Hwang\',TapCover(index).name)
    for index2 =1:length(Bpp)
        Bpp(index2)
        fprintf(fid,'\r\n Bpp: %.3f ',Bpp(index2));
        MAX_MAX = 0; 
        for t = 1:200 
            t
            watermark=randi([0 1],1,Bpp(index2)/2); % random watermark theo bpp
            watermark= watermark(:);
            [MaxPSNR_Cross, MaxPSNR_Dot, WI_Cross, WI_Dot] = BangChinhThuc(OI,watermark);
            if MaxPSNR_Dot > MAX_MAX
                MAX_MAX = MaxPSNR_Dot;
            end
        end
        fprintf(fid,'Bpp: %.3f - %.3f',Bpp(index2),MAX_MAX);
    end
    fclose(fid);
end