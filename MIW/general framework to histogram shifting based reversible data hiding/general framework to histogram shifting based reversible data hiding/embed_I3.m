function [Hostimage] = embed_I3(d,uh,s,r,c,tp,tn,ss,Pload,Hostimage,CPL,k2)
k=k2;
NL=length(Pload);
while CPL<NL
    k=k+1;
    if s(k)<=ss
       if d(k)>tp
          if uh(k)+d(k)+tp<=254
             Hostimage(r(k),c(k))=uh(k)+d(k)+tp+1;
          end
       elseif d(k)>=0
          if uh(k)+2*d(k)<=254
             CPL=CPL+1;
             Hostimage(r(k),c(k))=uh(k)+2*d(k)+Pload(CPL);
          end
       elseif d(k)>=tn
          if uh(k)+2*d(k)>=0
             CPL=CPL+1;
             Hostimage(r(k),c(k))=uh(k)+2*d(k)+Pload(CPL);
          end    
       elseif d(k)<tn
          if uh(k)+d(k)+tn>=0
             Hostimage(r(k),c(k))=uh(k)+d(k)+tn;
          end   
       end
    end
end










