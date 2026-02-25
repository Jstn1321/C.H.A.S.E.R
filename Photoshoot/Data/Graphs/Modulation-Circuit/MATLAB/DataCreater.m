%% Chua Circuit Chaos Communication System
% Final Science Fair Poster Version
% Exports:
% 1) Individual graphs (PNG)
% 2) Combined multi-panel image (PNG)

clear; clc; close all;

%% =========================
% GLOBAL FORMATTING
% =========================
set(groot,'defaultAxesFontName','Arial');
set(groot,'defaultTextFontName','Arial');
set(groot,'defaultAxesFontSize',18);
set(groot,'defaultTextFontSize',20);
set(groot,'defaultAxesLineWidth',1.5);
set(groot,'defaultLineLineWidth',2);
set(groot,'defaultFigureColor','w');

export_res = 600;

%% =========================
% DATA
% =========================

Signal_RMS = [990.9849, 869.7078, 997.8106];
Noise_RMS  = [95.3035, 81.0140, 83.7939];
SNR_dB = 20*log10(Signal_RMS ./ Noise_RMS);
avgSNR = mean(SNR_dB);
stdSNR = std(SNR_dB);

freq = [100 200 500 1e3 2e3 5e3 10e3 15e3];
Vin  = [2.21250 3.2875 3.29583 3.29167 3.31250 3.30833 3.32500 3.31667];
Vout = [2.76250 3.00067 2.88333 3.66667 3.69167 4.87917 4.70833 4.75417];
Gain_dB = 20*log10(Vout ./ Vin);

Mismatch = [0 1 2 5 10];
NoiseFloor = [50.21449 59.00582 60.23935 78.63415 110.32757];
SignalRMS  = [725.79908 797.65040 779.93274 849.61819 1031.113053];
SNR_wrong = 20*log10(SignalRMS ./ NoiseFloor);

dB_vals = [-4 -18.3 -15.3 -15.7 -24];
V_linear = 10.^(dB_vals/20);
Fundamental = V_linear(1);
Harmonics   = V_linear(2:end);
THD_percent = sqrt(sum(Harmonics.^2))/Fundamental * 100;

secure_threshold = 22;

%% ============================================================
%% 1️⃣ FREQUENCY RESPONSE (Individual)
%% ============================================================

figure
semilogx(freq, Gain_dB,'-o','LineWidth',2,'MarkerSize',8)
grid on
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')
title('Frequency Response')
ylim([min(Gain_dB)-2 max(Gain_dB)+2])
xlim([80 20000])
exportgraphics(gcf,'Frequency_Response.png','Resolution',export_res)

%% ============================================================
%% 2️⃣ SECURITY TEST (Individual)
%% ============================================================

figure
hold on

x_min = min(Mismatch)-1;
x_max = max(Mismatch)+1;
y_min = min(SNR_wrong)-3;
y_max = max(SNR_wrong)+3;

% Secure region (green)
patch([x_min x_max x_max x_min], ...
      [secure_threshold secure_threshold y_max y_max], ...
      [0.8 1 0.8],'EdgeColor','none','FaceAlpha',0.4);

% Non-secure region (red)
patch([x_min x_max x_max x_min], ...
      [y_min y_min secure_threshold secure_threshold], ...
      [1 0.8 0.8],'EdgeColor','none','FaceAlpha',0.4);

plot(Mismatch, SNR_wrong,'-s','LineWidth',2,'MarkerSize',8)

xlabel('Key Mismatch (%)')
ylabel('SNR (dB)')
title('Security Performance vs Key Mismatch')
grid on
ylim([y_min y_max])
xlim([x_min x_max])

%text(6, secure_threshold+1.5,'SECURE','FontSize',18,'FontWeight','bold')
%text(6, secure_threshold-3,'NON-SECURE','FontSize',18,'FontWeight','bold')

hold off
exportgraphics(gcf,'Security_Test.png','Resolution',export_res)

%% ============================================================
%% 3️⃣ THD (Individual)
%% ============================================================

figure
stem(1:5,dB_vals,'filled','LineWidth',2)
grid on
xlabel('Harmonic Order')
ylabel('Amplitude (dB)')
title(sprintf('Harmonic Distortion (THD = %.2f%%)',THD_percent))
ylim([min(dB_vals)-5 2])
xlim([0.5 5.5])
exportgraphics(gcf,'THD_Analysis.png','Resolution',export_res)

%% ============================================================
%% 4️⃣ SYSTEM SUMMARY PANEL (Individual)
%% ============================================================

figure
axis off

text(0.1,0.75,'SYSTEM PERFORMANCE SUMMARY','FontSize',24,'FontWeight','bold')
text(0.1,0.55,sprintf('Average SNR: %.2f dB ± %.2f',avgSNR,stdSNR),'FontSize',20)
text(0.1,0.40,sprintf('THD: %.2f %%',THD_percent),'FontSize',20)
text(0.1,0.25,'Security Threshold: 22 dB','FontSize',20)

exportgraphics(gcf,'System_Summary.png','Resolution',export_res)

%% ============================================================
%% 5️⃣ COMBINED MULTI-PANEL FIGURE (NO SYSTEM SUMMARY)
%% ============================================================

figure('Position',[100 100 1800 600])
tiledlayout(1,3,'TileSpacing','loose','Padding','loose')

%% --- Frequency Response ---
nexttile
semilogx(freq, Gain_dB,'-o','LineWidth',2,'MarkerSize',8)
grid on
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')
title('Frequency Response')
ylim([min(Gain_dB)-2 max(Gain_dB)+2])
xlim([80 20000])

%% --- Security Performance ---
nexttile
hold on

x_min = min(Mismatch)-1;
x_max = max(Mismatch)+1;
y_min = min(SNR_wrong)-3;
y_max = max(SNR_wrong)+3;

patch([x_min x_max x_max x_min], ...
      [secure_threshold secure_threshold y_max y_max], ...
      [0.8 1 0.8],'EdgeColor','none','FaceAlpha',0.4);

patch([x_min x_max x_max x_min], ...
      [y_min y_min secure_threshold secure_threshold], ...
      [1 0.8 0.8],'EdgeColor','none','FaceAlpha',0.4);

plot(Mismatch, SNR_wrong,'-s','LineWidth',2,'MarkerSize',8)

grid on
xlabel('Key Mismatch (%)')
ylabel('SNR (dB)')
title('Security Performance')
ylim([y_min y_max])
xlim([x_min x_max])

hold off

%% --- THD ---
nexttile
stem(1:5,dB_vals,'filled','LineWidth',2)
grid on
xlabel('Harmonic Order')
ylabel('Amplitude (dB)')
title(sprintf('Total Harmonic Distortion = %.2f%%',THD_percent))
ylim([min(dB_vals)-5 2])
xlim([0.5 5.5])

sgtitle('Chua Circuit Chaos-Based Communication System Performance', ...
        'FontSize',24,'FontWeight','bold')

exportgraphics(gcf,'All_Graphs_Combined.png','Resolution',export_res);