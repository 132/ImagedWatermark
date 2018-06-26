function w = extractingS(OI,imin,imax,size)
w =[];
%[H, C] = size(OI);
C = length(OI(1,:));
H = length(OI(:,1));
flag = 0;
if imax > imin
    for h=1:H
        for c=1:C
            if OI(h,c)==imax
                w = [w;0];
            elseif OI(h,c)==imax-1
                w = [w;1];
                OI(h,c)=OI(h,c)+1;
            end
            if length(w)==size
                flag = 1;
                break;
            end
        end
        if flag ==1
            break;
        end
    end
    for h=1:H
        for c=1:C
            if imin<OI(h,c) && OI(h,c)<imax
                OI(h,c) = OI(h,c) + 1;
            end
        end
    end
else
    for h=1:H
        for c=1:C
            if OI(h,c)==imax
                w = [w;0];
            elseif OI(h,c)==imax+1
                w = [w;1];
                OI(h,c)=OI(h,c)-1;
            end
            if length(w)==size
                flag = 1;
                break;
            end
        end
        if flag ==1
            break;
        end
    end
    for h=1:H
        for c=1:C
            if imin>OI(h,c) && OI(h,c)>imax
                OI(h,c) = OI(h,c) - 1;
            end
        end
    end
end
w = vec2mat(w,sqrt(length(w)))';
w = decode_qr(w);

end