function embeded_image = sachnev_encoding(originalImage,data)
originalImage = double(originalImage);
maxT=150;
embeded_image=[];
data_cross = data(1:length(data)/2)';
data_dot = data(length(data)/2+1:end)';
[cross_c,cross_r,cross_uh,cross_u] = crossset(originalImage);
check=0;
    T=1;
    while T<=maxT && check==0
        [embeded_cross_image,PLcheckcross]=embeded(cross_c,cross_r,cross_uh,cross_u,data_cross,T,originalImage);
        if PLcheckcross==1
           [dot_c,dot_r,dot_uh,dot_u] = dotset(embeded_cross_image); 
           [embeded_dot_image,PLcheckdot]=embeded(dot_c,dot_r,dot_uh,dot_u,data_dot,T,embeded_cross_image); 
           if PLcheckdot==1
              check=1;
              MSE_o=inf;
              MSE_n=sum(sum((embeded_dot_image-originalImage).^2))/(numel(originalImage));
              image_n=embeded_dot_image;
              while MSE_n<MSE_o
                    T=T+1;
                    [embeded_cross_image]=embeded(cross_c,cross_r,cross_uh,cross_u,data_cross,T,originalImage);
                    [dot_c,dot_r,dot_uh,dot_u] = dotset(embeded_cross_image); 
                    [embeded_dot_image]=embeded(dot_c,dot_r,dot_uh,dot_u,data_dot,T,embeded_cross_image); 
                    MSE_o=MSE_n;
                    MSE_n=sum(sum((embeded_dot_image-originalImage).^2))/(numel(originalImage));
                    image_o=image_n;   image_n=embeded_dot_image;
              end  
              embeded_dot_image=image_o;
            end
        end
        T=T+1;
    end
    if check==1
       embeded_image=uint8(embeded_dot_image);
    end

