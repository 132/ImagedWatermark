Bpp = [0.00 0.01 0.02 0.03 0.11 0.15];
Sachnev =[75.00 64.25 61.42 59.58 53.36 52.01];
Hwang = [77.54 66.76 63.48 61.54 54.58 52.89];
Our = [78.03 67.38 64.15 62.24 55.54 53.95];
figure(1);
a = plot(Bpp, Sachnev, '-.', ...     
    Bpp,Hwang, ':', ...
    Bpp,Our, '-', ...    
        'linewidth', 2); 
title('Lena');
legend('Sachnev et al.','Hwang et al.','Ours');%,'location', 'northest');
xlabel('Embedding Rate (BPP)','FontSize',11)
ylabel('PSNR(dB)','FontSize',11)

Bpp = [0.00 0.01 0.02 0.03 0.11 0.15];
Sachnev =[70.78 60.46 57.11 54.67 46.04 43.53];% 56.80 55.30 54.15 53.14 52.24];
Hwang = [73.79 62.92 59.30 56.97 46.60 43.95];% 57.72 56.09 54.68 53.53 52.59];
Our = [74.57 63.39 59.77 57.32 47.65 44.30];% 57.38 55.80 53.68 53.42 52.52];
figure(1);
a = plot(Bpp, Sachnev, '-.', ...     
    Bpp,Hwang, ':', ...
    Bpp,Our, '-', ...    
        'linewidth', 2); 
title('Baboon');
legend('Sachnev et al.','Hwang et al.','Ours');%,'location', 'southeast');
xlabel('Embedding Rate (BPP)','FontSize',11)
ylabel('PSNR(dB)','FontSize',11)

figure(3) % PSNR va BPP
plot(TpTnpsnr(:,1),TpTnpsnr(:,2),'ko-','MarkerSize',4.5,'MarkerFaceColor','k');hold on;grid on
xlabel('Embedding Rate (BPP)','FontSize',11)
ylabel('PSNR(dB)','FontSize',11)
