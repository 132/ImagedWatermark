function [Hostimage,k] = embed_I2(d,uh,s,r,c,tp,tn,ss,Hostimage,LSB)
k1=ceil(length(LSB)/9);
CLSB=0;
k=k1;
while CLSB<length(LSB)
    k=k+1;
    if s(k)<=ss
       if d(k)>tp
          if uh(k)+d(k)+tp<=254
             Hostimage(r(k),c(k))=uh(k)+d(k)+tp+1;
          end
       elseif d(k)>=0
          if uh(k)+2*d(k)<=254
             CLSB=CLSB+1;
             Hostimage(r(k),c(k))=uh(k)+2*d(k)+LSB(CLSB);
          end
       elseif d(k)>=tn
          if uh(k)+2*d(k)>=0
             CLSB=CLSB+1;
             Hostimage(r(k),c(k))=uh(k)+2*d(k)+LSB(CLSB);
          end    
       elseif d(k)<tn
          if uh(k)+d(k)+tn>=0
             Hostimage(r(k),c(k))=uh(k)+d(k)+tn;
          end   
       end
    end
end










