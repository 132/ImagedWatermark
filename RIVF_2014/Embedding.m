function [watermarked_image, Uw, Vw] = Embedding(cover,w)
%{
%  Mu cH
% ThapPhan CV
[cA, cH, cV, cD] = dwt2(cover,'haar');

[Uh Sh Vh] = svd(cH,'econ');
[Uv Sv Vv] = svd(cV,'econ');
[Uw Sw Vw] = svd(w,'econ');

Sh_dia = diag(Sh);
Sv_dia = diag(Sv);
Sw_dia = diag(Sw);

% NHUNG
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    Sh_dia(i) = fix(Sh_dia(i)) + Mu;
    Sv_dia(i) = fix(Sv_dia(i)) + ThapPhan;
end
Sh(logical(eye(size(Sh)))) = Sh_dia;
Sv(logical(eye(size(Sv)))) = Sv_dia;


CH = Uh * Sh * Vh';
CV = Uv * Sv * Vv';

watermarked_image = idwt2(cA, CH, CV, cD,'haar');
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Mu cA
% ThapPhan CV
[cA, cH, cV, cD] = dwt2(cover,'haar');

[Uh Sh Vh] = svd(cA,'econ');    %%%%%%%%%%%%%%%%%%%
[Uv Sv Vv] = svd(cV,'econ');
[Uw Sw Vw] = svd(w,'econ');

Sh_dia = diag(Sh);
Sv_dia = diag(Sv);
Sw_dia = diag(Sw);

% NHUNG
for i = 1:size(Sw_dia)
    [ThapPhan Mu] = ChuyenHeSo(Sw_dia(i));
    Sh_dia(i) = fix(Sh_dia(i)) + Mu;
    Sv_dia(i) = fix(Sv_dia(i)) + ThapPhan;
end
Sh(logical(eye(size(Sh)))) = Sh_dia;
Sv(logical(eye(size(Sv)))) = Sv_dia;


CA = Uh * Sh * Vh';
CV = Uv * Sv * Vv';

watermarked_image = idwt2(CA, cH, CV, cD,'haar');

end