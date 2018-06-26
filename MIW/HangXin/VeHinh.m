Bpp = [0.00 0.01 0.02 0.03 0.04 0.08 0.11 0.15 0.19 0.23 0.27];
Sachnev =[75.00 64.25 61.42 59.58 58.51 55.29 53.36 52.01 50.88 49.78 47.74];
Hwang = [77.54 66.76 63.48 61.54 60.34 56.78 54.58 52.89 51.42 49.88 48.31];
Our = [78.03 67.38 64.15 62.24 59.90 56.91 55.54 53.95 52.60 51.25 49.92];
figure(1);
a = plot(Bpp, Sachnev, 'g', ...     
    Bpp,Hwang, 'r', ...
    Bpp,Our, 'b', ...    
        'linewidth', 2); 
title('Lena');
legend('Sachnev et al.','Hwang et al.','Ours','location', 'southeast');
xlabel('Embedding Rate (BPP)','FontSize',11)
ylabel('PSNR(dB)','FontSize',11)

Bpp = [0.00 0.01 0.02 0.03 0.04 0.08 0.11 0.15 0.19 0.23 0.27];
Sachnev =[75.31 67.65 64.13 62.06 61.24 58.55 56.80 55.30 54.15 53.14 52.24];
Hwang = [79.91 69.07 66.08 64.31 63.19 59.80 57.72 56.09 54.68 53.53 52.59];
Our = [79.66 68.92 65.62 63.64 62.60 59.89 57.38 55.80 53.68 53.42 52.52];
figure(1);
a = plot(Bpp, Sachnev, 'g', ...     
    Bpp,Hwang, 'r', ...
    Bpp,Our, 'b', ...    
        'linewidth', 2); 
title('Plane');
legend('Sachnev et al.','Hwang et al.','Ours','location', 'southeast');
xlabel('Embedding Rate (BPP)','FontSize',11)
ylabel('PSNR(dB)','FontSize',11)

figure(3) % PSNR va BPP
plot(TpTnpsnr(:,1),TpTnpsnr(:,2),'ko-','MarkerSize',4.5,'MarkerFaceColor','k');hold on;grid on
xlabel('Embedding Rate (BPP)','FontSize',11)
ylabel('PSNR(dB)','FontSize',11)
