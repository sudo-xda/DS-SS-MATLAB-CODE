clc, clear all, close all;
Data=[1 0 1 0 0 1 0 1 1 1 0 0]; %Message Sequence
Data=rectpulse(Data,1);
G=length(Data);
  
sd1 =[1 1 1 1];  %Initial Condition for flip flop          
 PN1=[];                       
 for j=1:G        %Length Of PN Sequence
     PN1=[PN1 sd1(4)];
     if sd1(1)==sd1(2)
         temp1=0;
     else temp1=1;
     end
     sd1(1)=sd1(2);
     sd1(2)=sd1(3);
     sd1(3)=sd1(4);
     sd1(4)= temp1; 
 end 
n=length(PN1);
t=1:1:n;

sp=xor(Data,PN1);% XOR Data witn PN sequence for Spreading
sp=double(sp);%converting the logical value to double value
% comp_sig=sp;
snr=20;
comp_sig=awgn(sp,snr);
comp_sig(comp_sig(:)<0)=0;
comp_sig1=logical(comp_sig);
ds=xor(comp_sig1,PN1);
figure(1)
subplot(2,2,1);
plot(Data); 
title('Message Signal'); 
subplot(2,2,2);
plot(PN1);
title('PN Sequence');
subplot(2,2,3);
plot(sp);
title('Spreaded')
subplot(2,2,4);
plot(t,ds);
title('DeSpreaded')
