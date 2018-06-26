function [watermark_extracted] = Extract_donvi(watermarked_image, Uw, Vw)

[cA, cH, cV, cD] = dwt2(watermarked_image,'haar');
[cA1, cH1, cV1, cD1] = dwt2(cA,'haar');

[Uh Sh Vh] = svd(cH,'econ');
[Uv Sv Vv] = svd(cV,'econ');
[Ud Sd Vd] = svd(cD,'econ');


[Uh1 Sh1 Vh1] = svd(cH1,'econ');
[Uv1 Sv1 Vv1] = svd(cV1,'econ');

Sh_dia = diag(Sh);
Sv_dia = diag(Sv);
Sd_dia = diag(Sd);

Sh1_dia = diag(Sh1);
Sv1_dia = diag(Sv1);

[doc ngang] = size(Uw);
Sw = zeros(doc);
Sw_dia = diag(Sw);
%{
% ThapPhan -> Sv Thap Phan;  Mu -> Sh don vi
for i = 1:doc
    
    Mu = fix(Sh_dia(i)) - fix(fix(Sh_dia(i))/10)*10;
    
    ThapPhan = Sv_dia(i) - fix(Sv_dia(i));
    
    if ThapPhan > 0.9999
        ThapPhan = 0;
    end
    Sw_dia(i) = ThapPhan * 10^(Mu);
    
end

% ThapPhan -> he so Sv ;  Mu -> Sh chuc
for i=1:doc
    [Mu X] = ChuyenHeSo(Sh_dia(i));
    Mu = fix((Mu*10 - fix(Mu*10))*10);
    ThapPhan = Sv_dia(i)/1000;
    
    Sw_dia(i) = ThapPhan * 10^(Mu);
end

% ThapPhan -> Sv thap phan ;  Mu -> Sh chuc
for i = 1:doc
    [Mu X] = ChuyenHeSo(Sh_dia(i));
    Mu = fix((Mu*10 - fix(Mu*10))*10);
    
    ThapPhan = Sv_dia(i) - fix(Sv_dia(i));
    
    if ThapPhan > 0.9999
        ThapPhan = 0;
    end
    Sw_dia(i) = ThapPhan * 10^(Mu);
end

% ThapPhan -> Sv thap phan;  Mu -> Sh tram
for i = 1:doc
    [Mu X] = ChuyenHeSo(Sh_dia(i));
    Mu = fix(Mu*10);
    
    if Sh_dia(i) <100
        Mu = 0;
    end
    
    ThapPhan = Sv_dia(i) - fix(Sv_dia(i));
    
    if ThapPhan > 0.9999
        ThapPhan = 0;
    end
    Sw_dia(i) = ThapPhan * 10^(Mu);
end

% ThapPhan -> Sv1 thap phan; Mu -> Sh1 chuc
for i = 1:doc
    [Mu X] = ChuyenHeSo(Sh1_dia(i));
    Mu = fix((Mu*10 - fix(Mu*10))*10);
    
    ThapPhan = Sv1_dia(i) - fix(Sv1_dia(i));
    
    if ThapPhan > 0.9999
        ThapPhan = 0;
    end
    Sw_dia(i) = ThapPhan * 10^(Mu);
end

% ThapPhan -> Sv1 Thap phan;  Mu -> Sh don vi
for i = 1:doc
    
    Mu = fix(Sh1_dia(i)) - fix(fix(Sh1_dia(i))/10)*10;
    
    ThapPhan = Sv1_dia(i) - fix(Sv1_dia(i));
    
    if ThapPhan > 0.9999
        ThapPhan = 0;
    end
    Sw_dia(i) = ThapPhan * 10^(Mu);
    
end

% ThapPhan -> Sv thap phan;  Mu -> Sd tram
for i = 1:doc
    [Mu X] = ChuyenHeSo(Sd_dia(i));
    Mu = fix(Mu*10);
    if Sd_dia(i) <100 & Sd_dia > 9
        Mu = 0;
    end
    
    ThapPhan = Sv_dia(i) - fix(Sv_dia(i));
    
    if ThapPhan > 0.9999
        ThapPhan = 0;
    end
    Sw_dia(i) = ThapPhan * 10^(Mu);
end

% ThapPhan -> Sv thap phan;  Mu -> Sd don vi
for i = 1:doc
    Mu = fix(Sd_dia(i)) - fix(fix(Sd_dia(i))/10)*10;
    ThapPhan = Sv_dia(i) - fix(Sv_dia(i));
    if ThapPhan > 0.9999
        ThapPhan = 0;
    end
    Sw_dia(i) = ThapPhan * 10^(Mu);
end
%}

% ThapPhan -> Sv thap phan;  Mu -> Sd chuc
for i = 1:doc
    [Mu X] = ChuyenHeSo(Sd_dia(i));
    Mu = fix((Mu*10 - fix(Mu*10))*10);
    ThapPhan = Sv_dia(i) - fix(Sv_dia(i));
    if ThapPhan > 0.9999
        ThapPhan = 0;
    end
    Sw_dia(i) = ThapPhan * 10^(Mu);
end

Sw(logical(eye(size(Uw)))) = Sw_dia;

watermark_extracted = Uw * Sw * Vw';
end