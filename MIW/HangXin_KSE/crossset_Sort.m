function [c,r,uh,u] = crossset(originalImage)
% output da dc sort theo local variance
originalImage = double(originalImage);
[N,M] = size(originalImage);% kich thuoc cua original image
A1=originalImage(1:2:N-3,2:2:M-2); % Chon cac Cross
A2=originalImage(2:2:N-2,3:2:M-1);
B1=originalImage(3:2:N-1,2:2:M-2);
B2=originalImage(4:2:N,3:2:M-1);
C1=originalImage(2:2:N-2,1:2:M-3);
C2=originalImage(3:2:N-1,2:2:M-2);
D1=originalImage(2:2:N-2,3:2:M-1);
D2=originalImage(3:2:N-1,4:2:M);

A=[A1(:);A2(:)];    % Cac pixel in Dot neighbor xung quan,h
B=[B1(:);B2(:)];
C=[C1(:);C2(:)];
D=[D1(:);D2(:)];
uh=floor((A+B+C+D)/4); %    predicted value
mu=var([abs(A-C) abs(A-D) abs(B-D) abs(B-C)], 0, 2);% local variance


u1=originalImage(2:2:N-2,2:2:M-2);
u2=originalImage(3:2:N-1,3:2:M-1);
u=[u1(:);u2(:)];    % Pixel in Cross


[c1,r1]=meshgrid(2:2:M-2,2:2:N-2); % Cac so chan tang 2 theo cot va dong (col va row)
[c2,r2]=meshgrid(3:2:M-1,3:2:N-1); % cac so le tang 2 theo cot va dong
c=[c1(:);c2(:)]; 
r=[r1(:);r2(:)];


[nn,IX]=sort(mu);% Sort theo local variance(mu)
c=c(IX);         % nn la gia tri da dc sort
r=r(IX);         % IX la index dc sap xep lai
uh=uh(IX);
u=u(IX);

%http://www.mathworks.com/help/matlab/ref/sort.html#bup2pxc
%https://nf.nci.org.au/facilities/software/Matlab/techdoc/ref/meshgrid.html




