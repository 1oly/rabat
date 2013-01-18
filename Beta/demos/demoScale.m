clear all
close all


path = '~/Dropbox/SpecialKursus/Measurements/newScaleModel/';

[h1Mod,fsMod] = wavread([path 'model5.wav']);
[h1Full,fsFull] = wavread([path 'full5.wav']);
[hCM,tM] = rbaCropIR(h1Mod,fsMod);
[hCF,tF] = rbaCropIR(h1Full,fsFull);

%% Scale parameters
K = 10; % Scaling
% get center frequencies for reference and model
fRef = rbaGetFreqs(125,4000,1);
% reference ambience
TRef = 25;
hrRef = 40;
PaRef = 101.325;

% reference ambience
TMod = 17;
hrMod = 40;
PaMod = 101.325;

[hFull,tRef] = rbaScaleModel(hCM,fsMod,K,fRef,[TRef TMod],[hrRef hrMod],[PaRef PaMod]);

%% Plot figures
figure(1)
plot(tM,hCM/max(hCM))
title('Cropped impulse response in scale model')
figure(2)
plot(tRef,hFull/max(hFull))
title('Full scale impulse response (RBA)')
figure(3)
plot(tF,hCF/max(hCF))
title('Full scale impulse response (Dirac)')
%ylim([-3e-9 3e-9])
%% RBA
Hoct1 = rbaIR2OctaveBands(hFull,fsFull,min(fRef),max(fRef),1,0);
R1 = rbaSchroeder(Hoct1,fsFull);
[RT1, r2p, dynRange,stdDev1] = rbaReverberationTime(R1,tRef,'best')
%% Dirac
Hoct1D = rbaIR2OctaveBands(hCF,fsFull,min(fRef),max(fRef),1,0);
R1D = rbaSchroeder(Hoct1D,fsFull);
[RT1D, r2p, dynRange,stdDev1D] = rbaReverberationTime(R1D,tRef,'best')