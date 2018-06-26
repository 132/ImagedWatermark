function [watermark_extracted] = Extracting(watermarked_image, Uw, Vw)
%{
[cA, cH, cV, cD] = dwt2(watermarked_image,'haar');

[Uh Sh Vh] = svd(cH,'econ');
[Uv Sv Vv] = svd(cV,'econ');

Sh_dia = diag(Sh);
Sv_dia = diag(Sv);

[doc ngang] = size(Uw);
Sw = zeros(doc);
Sw_dia = diag(Sw);

for i = 1:doc
    Mu = Sh_dia(i) - fix(Sh_dia(i));
    ThapPhan = Sv_dia(i) - fix(Sv_dia(i));
    Sw_dia(i) = ThapPhan * 10^(Mu*10);
end
Sw(logical(eye(size(Uw)))) = Sw_dia;

watermark_extracted = Uw * Sw * Vw';
%}
[cA, cH, cV, cD] = dwt2(watermarked_image,'haar');

[Uh Sh Vh] = svd(cA,'econ');
[Uv Sv Vv] = svd(cV,'econ');

Sh_dia = diag(Sh);
Sv_dia = diag(Sv);

[doc ngang] = size(Uw);
Sw = zeros(doc);
Sw_dia = diag(Sw);

for i = 1:doc
    Mu = Sh_dia(i) - fix(Sh_dia(i));
    ThapPhan = Sv_dia(i) - fix(Sv_dia(i));
    Sw_dia(i) = ThapPhan * 10^(Mu*10);
end
Sw(logical(eye(size(Uw)))) = Sw_dia;

watermark_extracted = Uw * Sw * Vw';
end