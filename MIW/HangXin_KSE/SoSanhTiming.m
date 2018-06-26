TapCover = dir('Sosanh_Sachnev_Hwang\*.bmp');
Bpp = [264 2622 5244 7886 10000 20000 30000 40000]; % 130000 140000];
parfor index = 1:length(TapCover)
    fid = fopen(strcat(TapCover(index).name,'_PSNR.txt')','w');
    OI = imread(strcat('Sosanh_Sachnev_Hwang\',TapCover(index).name));
    A = strcat('Sosanh_Sachnev_Hwang\',TapCover(index).name)
    for index2 =1:length(Bpp)
        Bpp(index2)
        fprintf(fid,'\r\n Bpp: %.3f ',Bpp(index2));

        %%%% tinh time %%%
        watermark=randi([0 1],1,Bpp(index2)/2); % random watermark theo bpp
        watermark= watermark(:);
        start_time1 = clock();
        [MaxPSNR_Cross, MaxPSNR_Dot, WI_Cross, WI_Dot] = BangChinhThuc(OI,watermark);
        elapsed_time1 = etime(clock(), start_time1);
        
        start_time2 = clock();
        [MaxPSNR_Cross, MaxPSNR_Dot, WI_Cross, WI_Dot] = BangChinhThuc_Time(OI,watermark);
        elapsed_time2 = etime(clock(), start_time2);
        % Ket thuc tinh time
        fprintf(fid,'Bpp: %.3f, %.3f - %.3f - %.3f',Bpp(index2),MaxPSNR_Dot,elapsed_time1,elapsed_time2);
     
    end
    fclose(fid);
end