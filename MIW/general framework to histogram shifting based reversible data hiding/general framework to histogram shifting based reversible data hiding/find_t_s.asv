function [Ch_t,ss,CM] = find_t_s(d,uh,s,tp,tn,NL)
CE=0;
CM=0;
K=length(d);            
for k=1:K
    if d(k)>tp
       if uh(k)+d(k)+tp>254
          CM=CM+1;
        end
    elseif d(k)>=0
       if uh(k)+2*d(k)<=254
          CE=CE+1;
       else
          CM=CM+1;
       end
    elseif d(k)>=tn
       if uh(k)+2*d(k)>=0
          CE=CE+1;
       else
          CM=CM+1;
       end    
    elseif d(k)<tn
       if uh(k)+d(k)+tn<0
          CM=CM+1;
       end   
    end
 end
 ss=255;
 if CE>=(CM+1)*ceil(log2(K+1))+8+8+20+NL;
    while CE>=(CM+1)*ceil(log2(K+1))+8+8+20+NL;
          CE=0;
          ss=ss-1;
          for k=1:K
              if s(k)<=ss
                 if d(k)>tp
                 elseif d(k)>=0
                    if uh(k)+2*d(k)<=254
                       CE=CE+1;
                    else
                    end
                 elseif d(k)>=tn
                    if uh(k)+2*d(k)>=0
                       CE=CE+1;
                    else
                    end    
                 elseif d(k)<tn
                 end
              end
          end
     end
     Ch_t=1;
     ss=ss+1;
   else
     Ch_t=0;
     ss=NaN;
end