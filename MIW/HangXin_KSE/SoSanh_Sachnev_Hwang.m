TapCover = dir('Sosanh_Sachnev_Hwang\*.bmp');
Bpp = [50000 60000 70000 80000]; % 130000 140000];
parfor index = 1:length(TapCover)
    fid = fopen(strcat(TapCover(index).name,'_PSNR_SH1.txt')','w');
    OI = imread(strcat('Sosanh_Sachnev_Hwang\',TapCover(index).name));
    A = strcat('Sosanh_Sachnev_Hwang\',TapCover(index).name)
    for index2 =1:length(Bpp)
        Bpp(index2)
        fprintf(fid,'\r\n Bpp: %.3f ',Bpp(index2));
        MAX_MAX = 0; 
       % for t = 1:100 
       %     t
            watermark=randi([0 1],1,Bpp(index2)/2); % random watermark theo bpp
            watermark= watermark(:);
            [MaxPSNR_Cross, MaxPSNR_Dot, WI_Cross, WI_Dot] = MAIN_TuDONG(OI,watermark);
      %      if MaxPSNR_Dot > MAX_MAX
      %          MAX_MAX = MaxPSNR_Dot;
      %      end
      %  end
        fprintf(fid,'Bpp: %.3f - %.3f',Bpp(index2),MaxPSNR_Dot);
    end
    fclose(fid);
end