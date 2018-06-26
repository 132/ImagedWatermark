function TpTnpsnr = xiaolong2013(originalImage,method,bpp)
originalImage = double(originalImage);
maxT=80;
Tnn=[1;1]*(-1:-1:-maxT);
Tpp=[1;1]*(1:maxT-1);
TpTn(:,1:2)=[[0;0;Tpp(:);maxT] [0;Tnn(:)]];
TpTnpsnr=ones(length(bpp),3)*NaN;
kb=0;
while kb<length(bpp)  
      Ch_LL=0;
      kb=kb+1;
      disp([method,'        ',num2str(bpp(kb),'%1.2f'),' ','bpp'])
      Hostimage=originalImage;  Pload=randint(1,round(bpp(kb)*numel(originalImage)/9),[0 1]);
      NL=length(Pload);   L=1;  TM=0;
      tL=zeros(1,9);
      while Ch_LL==0 && L<=9
           Ch_t=0; 
           [c r d s uh u] = layers(Hostimage,L); K=size(u,1);
           while tL(L)<size(TpTn,1) && Ch_t==0
                tL(L)=tL(L)+1;
                tp=TpTn(tL(L),1); tn=TpTn(tL(L),2);
                [Ch_t,ss,CM] = find_t_s(d,uh,s,tp,tn,NL);
                if Ch_t==1
                   map = creating_map(d,uh,tp,tn,CM); hdmap=[dec2binvec(tL(L),8) dec2binvec(ss,8) dec2binvec(NL,20) map];
                   [LSB,Hostimage,CPL] = embed_I1(d,uh,s,r,c,tp,tn,ss,hdmap,Pload,Hostimage);
                   [Hostimage,k2] = embed_I2(d,uh,s,r,c,tp,tn,ss,Hostimage,LSB);
                   [Hostimage] = embed_I3(d,uh,s,r,c,tp,tn,ss,Pload,Hostimage,CPL,k2);
                   TM=TM+CM*ceil(log2(K+1));
                end
           end
           if tL(L)==size(TpTn,1)
              Ch_LL=1;
           end
           if Ch_t==1
              L=L+1;
           end
       end
       if L==10 
          Mean2err=sum(sum((Hostimage-originalImage).^2))/(numel(originalImage));
          sdf=255^2./(Mean2err);
          PSNR = 10*log10(sdf);
          TpTnpsnr(kb,1)=bpp(kb);
          TpTnpsnr(kb,2)=PSNR;
          TpTnpsnr(kb,3)=TM;
       elseif Ch_LL==1
          TpTnpsnr(kb,1)=bpp(kb); 
       end
 end
       
