TapCover = dir('AnhYKhoa\*.bmp');
%Bpp = [264 2622 5244 7886 10000 20000 30000 40000 50000]; % 130000 140000];
%Bpp = [500 2000 5000 7000 10000 20000 30000 40000 50000];
Bpp = [110000 100000 90000 80000 70000 60000 50000 40000 30000];
matlabpool(3)
parfor index = 1:length(TapCover)
    fid = fopen(strcat(TapCover(index).name,'_AnhYKhoa.txt')','w');
    OI = imread(strcat('AnhYKhoa\',TapCover(index).name));
    A = strcat('AnhYKhoa\',TapCover(index).name)
    for index2 =1:length(Bpp)
        Bpp(index2)
      %  fprintf(fid,'\r\n Bpp: %.3f ',Bpp(index2));
       % MAX_MAX = 0; 
        %for t = 1:10
        %    t
            watermark=randi([0 1],1,Bpp(index2)/2); % random watermark theo bpp
            watermark= watermark(:);
            start_time1 = clock();
            [MaxPSNR_Cross, MaxPSNR_Dot, WI_Cross, WI_Dot, T_Cross, T_Dot, ABCD] = MAIN_TuDONG(OI,watermark);
            elapsed_time1 = etime(clock(), start_time1);
            
           % start_time2 = clock();
           % [MaxPSNR_Cross, MaxPSNR_Dot, WI_Cross, WI_Dot] = MAIN_TuDONG_Hwang(OI,watermark);
           % elapsed_time2 = etime(clock(), start_time2);
        fprintf(fid,'\r\n Bpp: %.3f, %.3f -- Time: %.3f, %.3f',Bpp(index2),MaxPSNR_Dot,elapsed_time1, length(ABCD(1,:)));
    end
    fclose(fid);
end
matlabpool close