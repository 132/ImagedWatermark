function [CD_M,CV_M,CH_M, watermark] = extracting(Denta, m, Check, CD,CV,CH, size_W, KEY, c, r, uh, u, subband)
%[c,r,uh,u] = crossset(WI);
d = u - uh;          size_d = length(d);
DentaAm = 0-Denta;
i = 1;
W = [];
%start = clock;
%e = clock;
while length(W) <= size_W && d(i) <= size_d/m
   % Rut watermark ra truoc
   %if ismember(i,KEY)==0
       if 2*DentaAm < d(i) && d(i) <= DentaAm
           W = [W, 0];
           d(i) = d(i) - DentaAm;
       elseif Denta <= d(i) && d(i) < 2*Denta
           W = [W, 0];
           d(i) = d(i) - Denta;
       elseif DentaAm < d(i) && d(i) < Denta
           W = [W, 1];
       end
       if length(W) == size_W || i > Check
           break;
       end
   %end
   i = i+1;
 %   e = clock;
end
j = 1;
%starts = clock;
%endt = clock;
while j <= size_d/m     % && etime(endt,starts)<20
  %  if ismember(j,KEY)==0
        if d(j) <= 2*DentaAm || d(j) >= 2*Denta
            if d(j) >= 0
                d(j) = d(j) - Denta;
            elseif d(j) <= 0
                d(j) = d(j) - DentaAm;
            end
        end
        j = j+1;
   % else
   %     j = j+1;
   % end
    %endt = clock;
end
%%%%%%%%%%%%%%%%%%% Sua loi %%%%%%%%%%%%%%
while length(W) < size_W
    W = [W, 0];
end

x = W;
W = vec2mat(W,sqrt(size_W))';
watermark = W;
%watermark = decode_qr(watermark);
U = d + uh;
c_CD = [];
r_CD = [];
U_CD = [];

c_CV = [];
r_CV = [];
U_CV = [];

c_CH = [];
r_CH = [];
U_CH = [];

for t = 1:length(d)
    if subband(t) == 1
        c_CD = [c_CD c(t)];
        r_CD = [r_CD r(t)];
        U_CD = [U_CD U(t)];
    elseif subband(t) == 2
        c_CV = [c_CV c(t)];
        r_CV = [r_CV r(t)];
        U_CV = [U_CV U(t)];
    else
        c_CH = [c_CH c(t)];
        r_CH = [r_CH r(t)];
        U_CH = [U_CH U(t)];
    end
end

CD_M = CD;
CV_M = CV;
CH_M = CH;

CD_M((c_CD-1)*size(CD,1)+r_CD)=U_CD;
CV_M((c_CV-1)*size(CV,1)+r_CV)=U_CV;
CH_M((c_CH-1)*size(CH,1)+r_CH)=U_CH;

%OI = WI;
%OI((c-1)*size(OI,1)+r)=U;
end