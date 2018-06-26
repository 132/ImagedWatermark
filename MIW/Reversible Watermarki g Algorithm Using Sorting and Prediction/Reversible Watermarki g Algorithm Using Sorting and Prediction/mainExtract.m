originalImage = imread('');

watermark=randint(1,round(0.05*numel(I)/2),[0 1]);
T =1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Embedded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[cross_c,cross_r,cross_uh,cross_u] = crossset(originalImage);
[embeded_cross_image,PLcheckcross,last_bit_cross,LC_cross]=embeded(cross_c,cross_r,cross_uh,cross_u,watermark,T,originalImage); % nhung vao Cross

[dot_c,dot_r,dot_uh,dot_u] = dotset(embeded_cross_image);
[embeded_dot_image,PLcheckdot,last_bit_dot,LC_dot]=embeded(dot_c,dot_r,dot_uh,dot_u,watermark,T,embeded_cross_image); % Nhung vao Dot set

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
WI = embeded_dot_image;
[dot_c,dot_r,dot_uh,dot_u] = dotset(WI);
[W_dot,OI_dot] = extracted(WI,last_bit_dot,LC_dot,dot_c,dot_r,dot_uh,dot_u);

[cross_c,cross_r,cross_uh,cross_u] = crossset(originalImage);
[W_cross,OI_cross] = extracted(WI_dot,last_bit_cross,LC_cross,cross_c,cross_r,cross_uh,cross_u);

