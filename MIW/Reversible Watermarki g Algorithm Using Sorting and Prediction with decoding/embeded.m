function [image_out,plcheck,last_bit,LC,Tp,Tn]=embeded(c,r,uh,u,Pload,T,image_out)
 LC=0; EC=0; Tn=-floor(T/2); Tp=ceil(T/2)-1;
 p_m=length(Pload)+34;
 Pload=[mod(u(1:34),2)' Pload zeros(1,length(u)-p_m)];
 d=u-uh;  plcheck=0;  i=34;
 while LC+p_m>EC  && i<length(u)
     i=i+1;
     if d(i)>Tp
        %% 1 2 3  
        dd=d(i)+Tp+1;
        uhdd=uh(i)+dd;
        if uhdd<=255
           if uhdd+Tp<=254
              u(i)=uhdd;    % 1
             else
               u(i)=uhdd;   % 2
               LC=LC+1;
           end
         else
              LC=LC+1;      % 3
              Pload(LC+p_m)=1;
         end
     elseif d(i)>=0
        %% 4 5 6 7 8 
             dd=2*d(i)+1;
             uhdd=uh(i)+dd;
             if uhdd<=255
                if dd<=Tp
                   if uh(i)+2*dd<=254
                      EC=EC+1;                      % 4
                      u(i)=uh(i)+2*d(i)+Pload(EC);
                    else
                      u(i)=uhdd;                    % 5
                      LC=LC+1;
                    end
                 else
                    if uhdd+Tp<=254
                       EC=EC+1;                     % 6
                       u(i)=uh(i)+2*d(i)+Pload(EC);
                    else
                       u(i)=uhdd;                   % 7
                       LC=LC+1;
                    end
                 end
               else
                   LC=LC+1;                         % 8
                   Pload(LC+p_m)=1;
              end
               
       elseif d(i)>=Tn
        %% 9 10 11 12 13    
               dd=2*d(i);
               uhdd=uh(i)+dd;
               if uhdd>=0
                   if dd>=Tn
                        if uh(i)+2*dd>=0
                          	EC=EC+1;               % 9
                            u(i)=uhdd+Pload(EC);
                        else
                            u(i)=uhdd;             % 10
                            LC=LC+1;
                        end
                   else
                        if uhdd+Tn>=0
                          	EC=EC+1;               % 11
                            u(i)=uhdd+Pload(EC);
                        else
                            u(i)=uhdd;             % 12
                            LC=LC+1;
                        end
                   end
               else
                   LC=LC+1;                        % 13
                   Pload(LC+p_m)=1;
               end
               
       elseif d(i)<Tn
        %% 14 15 16  
               dd=d(i)+Tn;
               uhdd=uh(i)+dd;
               if uhdd>=0
                   if uhdd+Tn>=0
                       u(i)=uhdd;    % 14
                    else
                       u(i)=uhdd;    % 15
                       LC=LC+1;
                   end
               else
                   LC=LC+1;          % 16
                   Pload(LC+p_m)=1;
               end    
     end
 end
 last_bit=i;
 if LC+p_m==EC 
    plcheck=1; 
    u(1:34)=floor(u(1:34)/2)*2+[dec2binvec(Tp,7) dec2binvec(abs(Tn),7) dec2binvec(p_m,20)]';
    image_out((c-1)*size(image_out,1)+r)=u;
  else
    image_out=inf; 
 end
         
 
        
        
        
        
        
        