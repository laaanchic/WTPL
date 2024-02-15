function WTPL = wtplComp(freq,lags)
f = freq.freq;                          % frequency array
t = freq.time;                          % time array
nTR = size(freq.fourierspctrm,1);       % number of trials
ntime = length(t);                      % number of timepoints
nlag = length(lags);                    % number of desired lags
c_ind       = nearest(lags,0);          % the index of "phi 0"
WTPL = nan(length(f),length(t),nTR);    % the WTPL of each frequency, timepoint and trial will be saved here

for i = 1:length(f)                     % loop through frequencies (becuase each frequency has a different cycle width)
    fi = f(i);
    width         = 1/fi;             % window size in sec
    toi           = t + lags'*width;    % matrix with the times of the peaks of interest. The c_ind row is phi0, those before it are "negative" phis, those after are "positive'  
    
    spect = squeeze(freq.fourierspctrm(:,:,i,:));    
    toi = round(toi*1000)/1000;
    wtpl = nan(ntime, nTR); % dimension order: rpt_time
    
    for ti = 1:ntime
        idx = zeros(1,nlag);
        % control for peaks appearing in times that are out of the available data
        for li = 1:nlag
            try
                idx(li) = find(freq.time>=toi(li,ti),1,'first');
                flag = 1;
                if idx(li)==1; flag=0;end
            catch
                toi(:,ti) = nan;
                flag = 0;
            end
        end
        % the "actual" WTPL calculation
        if flag % calculate the ITLC only if all phases of interest are available
            c1 = idx(c_ind);
            a1 = angle(spect(:,c1));         % " phi 0 "
            idx(c_ind) = [];
            TMP = a1 - angle(spect(:,idx));  % " phy l "
            r = sum(exp(1i*TMP),2);          % mean resultant vector length over lags (based on circ_r from the CircStat toolbox)
            wtpl(ti,:) = abs(r)/size(TMP,2); % WTPL is the length of r
        end
    end
    WTPL(i,:,:) = wtpl;  
end
end