

%% FUNCTION XV - Calcualate Concentration Indices %%  
    
function [CI, GCI, E, W] = concentrationindex(h,x,w,lim)
    %% This function calculates a number of concentration indices, based on Erregyers (2009) & Wagstaff et al. (1997)
    %% h is a bounded continuous indicator of health
    %% lim are the bounds of h
    %% x is a socioeconomic indicator variable that is used to rank the observations
    %% w are weights
    %% Keep only "existing" observations i.e. those with nonzero mass
    h = h(w>0);
    x = x(w>0);
    w = w(w>0);
    %% aggregate across xx using weighted mean of h within each cell of xx
    xx = unique(x);
    parfor i=1:size(xx,1)
        hh(i,1)=(h(xx(i)==x))'*w(xx(i)==x)/sum(w(xx(i)==x));
        ww(i,1) = sum(w(xx(i)==x));
    end
    %% calculate fractional Rank
    frank(1) = 0.5*ww(1,1);
    for i = 2:size(xx,1)
        frank(i,1) = sum(ww(1:i-1)) + 0.5*ww(i);
    end
%% compute concentraion indeces
    m=hh'*ww;
    n = size(xx,1);
    %% Concentration Index
    CI =  2*sum(ww.*hh.*frank)/m-1;
    %% Generalized Concentration Index
    GCI =  CI*m;
    %% Erregyes Index
    E = 4/(lim(2)-lim(1))*GCI;
    %% Wagstaff Index
    W = (lim(2)-lim(1))/((lim(2)-m)*(m-lim(1)))*GCI;
    
end

function [Error] = findcap(C,D,cap,drop)

    %% rescale Distribution
    D = D/sum(D);
    Mean_C = C'*D;
    
    %% impose cap
    C(C>cap) = cap;
    Error = (C'*D - drop*Mean_C);

end