function [originalImage  data] = sachnev_decoding(embeded_dot_image)
[dot_c,dot_r,dot_uh,dot_u] = dotset(embeded_dot_image); 
[image_dot_decoding,Pload_dot]=decoding(dot_c,dot_r,dot_uh,dot_u,embeded_dot_image);
[cross_c,cross_r,cross_uh,cross_u] = crossset(image_dot_decoding);
[image_cross_decoding,Pload_cross]=decoding(cross_c,cross_r,cross_uh,cross_u,image_dot_decoding);
originalImage=uint8(image_cross_decoding);
data =[Pload_cross;Pload_dot];
data = reshape(data,sqrt(length(data)),sqrt(length(data)));

