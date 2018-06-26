function [c,r,uh,u] = dotset(av_cross_image)

av_cross_image = double(av_cross_image);
[N,M] = size(av_cross_image);
A1=av_cross_image(1:2:N-3,3:2:M-1);
A2=av_cross_image(2:2:N-2,2:2:M-2);
B1=av_cross_image(3:2:N-1,3:2:M-1);
B2=av_cross_image(4:2:N,2:2:M-2);
C1=av_cross_image(2:2:N-2,2:2:M-2);
C2=av_cross_image(3:2:N-1,1:2:M-3);
D1=av_cross_image(2:2:N-2,4:2:M);
D2=av_cross_image(3:2:N-1,3:2:M-1);

A=[A1(:);A2(:)];
B=[B1(:);B2(:)];
C=[C1(:);C2(:)];
D=[D1(:);D2(:)];
uh=floor((A+B+C+D)/4); % predicted error
mu=var([abs(A-C) abs(A-D) abs(B-D) abs(B-C)], 0, 2);% local variance

u1=av_cross_image(2:2:N-2,3:2:M-1);
u2=av_cross_image(3:2:N-1,2:2:M-2);
u=[u1(:);u2(:)];

[c1,r1]=meshgrid(3:2:M-1,2:2:N-2);
[c2,r2]=meshgrid(2:2:M-2,3:2:N-1);
c=[c1(:);c2(:)];
r=[r1(:);r2(:)];

[nn,IX]=sort(mu);% sort theo variance (mu)

c=c(IX);
r=r(IX);
uh=uh(IX);
u=u(IX);
