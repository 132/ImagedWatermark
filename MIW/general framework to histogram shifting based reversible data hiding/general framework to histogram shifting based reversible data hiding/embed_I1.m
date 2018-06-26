function [LSB,Hostimage,CPL] = embed_I1(d,uh,s,r,c,tp,tn,ss,hdmap,Pload,Hostimage)
k1=ceil(length(hdmap)/9);
NL=length(Pload);
CPL=0;
CLSB=0;
uk1=zeros(1,k1*9);
for k=1:k1
    if CPL<NL
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
   for i=-1:1
       for j=-1:1
           CLSB=CLSB+1;
           uk1(CLSB)=Hostimage(r(k)+i,c(k)+j);
       end
   end
end


LSB=mod(uk1,2);
LSB=LSB(1:length(hdmap));
uk1(1:length(hdmap))=floor(uk1(1:length(hdmap))/2)*2+hdmap;
CLSB=0;
for k=1:k1
   for i=-1:1
       for j=-1:1
           CLSB=CLSB+1;
           Hostimage(r(k)+i,c(k)+j)=uk1(CLSB);
       end
   end
end          

