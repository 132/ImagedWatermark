function map = creating_map(d,uh,tp,tn,CM)
K=length(d); 
kh=ceil(log2(K+1));
map=[];
if CM~=0
    map=zeros(1,CM*kh);
    i=0;
    for k=1:K
        if d(k)>tp
            if uh(k)+d(k)+tp>254
                i=i+1;
                map((i-1)*kh+1:i*kh)=dec2binvec(k,kh);
            end
         elseif d(k)>=0
            if uh(k)+2*d(k)<=254
            else
                i=i+1;
                map((i-1)*kh+1:i*kh)=dec2binvec(k,kh);
            end
        elseif d(k)>=tn
            if uh(k)+2*d(k)>=0
            else
                i=i+1;
                map((i-1)*kh+1:i*kh)=dec2binvec(k,kh);
            end    
        elseif d(k)<tn
            if uh(k)+d(k)+tn<0
                i=i+1;
                map((i-1)*kh+1:i*kh)=dec2binvec(k,kh);
            end   
        end
    end
end
map=[dec2binvec(CM,kh) map];
 