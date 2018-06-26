% Hang Chinh Thuc
function [MaxPSNR_Cross, MaxPSNR_Dot, WI_Cross, WI_Dot] = BangChinhThuc(OI,watermark)
%OI = imread('DataDacBiet\lena.bmp');
%watermark=randi([0 1],1,20000/2); % random watermark theo bpp
%watermark= watermark(:);
Denta = 1;
m = 1;
watermark_Cross = watermark;
watermark_Dot = watermark;

watermark_Cross = watermark;
watermark_Dot = watermark;
Sum1_Cross = sum(watermark_Cross(:));
Sum0_Cross = length(watermark_Cross(:)) - Sum1_Cross;
Sum1_Dot = sum(watermark_Dot(:));
Sum0_Dot = length(watermark_Dot(:)) - Sum1_Dot;

[c_Cross,r_Cross,uh_Cross,u_Cross] = crossset(OI);
[PhanLoai] = bin_PhanLoai(c_Cross,r_Cross,uh_Cross,u_C44iross, watermark);
%PhanLoai

% kiem tra su khac biet cua 1 threshold va 2 threshold
switch PhanLoai(1)
    case 0
        disp('Qua gioi han Cross')
    %{    
    case 1
        disp('1.1 Threshold values - Cross')
        [Bin_Cross Histogram_Cross] = bin_CaiTien_1T(c_Cross,r_Cross,uh_Cross,u_Cross,watermark_Cross);
        MaxPSNR_Cross = 0;
        for i = 1:length(Bin_Cross)
            Bin_Cross_Temp = Bin_Cross(1,i);
            Gap_Cross_Temp = Bin_Cross(2,i);
            [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp] = embedding_1T(Denta, m, Bin_Cross_Temp, Gap_Cross_Temp, OI ,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
            if PSNR(WI_Cross_Temp,OI) > MaxPSNR_Cross
                MaxPSNR_Cross = PSNR(WI_Cross_Temp,OI);
                WI_Cross = WI_Cross_Temp;
                KEY_Cross = KEY_Cross_Temp;
                Check_Cross = Check_Cross_Temp;
                Bin_Cross_Max= Bin_Cross_Temp;
                Gap_Cross_Max = Gap_Cross_Temp;
            end
        end
        disp(Bin_Cross_Max);
      %}  
    case {1,2}
     %   disp('2.1 Threshold values - Cross') 
        disp(PhanLoai(2))
        [BinAmCross BinDuongCross, GapAm_Cross GapDuong_Cross Histogram_Cross] = bin_CaiTien_2T(c_Cross,r_Cross,uh_Cross,u_Cross,watermark_Cross);
        MaxPSNR_Cross = 0;
        for i = 1:length(BinAmCross)
            BinAm_Cross_Temp = BinAmCross(i);
            BinDuong_Cross_Temp = BinDuongCross(i);
            if Sum0_Cross > Sum1_Cross
                [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp] = embedding_2T(Denta, m, BinAm_Cross_Temp, BinDuong_Cross_Temp, GapAm_Cross, GapDuong_Cross, OI ,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
            else
                [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp] = embedding_2T_shift0(Denta, m, BinAm_Cross_Temp, BinDuong_Cross_Temp, GapAm_Cross, GapDuong_Cross, OI ,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
            end
            if PSNR(WI_Cross_Temp,OI) > MaxPSNR_Cross
                MaxPSNR_Cross = PSNR(WI_Cross_Temp,OI);
                WI_Cross = WI_Cross_Temp;
                KEY_Cross = KEY_Cross_Temp;
                Check_Cross = Check_Cross_Temp;
                BinAm_Cross = BinAm_Cross_Temp;
                BinDuong_Cross = BinDuong_Cross_Temp;
            end
        end
       % disp(BinAm_Cross);
       % disp(BinDuong_Cross);
        
    case 3      % chu trong Am va Duong la gan bin0 nhat tranh truong hop Am_Duong =0
     %   disp('3.1 Threshold values - Cross') 
        disp(PhanLoai(2))
        [Am2_Duong1_Cross Duong2_Am1_Cross Histogram_Cross] = bin_CaiTien_3T(c_Cross,r_Cross,uh_Cross,u_Cross,watermark_Cross);
        Am_AmDuong_Duong = [Am2_Duong1_Cross, Duong2_Am1_Cross];
        MaxPSNR_Cross = 0;
        for i = 1:length(Am_AmDuong_Duong(1,:))
            Am_Temp = Am_AmDuong_Duong(1,i);
            Am_Duong_Temp = Am_AmDuong_Duong(2,i);
            Duong_Temp = Am_AmDuong_Duong(3,i);
            if Sum0_Cross > Sum0_Cross
                [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp k] = embedding_3T(Denta, m, Am_Temp, Am_Duong_Temp, Duong_Temp, OI, watermark_Cross, c_Cross, r_Cross, uh_Cross, u_Cross);
            else
                [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp k] = embedding_3T_shift0(Denta, m, Am_Temp, Am_Duong_Temp, Duong_Temp, OI, watermark_Cross, c_Cross, r_Cross, uh_Cross, u_Cross);
            end
            if PSNR(WI_Cross_Temp,OI) > MaxPSNR_Cross
                MaxPSNR_Cross = PSNR(WI_Cross_Temp,OI);
                WI_Cross = WI_Cross_Temp;
                KEY_Cross = KEY_Cross_Temp;
                Check_Cross = Check_Cross_Temp;
                Am_Cross = Am_Temp;
                Am_Duong_Cross = Am_Duong_Temp;
                Duong_Cross = Duong_Temp;
            end
        end
      %  disp(Am_Cross);
      %  disp(Am_Duong_Cross);
      %  disp(Duong_Cross);
        
    case 4
      %  disp('4.1 Threshold values - Cross') 
        disp(PhanLoai(2))
        [Am2_Duong2 Histogram_Cross] = bin_CaiTien_4T(c_Cross,r_Cross,uh_Cross,u_Cross,watermark_Cross);
        MaxPSNR_Cross = 0;
        for i = 1:length(Am2_Duong2(1,:))            
            Am1_Temp = Am2_Duong2(1,i);
            Am2_Temp = Am2_Duong2(2,i);
            Duong1_Temp = Am2_Duong2(3,i);
            Duong2_Temp = Am2_Duong2(4,i);
            if Sum0_Cross > Sum1_Cross
                [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp] = embedding_4T(Denta, m, Am1_Temp, Am2_Temp, Duong1_Temp, Duong2_Temp, OI ,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
            else
                [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp] = embedding_4T_shift0(Denta, m, Am1_Temp, Am2_Temp, Duong1_Temp, Duong2_Temp, OI ,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
            end
            if PSNR(WI_Cross_Temp,OI) > MaxPSNR_Cross
                MaxPSNR_Cross = PSNR(WI_Cross_Temp,OI);
                WI_Cross = WI_Cross_Temp;
                KEY_Cross = KEY_Cross_Temp;
                Check_Cross = Check_Cross_Temp;
                Am1 = Am1_Temp;
                Am2 = Am2_Temp;
                Duong1 = Duong1_Temp;
                Duong2 = Duong2_Temp;
            end
        end
     %   disp(Am1);
     %   disp(Am2);
     %   disp(Duong1);
     %   disp(Duong2);
    case 6
      %  disp('4.1 Threshold values - Cross') 
        disp(PhanLoai(2))
        [Am3_Duong3 Histogram_Cross] = bin_CaiTien_6T(c_Cross,r_Cross,uh_Cross,u_Cross,watermark_Cross);
        MaxPSNR_Cross = 0;
        for i = 1:length(Am3_Duong3(1,:))            
            Am1_Temp = Am3_Duong3(1,i);
            Am2_Temp = Am3_Duong3(2,i);
            Am3_Temp = Am3_Duong3(3,i);
            Duong1_Temp = Am3_Duong3(4,i);
            Duong2_Temp = Am3_Duong3(5,i);
            Duong3_Temp = Am3_Duong3(6,i);
            if Sum0_Cross > Sum1_Cross
                [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp] = embedding_6T(Denta, m, Am1_Temp, Am2_Temp, Am3_Temp, Duong1_Temp, Duong2_Temp, Duong3_Temp, OI ,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
            else
                [WI_Cross_Temp size_W_Cross KEY_Cross_Temp Check_Cross_Temp] = embedding_6T_shift0(Denta, m, Am1_Temp, Am2_Temp, Am3_Temp, Duong1_Temp, Duong2_Temp, Duong3_Temp, OI ,watermark_Cross,c_Cross,r_Cross,uh_Cross,u_Cross);
            end
            if PSNR(WI_Cross_Temp,OI) > MaxPSNR_Cross
                MaxPSNR_Cross = PSNR(WI_Cross_Temp,OI);
                WI_Cross = WI_Cross_Temp;
                KEY_Cross = KEY_Cross_Temp;
                Check_Cross = Check_Cross_Temp;
                Am1 = Am1_Temp;
                Am2 = Am2_Temp;
                Am3 = Am3_Temp;
                Duong1 = Duong1_Temp;
                Duong2 = Duong2_Temp;
                Duong3 = Duong3_Temp;
            end
        end
end

%=======================================================================
%                                 DOt set
%=======================================================================
[c_Dot,r_Dot,uh_Dot,u_Dot] = dotset(WI_Cross);
[PhanLoai_Dot] = bin_PhanLoai(c_Dot,r_Dot,uh_Dot,u_Dot, watermark_Dot);
switch PhanLoai_Dot(1)
    case 0
        disp('Qua gioi han Dot')
        %{
    case 1
        disp('1.2 Threshold values - Dot')
        [Bin_Dot Histogram_Dot] = bin_CaiTien_1T(c_Dot,r_Dot,uh_Dot,u_Dot,watermark_Dot);
        MaxPSNR_Dot = 0;
        for i = 1:length(Bin_Dot)
            Bin_Dot_Temp = Bin_Dot(1,i);
            Gap_Dot_Temp = Bin_Dot(2,i);
            [WI_Dot_Temp size_W_Dot KEY_Dot_Temp Check_Dot_Temp] = embedding_1T(Denta, m, Bin_Dot_Temp, Gap_Dot_Temp, WI_Cross ,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
            if PSNR(WI_Dot_Temp,OI) > MaxPSNR_Dot
                MaxPSNR_Dot = PSNR(WI_Dot_Temp,OI);
                WI_Dot = WI_Dot_Temp;
                KEY_Dot = KEY_Dot_Temp;
                Check_Dot = Check_Dot_Temp;
                Bin_Dot_Max = Bin_Dot_Temp;
                Gap_Dot_Max = Gap_Dot_Temp;
            end
        end
        disp(Bin_Dot_Max);
        %}
    case {1,2}
      %  disp('2.2 Threshold values - Dot')  
        disp(PhanLoai_Dot(2))
        [BinAmDot BinDuongDot, GapAm_Dot GapDuong_Dot Histogram_Dot] = bin_CaiTien_2T(c_Dot,r_Dot,uh_Dot,u_Dot,watermark_Dot);
        MaxPSNR_Dot = 0;
        for i = 1:length(BinAmDot)
            BinAm_Dot_Temp = BinAmDot(i);
            BinDuong_Dot_Temp = BinDuongDot(i);
            if Sum0_Dot > Sum1_Dot
                [WI_Dot_Temp size_W_Dot KEY_Dot_Temp Check_Dot_Temp] = embedding_2T(Denta, m, BinAm_Dot_Temp, BinDuong_Dot_Temp, GapAm_Dot, GapDuong_Dot, WI_Cross ,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
            else
                [WI_Dot_Temp size_W_Dot KEY_Dot_Temp Check_Dot_Temp] = embedding_2T_shift0(Denta, m, BinAm_Dot_Temp, BinDuong_Dot_Temp, GapAm_Dot, GapDuong_Dot, WI_Cross ,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
            end
            if PSNR(WI_Dot_Temp,OI) > MaxPSNR_Dot
                MaxPSNR_Dot = PSNR(WI_Dot_Temp,OI);
                WI_Dot = WI_Dot_Temp;
                KEY_Dot = KEY_Dot_Temp;
                Check_Dot = Check_Dot_Temp;
                BinAm_Dot = BinAm_Dot_Temp;
                BinDuong_Dot = BinDuong_Dot_Temp;
            end
        end
        disp(BinAm_Dot);
        disp(BinDuong_Dot);
    case 3      % chu trong Am va Duong la gan bin0 nhat tranh truong hop Am_Duong =0
      %  disp('3.2 Threshold values - Dot') 
        disp(PhanLoai_Dot(2))
        [Am2_Duong1_Dot Duong2_Am1_Dot Histogram_Dot] = bin_CaiTien_3T(c_Dot,r_Dot,uh_Dot,u_Dot,watermark_Dot);
        Am_AmDuong_Duong_2 = [Am2_Duong1_Dot, Duong2_Am1_Dot];
        MaxPSNR_Dot = 0;
        for i = 1:length(Am_AmDuong_Duong_2(1,:))
            Am_Temp = Am_AmDuong_Duong_2(1,i);
            Am_Duong_Temp = Am_AmDuong_Duong_2(2,i);
            Duong_Temp = Am_AmDuong_Duong_2(3,i);
            if Sum0_Dot > Sum1_Dot
                [WI_Dot_Temp size_W_Dot KEY_Dot_Temp Check_Dot_Temp k] = embedding_3T(Denta, m, Am_Temp, Am_Duong_Temp, Duong_Temp, WI_Cross, watermark_Dot, c_Dot,r_Dot,uh_Dot,u_Dot);
            else
                [WI_Dot_Temp size_W_Dot KEY_Dot_Temp Check_Dot_Temp k] = embedding_3T_shift0(Denta, m, Am_Temp, Am_Duong_Temp, Duong_Temp, WI_Cross, watermark_Dot, c_Dot,r_Dot,uh_Dot,u_Dot);
            end
            if PSNR(WI_Dot_Temp,OI) > MaxPSNR_Dot
                MaxPSNR_Dot = PSNR(WI_Dot_Temp,OI);
                WI_Dot = WI_Dot_Temp;
                KEY_Dot = KEY_Dot_Temp;
                Check_Dot = Check_Dot_Temp;
                Am_Dot = Am_Temp;
                Am_Duong_Dot = Am_Duong_Temp;
                Duong_Dot = Duong_Temp;
            end
        end
      %  disp(Am_Dot);
      %  disp(Am_Duong_Dot);
      %  disp(Duong_Dot);
        
    case 4
      %  disp('4.2 Threshold values - Dot') 
        disp(PhanLoai_Dot(2))
        [Am2_Duong2 Histogram_Dot] = bin_CaiTien_4T(c_Dot,r_Dot,uh_Dot,u_Dot,watermark_Dot);
        MaxPSNR_Dot = 0;
        for i = 1:length(Am2_Duong2(1,:))            
            Am1_Temp = Am2_Duong2(1,i);
            Am2_Temp = Am2_Duong2(2,i);
            Duong1_Temp = Am2_Duong2(3,i);
            Duong2_Temp = Am2_Duong2(4,i);
            if Sum0_Dot > Sum1_Dot
                [WI_Dot_Temp size_W_Dot KEY_Dot_Temp Check_Dot_Temp] = embedding_4T(Denta, m, Am1_Temp, Am2_Temp, Duong1_Temp, Duong2_Temp, WI_Cross ,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
            else
                [WI_Dot_Temp size_W_Dot KEY_Dot_Temp Check_Dot_Temp] = embedding_4T_shift0(Denta, m, Am1_Temp, Am2_Temp, Duong1_Temp, Duong2_Temp, WI_Cross ,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
            end
            if PSNR(WI_Dot_Temp,OI) > MaxPSNR_Dot
                MaxPSNR_Dot = PSNR(WI_Dot_Temp,OI);
                
                WI_Dot = WI_Dot_Temp;
                KEY_Dot = KEY_Dot_Temp;
                Check_Dot = Check_Dot_Temp;
                Am1_Dot = Am1_Temp;
                Am2_Dot = Am2_Temp;
                Duong1_Dot = Duong1_Temp;
                Duong2_Dot = Duong2_Temp;
            end
        end
    case 6
      %  disp('4.1 Threshold values - Dot') 
        disp(PhanLoai(2))
        [Am3_Duong3 Histogram_Dot] = bin_CaiTien_6T(c_Dot,r_Dot,uh_Dot,u_Dot,watermark_Dot);
        MaxPSNR_Dot = 0;
        for i = 1:length(Am3_Duong3(1,:))            
            Am1_Temp = Am3_Duong3(1,i);
            Am2_Temp = Am3_Duong3(2,i);
            Am3_Temp = Am3_Duong3(3,i);
            Duong1_Temp = Am3_Duong3(4,i);
            Duong2_Temp = Am3_Duong3(5,i);
            Duong3_Temp = Am3_Duong3(6,i);
            if Sum0_Dot > Sum1_Dot
                [WI_Dot_Temp size_W_Dot KEY_Dot_Temp Check_Dot_Temp] = embedding_6T(Denta, m, Am1_Temp, Am2_Temp, Am3_Temp, Duong1_Temp, Duong2_Temp, Duong3_Temp, OI ,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
            else
                [WI_Dot_Temp size_W_Dot KEY_Dot_Temp Check_Dot_Temp] = embedding_6T_shift0(Denta, m, Am1_Temp, Am2_Temp, Am3_Temp, Duong1_Temp, Duong2_Temp, Duong3_Temp, OI ,watermark_Dot,c_Dot,r_Dot,uh_Dot,u_Dot);
            end
            if PSNR(WI_Dot_Temp,OI) > MaxPSNR_Dot
                MaxPSNR_Dot = PSNR(WI_Dot_Temp,OI);
                WI_Dot = WI_Dot_Temp;
                KEY_Dot = KEY_Dot_Temp;
                Check_Dot = Check_Dot_Temp;
                Am1 = Am1_Temp;
                Am2 = Am2_Temp;
                Am3 = Am3_Temp;
                Duong1 = Duong1_Temp;
                Duong2 = Duong2_Temp;
                Duong3 = Duong3_Temp;
            end
        end
end

end