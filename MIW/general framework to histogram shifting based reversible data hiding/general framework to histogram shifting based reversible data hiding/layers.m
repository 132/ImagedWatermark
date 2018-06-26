function [c r d s uh u] = layers(originalImage,L)

if L==1
    i_s=2; j_s=2; 
elseif L==2
    i_s=2; j_s=3; 
elseif L==3   
    i_s=2; j_s=4;
elseif L==4
    i_s=3; j_s=2; 
elseif L==5
    i_s=3; j_s=3; 
elseif L==6   
    i_s=3; j_s=4; 
elseif L==7
    i_s=4; j_s=2; 
elseif L==8
    i_s=4; j_s=3; 
elseif L==9
    i_s=4; j_s=4; 
end

[N,M] = size(originalImage);
A1=originalImage(i_s-1:3:N-2,j_s-1:3:M-2);
A2=originalImage(i_s-1:3:N-2,j_s:3:M-1);
A3=originalImage(i_s-1:3:N-2,j_s+1:3:M);
A4=originalImage(i_s:3:N-1,j_s-1:3:M-2);
 u=originalImage(i_s:3:N-1,j_s:3:M-1);
A6=originalImage(i_s:3:N-1,j_s+1:3:M);
A7=originalImage(i_s+1:3:N,j_s-1:3:M-2);
A8=originalImage(i_s+1:3:N,j_s:3:M-1);
A9=originalImage(i_s+1:3:N,j_s+1:3:M);
A1=A1(:);A2=A2(:);A3=A3(:);A4=A4(:);u=u(:);A6=A6(:);A7=A7(:);A8=A8(:);A9=A9(:);

[c,r]=meshgrid(j_s:3:M-1,i_s:3:N-1);
c=c(:);
r=r(:);
w=[3 1]/16;
uh=ceil(w(2)*(A1+A3+A7+A9)+w(1)*(A2+A4+A6+A8));
d=u-uh;
s=max([A1 A2 A3 A4 A6 A7 A8 A9],'',2)-min([A1 A2 A3 A4 A6 A7 A8 A9],'',2);
