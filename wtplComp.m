function wtpl = wtplComp(FREQ,toi,c_ind,fi)

spect = squeeze(FREQ.fourierspctrm(:,:,fi,:));
ntime = size(toi,2);
nlag = size(toi,1);
nTrial = size(FREQ.fourierspctrm,1);
toi = round(toi*1000)/1000;
wtpl = nan(ntime, nTrial); % dimension order: rpt_time

for ti = 1:ntime
    idx = zeros(1,nlag);
    % control for peaks appearing in times that are out of the available data
    for li = 1:nlag
        try 
            idx(li) = find(FREQ.time>=toi(li,ti),1,'first');
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
end