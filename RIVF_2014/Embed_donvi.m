function [watermarked_image, Uw, Vw] = Embed_donvi(cover,w)
%  Mu cH
% ThapPhan CV
[cA, cH, cV, cD] = dwt2(cover,'haar');
[cA1, cH1, cV1, cD1] = dwt2(cA,'haar');

[Uh Sh Vh] = svd(cH,'econ');
[Uv Sv Vv] = svd(cV,'econ');
[Ud Sd Vd] = svd(cD,'econ');

[Uh1 Sh1 Vh1] = svd(cH1,'econ');
[Uv1 Sv1 Vv1] = svd(cV1,'econ');

[Uw Sw Vw] = svd(w,'econ');

Sh_dia = diag(Sh);
Sv_dia = diag(Sv);
Sd_dia = diag(Sd);

Sh1_dia = diag(Sh1);
Sv1_dia = diag(Sv1);

Sw_dia = diag(Sw);
% NHUNG
%{
% ThapPhan -> Sv Thap Phan;  Mu -> Sh don vi
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    temp = Sh_dia(i) - fix(Sh_dia(i));
    Sh_dia(i) = fix(fix(Sh_dia(i))/10)*10 + Mu + temp;
    Sv_dia(i) = fix(Sv_dia(i)) + ThapPhan;
end

% ThapPhan -> he so Sv ;  Mu -> Sh chuc
for i =1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    
    temp = Sh_dia(i)/10 - fix(Sh_dia(i)/10);
    Sh_dia(i) = ( fix(fix(Sh_dia(i))/100)*10 + Mu + temp)*10;
    
    Sv_dia(i) = ThapPhan*1000;
end

% ThapPhan -> Sv thap phan ;  Mu -> Sh chuc
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    temp = Sh_dia(i)/10 - fix(Sh_dia(i)/10);
    Sh_dia(i) = ( fix(fix(Sh_dia(i))/100)*10 + Mu + temp)*10;
    
    Sv_dia(i) = fix(Sv_dia(i)) + ThapPhan;
end

% ThapPhan -> Sv thap phan;  Mu -> Sh tram
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    [ThapPhan2 Mu2] = ChuyenHeSo(Sh_dia(i));
    Sh_dia(i) = Mu*10^(Mu2-1) + ThapPhan2*10^(Mu2-1)
    
    Sv_dia(i) = fix(Sv_dia(i)) + ThapPhan;
end

% ThapPhan -> Sv1 thap phan; Mu -> Sh1 chuc
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    temp = Sh1_dia(i)/10 - fix(Sh1_dia(i)/10);
    Sh1_dia(i) = ( fix(fix(Sh1_dia(i))/100)*10 + Mu + temp)*10;
    
    Sv1_dia(i) = fix(Sv1_dia(i)) + ThapPhan;
end

% ThapPhan -> Sv1 Thap phan;  Mu -> Sh don vi
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    temp = Sh1_dia(i) - fix(Sh1_dia(i));
    Sh1_dia(i) = fix(fix(Sh1_dia(i))/10)*10 + Mu + temp;
    Sv1_dia(i) = fix(Sv1_dia(i)) + ThapPhan;
end

% ThapPhan -> Sv thap phan;  Mu -> Sd chuc
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    temp = Sd_dia(i)/10 - fix(Sd_dia(i)/10);
    Sd_dia(i) = (fix(fix(Sd_dia(i))/100)*10 + Mu + temp)*10;
    Sv_dia(i) = fix(Sv_dia(i)) + ThapPhan;
end

% ThapPhan -> Sv thap phan;  Mu -> Sd don vi
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    temp = Sd_dia(i) - fix(Sd_dia(i));
    Sd_dia(i) = fix(fix(Sd_dia(i))/10)*10 + Mu + temp;
    Sv_dia(i) = fix(Sv_dia(i)) + ThapPhan;
end

% ThapPhan -> Sv thap phan;  Mu -> Sd tram
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    [ThapPhan2 Mu2] = ChuyenHeSo(Sd_dia(i));
    Sd_dia(i) = Mu*10^(Mu2-1) + ThapPhan2*10^(Mu2-1)
    
    Sv_dia(i) = fix(Sv_dia(i)) + ThapPhan;
end
%}

% ThapPhan -> Sv thap phan;  Mu -> Sd chuc
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    temp = Sd_dia(i)/10 - fix(Sd_dia(i)/10);
    if Sd_dia(i) < 100
        Sd_dia(i)= 100 + temp*10;
    end
    Sd_dia(i) = (fix(fix(Sd_dia(i))/100)*10 + Mu + temp)*10;
    Sv_dia(i) = fix(Sv_dia(i)) + ThapPhan;
end

Sd(logical(eye(size(Sd)))) = Sd_dia;
Sv(logical(eye(size(Sv)))) = Sv_dia;


CD = Ud * Sd * Vd';
CV = Uv * Sv * Vv';

%LL = idwt2(cA1, CH1, CV1, cD1,'haar');
watermarked_image = idwt2(cA, cH, CV, CD,'haar');
end