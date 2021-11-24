%% Function 2 - Expected Value
%% This function approximates the value function using a polynomial approximation.

function [EV] = expectedvalue(hx,kapx,b,p)

%% Generate Polynominal Expansion of order p
% these are hard coded for speed
    if p==1
        poly = [hx' kapx' hx'.*kapx'];
    elseif p==2
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2];
    elseif p==3
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3];
    elseif p==4
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4];
 elseif p==5
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4 hx'.^5 kapx'.^5 hx'.^5.*kapx' hx'.*kapx'.^5 hx'.^5.*kapx'.^2 hx'.^2.*kapx'.^5 ...
                hx'.^5.*kapx'.^3 hx'.^3.*kapx'.^5  hx'.^5.*kapx'.^4 hx'.^4.*kapx'.^5  hx'.^5.*kapx'.^5];
 elseif p==7
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4 ...
                hx'.^5 kapx'.^5 hx'.^5.*kapx' hx'.*kapx'.^5 hx'.^5.*kapx'.^2 hx'.^2.*kapx'.^5 hx'.^5.*kapx'.^3 hx'.^3.*kapx'.^5  hx'.^5.*kapx'.^4 hx'.^4.*kapx'.^5  hx'.^5.*kapx'.^5 ...
                hx'.^6 kapx'.^6 hx'.^6.*kapx' hx'.*kapx'.^6 hx'.^6.*kapx'.^2 hx'.^2.*kapx'.^6 hx'.^6.*kapx'.^3 hx'.^3.*kapx'.^6  hx'.^6.*kapx'.^4 hx'.^4.*kapx'.^6 hx'.^6.*kapx'.^5 hx'.^5.*kapx'.^6  hx'.^6.*kapx'.^6 ...
                hx'.^7 kapx'.^7 hx'.^7.*kapx' hx'.*kapx'.^7 hx'.^7.*kapx'.^2 hx'.^2.*kapx'.^7 hx'.^7.*kapx'.^3 hx'.^3.*kapx'.^7  hx'.^7.*kapx'.^4 hx'.^4.*kapx'.^7 hx'.^7.*kapx'.^5 hx'.^5.*kapx'.^7  hx'.^7.*kapx'.^6 hx'.^6.*kapx'.^7  hx'.^7.*kapx'.^7 ];
    end

      EV = [1 poly]*b;
    
end