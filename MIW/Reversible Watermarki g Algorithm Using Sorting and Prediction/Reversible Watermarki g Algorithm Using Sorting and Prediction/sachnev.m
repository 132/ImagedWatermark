function TpTnpsnrmap = sachnev(originalImage,bpp)
originalImage = double(originalImage);
maxT=150;
TpTnpsnrmap=ones(length(bpp),5)*NaN;
TpTnpsnrmap(:,1)=bpp;
T=1; 
kb=0;% vi tri bpp
while kb<length(bpp) && T<maxT  % nho hon Tmax va nho hon bpp 
    kb=kb+1;
    disp(['sachnev        ',num2str(bpp(kb),'%1.2f'),' ','bpp'])
    watermark=randint(1,round(bpp(kb)*numel(originalImage)/2),[0 1]); % random watermark theo bpp
    [cross_c,cross_r,cross_uh,cross_u] = crossset(originalImage); % chon Cross va tinh toan Step2
    %c (col) , r (row), uh (u' predicted value), u (pixel in cross)
    check=0;
    T=1;
    while T<=maxT && check==0
        [embeded_cross_image,PLcheckcross,last_bit_cross,LC_cross]=embeded(cross_c,cross_r,cross_uh,cross_u,watermark,T,originalImage); % nhung vao Cross
        if PLcheckcross==1  % Kiem tra nhung dc k
           [dot_c,dot_r,dot_uh,dot_u] = dotset(embeded_cross_image); % Phan ra Dot Set
           [embeded_dot_image,PLcheckdot,last_bit_dot,LC_dot]=embeded(dot_c,dot_r,dot_uh,dot_u,watermark,T,embeded_cross_image); % Nhung vao Dot set
           if PLcheckdot==1 % Kiem tra nhung dc ko
              check=1;
              MSE_o=inf;
              MSE_n=sum(sum((embeded_dot_image-originalImage).^2))/(numel(originalImage));
              image_n=embeded_dot_image;    % watermarked image
              LC_n=LC_cross+LC_dot;         % location Cross va Dot
              while MSE_n<MSE_o % thoa dk roi nhung
                    T=T+1;
                    [embeded_cross_image,PLcheckcross,last_bit_cross,LC_cross]=embeded(cross_c,cross_r,cross_uh,cross_u,watermark,T,originalImage);
                    [dot_c,dot_r,dot_uh,dot_u] = dotset(embeded_cross_image); 
                    [embeded_dot_image,PLcheckdot,last_bit_dot,LC_dot]=embeded(dot_c,dot_r,dot_uh,dot_u,watermark,T,embeded_cross_image); 
                    MSE_o=MSE_n;
                    MSE_n=sum(sum((embeded_dot_image-originalImage).^2))/(numel(originalImage));
                    image_o=image_n;   
                    image_n=embeded_dot_image;
                    LC_o=LC_n;  
                    LC_n=LC_cross+LC_dot;
              end  
              embeded_dot_image=image_o;
            end
        end
        T=T+1;
    end
    if check==1
        Mean2err=sum(sum((embeded_dot_image-originalImage).^2))/(numel(originalImage));
        sdf=255^2./(Mean2err);
        PSNR = 10*log10(sdf); 
        TpTnpsnrmap(kb,2)= PSNR;
        TpTnpsnrmap(kb,3)=-floor((T-2)/2);
        TpTnpsnrmap(kb,4)=ceil((T-2)/2)-1;
        TpTnpsnrmap(kb,5)=LC_o;
    end
end
