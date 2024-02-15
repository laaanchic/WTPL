% This script provides an example of calculation of the Within-Trial Phase
% Locking (WTPL) as presented in Karvat, Ofir, & Landau, JOCN (2023).
% The input is the preprocessed EEG, divided into trials and in a "raw"
% structure according to the Fieldtrip conventions (the toolbox fieldtrip is 
% freely available at https://www.fieldtriptoolbox.org/).
% 
% For the code to work,  the directories containing this script and
% associated functions, as well as Fieldtrip, should be in the Matlab path.
%
% Version 1.2. Written by Golan Karvat, 24/05/2023

%% Load data
tic
WTPL_path = 'C:\Users\gk02\ownCloud\DB to OC\'; % give the path in which the EEG data is saved here
load ([WTPL_path 'EEG']);
disp(['Loading took ' num2str(toc,3) ' seconds']);
%% Calculate the TFR (Time Frequency Representation)
fs              = EEG.fsample;
cfg             = [];
cfg.method      = 'wavelet';
cfg.output      = 'fourier';            % Keeps the output as complex numbers
cfg.width       = 5;                    % Width of the wavelet, in cycles
cfg.foi         = 1:30;                 % Frequencies of interest, in Hz
cfg.toi         = -0.5:1/fs:1.5;        % Time-windows of interest.
cfg.keeptrials  = 'yes';
cfg.pad         = 'nextpow2';
freq = ft_freqanalysis(cfg,EEG);        % the structure _freq_ containg the TFR data

%% WTPL calculation
nlag_post   = 1;                        % number of lags after the time of interest (in the paper, we used 1)
nlag_pre    = 1;                        % number of lags before the time of interest (in the paper, we used 1)
lags        = -nlag_pre:nlag_post;      % array of lags

tic;
WTPL = wtplComp(freq,lags);
disp (['WTPL analysis took ' num2str(toc,3) ' seconds']);

%% Plotting (optional)

% baseline correction
BL = [-0.5 0];
bl_ind = t>=BL(1) & t<=BL(end);
bl = nanmean(WTPL(:,bl_ind,:),2);
bl = repmat(bl,[1,size(WTPL,2),1]);
% bl = 0; % un-comment this line to suppress baselining
curr = WTPL-bl;

% selecting time of interest
XS = [-0.25 1.25];
xs_ind = t>=XS(1) & t<=XS(end);
curr = curr(:,xs_ind,:);

% calculte the ERP (event related potential)
erp = ft_timelockanalysis([], EEG);
cfg = [];
cfg.baseline = [-0.5 0];
erp = ft_timelockbaseline(cfg,erp);

figure(568); clf; 
siz = get(0,'ScreenSize');
pos = [siz(3)*3/10, siz(4)/5, siz(3)*2/5, siz(4)*3/5];
set(gcf,'position',pos);
subplot(5,1,1); hold on % ERP
t_ind = erp.time>=XS(1) & erp.time<=XS(end);
plot(erp.time(t_ind),erp.avg(t_ind),'k','linewidth',2);
plot([1,1]*XS(1), [5,10], 'k','linewidth',2);
text(XS(1)+0.01, 7.5, '5 \muV','fontsize',14)
xlim(XS);
axis off

subplot(5,1,2:5) % WTPL
imagesc(t(xs_ind), f, nanmean(curr,3));
axis xy
xlim(XS);
ylim([5 f(end)]);
xlabel('Time rel. grating (sec)');
ylabel('Frequency (Hz)');
c = colorbar('location','north');
c.Label.String = 'WTPL';
c.Label.Position(2) = 1;
cmap = RedBlueColorMap;
set(gca,'fontsize',14,'colormap',cmap);
