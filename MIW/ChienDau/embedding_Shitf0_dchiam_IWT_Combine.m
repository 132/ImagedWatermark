function [CD_M, CV_M, CH_M, size_W, KEY, j] = embedding(Denta, m, CD, CV, CH, watermark, c, r, uh, u, subband)% c_CV, r_CV, uh_CV, u_CV, c_CH, r_CH, uh_CH, u_CH, subband)
watermark = watermark(:);   size_W = length(watermark);
% u pixel || uh predicted error
d = u - uh;     size_d = length(d); % eij  prediction error
DentaAm = 0-Denta;
w = 1;
i = 1;
%size_d = 10;
KEY = [];
DungLuongShift= 0;
% Shift prediciton error
while i <= size_d/m                       % d/4
    %Check underflow and overflow
        if d(i) >= Denta % && d(i) > 0
           % if DentaAm <= u(i) && u(i) <= 255-Denta
                d(i) = d(i) + Denta;
                DungLuongShift = DungLuongShift + 1;
           % else
           %     KEY = [KEY, i];
           % end
        elseif d(i) <= DentaAm % && d(i) < 0
           % if Denta <= u(i) && u(i) <= 255+Denta
                d(i) = d(i) - Denta;
                DungLuongShift = DungLuongShift + 1;
           % else
           %     KEY = [KEY, i];
           % end
        end
        i = i+1;
end

j = 1;
while w <= size_W && j <= size_d/m
        % EMBEDDING WATERMARK
        if 0 <= d(j) && d(j) < Denta
            %if DentaAm <= u(j) && u(j) <= 255-Denta
                if watermark(w) == 0             % watermark = 0 (unchange)
                     d(j) = d(j) + Denta;
                end
                w = w + 1;
            %else
            %    KEY = [KEY, j];
            %end
        elseif DentaAm < d(j) && d(j) <= 0  
            %if Denta <= u(j) && u(j) <= 255+Denta
                if watermark(w) == 0
                    d(j) = d(j) - Denta;
                end
                w = w + 1;
            %else
            %    KEY = [KEY, j];
            %end
        end        
    j = j+1;
end
if w <= size_W
    check = 'chua nhung het'
end
%WI = OI;
U = d + uh;
%WI((c-1)*size(OI,1)+r)=U;
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

end