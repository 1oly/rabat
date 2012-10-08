% By Matti Karjalainen, HUT Acoustics Lab, April 10, 2001% This is an example of fitting a decay+noise model to envelope data.% Load first file env into workspace: a set of decay curves in matrix env% Then run this script to do some fitting and plotting of the result% Notice that here we have on initial delay in envelope data load('env.mat')sig=env(:,1:80); % env (decays on db scale) must be in the workspacefs=100;          % sample rate (hop frequency of decay envelope analysis)siz=size(sig);   % matrix dimensionsfigure(1);subplot(2,2,1)sgn=sig(:,2);           % pick first response example (regular case)lgenv=sgn-max(sgn);     % normalize maximum for 0 db[val,indx]=max(lgenv);  % find maximum point for delay estimation% next make a weighting function that exculdes sample before maximum point% this is not needed at all (w is optional) if there is no initial delayw = [zeros(indx-1,1);ones(length(lgenv)-indx+1,1)];% next the main thing of calling the nonlin optinal fit (decay2_fit)coeffs=decay2_fit(lgenv,[],w,1);axis([0 50 -20 0]); ylabel('level/dB'); text(20,-15,'regular decay');subplot(2,2,2)sgn=sig(:,24);          % pick second response example (beating case)lgenv=sgn-max(sgn);     % normalize maximum for 0 db[val,indx]=max(lgenv);  % find maximum pointw = [zeros(indx-1,1);ones(length(lgenv)-indx+1,1)];coeffs=decay2_fit(lgenv,[],w,1);  % find optimal fitaxis([0 50 -20 0]); ylabel('level/dB'); text(20,-15,'beating decay');subplot(2,2,3)sgn=sig(:,54);          % pick third response example (noise floor reached)lgenv=sgn-max(sgn);     % normalize maximum for 0 db[val,indx]=max(lgenv);  % find maximum pointw = [zeros(indx-1,1);ones(length(lgenv)-indx+1,1)];coeffs=decay2_fit(lgenv,[],w,1);  % find optimal fitaxis([0 50 -50 0]); ylabel('level/dB'); text(20,-15,'noise floor reached');% The next example is a problematic case where some extra info should be given% in order to make the fit working as desiredfrom the application viewpoint% for example if you use w=[zeros(4,1); ones(46,1)]; the result is more meaningfulsubplot(2,2,4)sgn=sig(:,1);           % pick third response example (a problematic case)lgenv=sgn-max(sgn);     % normalize maximum for 0 db[val,indx]=max(lgenv);  % find maximum pointw = [zeros(indx-1,1);ones(length(lgenv)-indx+1,1)];coeffs=decay2_fit(lgenv,[],w,1);  % find optimal fitaxis([0 50 -10 0]); ylabel('level/dB'); text(20,-8,'fitting incorrect');