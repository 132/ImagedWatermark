 function [image_out,Pload_dot]=decoding(c,r,uh,u,image_in)

 data=[c r u-uh uh u u];
 
 Tp = binvec2dec(bitand(data(1:7,5),1)'); 
 Tn = -binvec2dec(bitand(data(8:14,5),1)'); 
 length_Pload = binvec2dec(bitand(data(15:34,5),1)'); 
 
 
 image_out=image_in;
 
 data_dum=data(35:end,:);
 status=zeros(size(data_dum,1),1);
 status((data_dum(:,3)>2*Tp+1)&((data_dum(:,4)+data_dum(:,3)+Tp+1)<=255))=1;
 status((data_dum(:,3)>2*Tp+1)&((data_dum(:,4)+data_dum(:,3)+Tp+1)>255))=2;
 
 status((data_dum(:,3)>=0)&(data_dum(:,3)<=2*Tp+1)&(data_dum(:,3)<=Tp)&((data_dum(:,4)+2*data_dum(:,3)+1)<=255))=3; 
 status((data_dum(:,3)>=0)&(data_dum(:,3)<=2*Tp+1)&(data_dum(:,3)<=Tp)&((data_dum(:,4)+2*data_dum(:,3)+1)>255))=4; 
 status((data_dum(:,3)>=0)&(data_dum(:,3)<=2*Tp+1)&(data_dum(:,3)>Tp)&((data_dum(:,4)+data_dum(:,3)+Tp+1)<=255))=5;
 status((data_dum(:,3)>=0)&(data_dum(:,3)<=2*Tp+1)&(data_dum(:,3)>Tp)&((data_dum(:,4)+data_dum(:,3)+Tp+1)>255))=6;
 
 status((data_dum(:,3)<0)&(data_dum(:,3)>=2*Tn)&(data_dum(:,3)>=Tn)&((data_dum(:,4)+2*data_dum(:,3))>=0))=7; 
 status((data_dum(:,3)<0)&(data_dum(:,3)>=2*Tn)&(data_dum(:,3)>=Tn)&((data_dum(:,4)+2*data_dum(:,3))<0))=8; 
 status((data_dum(:,3)<0)&(data_dum(:,3)>=2*Tn)&(data_dum(:,3)<Tn)&((data_dum(:,4)+data_dum(:,3)+Tn)>=0))=9;
 status((data_dum(:,3)<0)&(data_dum(:,3)>=2*Tn)&(data_dum(:,3)<Tn)&((data_dum(:,4)+data_dum(:,3)+Tn)<0))=10;
 
 status((data_dum(:,3)<2*Tn)&((data_dum(:,4)+data_dum(:,3)+Tn)>=0))=11;
 status((data_dum(:,3)<2*Tn)&((data_dum(:,4)+data_dum(:,3)+Tn)<0))=12;
 
 L_chk=(status==2|status==4|status==6|status==8|status==10|status==12);
 E_chk=(status==3|status==5|status==7|status==9);
 position_ES=(cumsum(E_chk)-cumsum(L_chk)<length_Pload);
 Last_bit=find(cumsum(E_chk)-cumsum(L_chk)==length_Pload);
 position_ES(Last_bit(1))=1;
 
 b=mod(data_dum(E_chk & position_ES,3),2);
 LSB=b(1:34);
 Pload_dot=b(35:length_Pload);
 L=b(length_Pload+1:end);
 SL=L_chk;
 SL(L_chk & position_ES)=L;
 
 data_dum(status==1 & position_ES,6)=data_dum(status==1 & position_ES,4)+data_dum(status==1 & position_ES,3)-Tp-1;
 data_dum(status==2 & position_ES & SL==0,6)=data_dum(status==2 & position_ES & SL==0,4)+data_dum(status==2 & position_ES & SL==0,3)-Tp-1;
 data_dum(status==2 & position_ES & SL==1,6)=data_dum(status==2 & position_ES & SL==1,4)+data_dum(status==2 & position_ES & SL==1,3);
 
 data_dum(status==3 & position_ES,6)=data_dum(status==3 & position_ES,4)+floor(data_dum(status==3 & position_ES,3)/2);
 data_dum(status==4 & position_ES & SL==0,6)=data_dum(status==4 & position_ES & SL==0,4)+floor(data_dum(status==4 & position_ES & SL==0,3)/2);
 data_dum(status==4 & position_ES & SL==1,6)=data_dum(status==4 & position_ES & SL==1,4)+data_dum(status==4 & position_ES & SL==1,3);
 data_dum(status==5 & position_ES,6)=data_dum(status==5 & position_ES,4)+floor(data_dum(status==5 & position_ES,3)/2);
 data_dum(status==6 & position_ES & SL==0,6)=data_dum(status==6 & position_ES & SL==0,4)+floor(data_dum(status==6 & position_ES & SL==0,3)/2);
 data_dum(status==6 & position_ES & SL==1,6)=data_dum(status==6 & position_ES & SL==1,4)+data_dum(status==6 & position_ES & SL==1,3);
 
 data_dum(status==7 & position_ES,6)=data_dum(status==7 & position_ES,4)+floor(data_dum(status==7 & position_ES,3)/2);
 data_dum(status==8 & position_ES & SL==0,6)=data_dum(status==8 & position_ES & SL==0,4)+floor(data_dum(status==8 & position_ES & SL==0,3)/2);
 data_dum(status==8 & position_ES & SL==1,6)=data_dum(status==8 & position_ES & SL==1,4)+data_dum(status==8 & position_ES & SL==1,3);
 data_dum(status==9 & position_ES,6)=data_dum(status==9 & position_ES,4)+floor(data_dum(status==9 & position_ES,3)/2);
 data_dum(status==10 & position_ES & SL==0,6)=data_dum(status==10 & position_ES & SL==0,4)+floor(data_dum(status==10 & position_ES & SL==0,3)/2);
 data_dum(status==10 & position_ES & SL==1,6)=data_dum(status==10 & position_ES & SL==1,4)+data_dum(status==10 & position_ES & SL==1,3);
 
 data_dum(status==11 & position_ES,6)=data_dum(status==11 & position_ES,4)+data_dum(status==11 & position_ES,3)-Tn;
 data_dum(status==12 & position_ES & SL==0,6)=data_dum(status==12 & position_ES & SL==0,4)+data_dum(status==12 & position_ES & SL==0,3)-Tn;
 data_dum(status==12 & position_ES & SL==1,6)=data_dum(status==12 & position_ES & SL==1,4)+data_dum(status==12 & position_ES & SL==1,3);
 
 data(1:34,6)=bitset(data(1:34,5),1,0)+LSB;
 data(35:end,6)=data_dum(:,6);
 
 image_out((data(:,1)-1)*size(image_out,1)+data(:,2))=data(:,6);
 
 
 
 
 
 
 
 
 
 
 
