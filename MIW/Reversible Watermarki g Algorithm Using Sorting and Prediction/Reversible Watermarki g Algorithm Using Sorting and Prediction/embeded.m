function [image_out,plcheck,last_bit,LC,Tp,Tn]=embeded(c,r,uh,u,Pload,T,image_out)
% c (col)
% r (row)
% uh (predicted value)
% u (gia tri pixel cua anh goc)
% Pload (watermark)
% T (Tn va Tp)
% image_out (anh goc
% LC (location map)
% EC (so bit encode)
 LC=0; 
 EC=0; 
 Tn=-floor(T/2); 
 Tp=ceil(T/2)-1;
 p_m=length(Pload)+34; % chieu dai Payload khi them 34 bit nua
 % mod(u(1:34),2)' (lay LSB cua 34 gia tri dau tien cua anh goc)
 % Payload = [ 34LSB Watermark 0 cho den het] 
 Pload=[mod(u(1:34),2)' Pload zeros(1,length(u)-p_m)];  % dien payload cho du voi so luong Cross
 d=u-uh;  % prediction error
 plcheck=0; 
 i=34; % vi tri thu 34
 while LC+p_m>EC  && i<length(u)
     i=i+1;
     if d(i)>Tp  % HS
        %% 1 2 3  
        dd=d(i)+Tp+1;    
        uhdd=uh(i)+dd;   
        if uhdd<=255    % overflow 1
           if uhdd+Tp<=254  % overflow 2
              u(i)=uhdd;    % 1     ET(a)
           else             
               u(i)=uhdd;   % 2     ET(b)
               LC=LC+1; %  location map luu lai vi tri
           end
        else                
              LC=LC+1;      % 3     ET(c)
              Pload(LC+p_m)=1;  % chinh vi tri payload phia sau watermark lai (cai nay giong location map tron paper)
         end
     elseif d(i)>=0  % d > 0 va d < Tp      HS 1
        %% 4 5 6 7 8 
             dd=2*d(i)+1;   
             uhdd=uh(i)+dd;
             if uhdd<=255   % overflow 1
                if dd<=Tp   %               HS 2
                   if uh(i)+2*dd<=254   % overflow 2
                      EC=EC+1;                      % 4 ET(a)   EC la encode payload
                      u(i)=uh(i)+2*d(i)+Pload(EC);
                    else
                      u(i)=uhdd;                    % 5 ET(b)
                      LC=LC+1;
                    end
                else        %               HS 2
                    if uhdd+Tp<=254     % overflow 2
                       EC=EC+1;                     % 6 ET(a)
                       u(i)=uh(i)+2*d(i)+Pload(EC);
                    else
                       u(i)=uhdd;                   % 7 ET(b)
                       LC=LC+1;
                    end
                 end
             else %                        overflow 1
                   LC=LC+1;                         % 8 ET(c)
                   Pload(LC+p_m)=1;
              end
               
       elseif d(i)>=Tn  % Tn < d(i) < Tp
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
               
       elseif d(i)<Tn   % d < Tn
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
    % Nhung LSB 34 bit dau tien vao original image
    u(1:34)=floor(u(1:34)/2)*2+[dec2binvec(Tp,7) dec2binvec(abs(Tn),7) dec2binvec(p_m,20)]';
    image_out((c-1)*size(image_out,1)+r)=u;
  else
    image_out=inf; 
 end
         
 
        
        
        
        
        
        