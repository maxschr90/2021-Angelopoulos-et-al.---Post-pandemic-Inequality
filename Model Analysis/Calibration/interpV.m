
%% Function 3 - Interpolate VF Approximation
%% This function finds the coefficients of the Value Function Approximation by Regression

function b = interpV(Value_Function, hx, kapx, n)

%% Generate Polynominal of order n    
% these are hard coded for speed
    if n==1
        poly = [hx' kapx' hx'.*kapx'];
    elseif n==2
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2];
    elseif n==3
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3];
    elseif n==4
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4];
 elseif n==5
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4 hx'.^5 kapx'.^5 hx'.^5.*kapx' hx'.*kapx'.^5 hx'.^5.*kapx'.^2 hx'.^2.*kapx'.^5 ...
                hx'.^5.*kapx'.^3 hx'.^3.*kapx'.^5  hx'.^5.*kapx'.^4 hx'.^4.*kapx'.^5  hx'.^5.*kapx'.^5];
 elseif n==7
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4 ...
                hx'.^5 kapx'.^5 hx'.^5.*kapx' hx'.*kapx'.^5 hx'.^5.*kapx'.^2 hx'.^2.*kapx'.^5 hx'.^5.*kapx'.^3 hx'.^3.*kapx'.^5  hx'.^5.*kapx'.^4 hx'.^4.*kapx'.^5  hx'.^5.*kapx'.^5 ...
                hx'.^6 kapx'.^6 hx'.^6.*kapx' hx'.*kapx'.^6 hx'.^6.*kapx'.^2 hx'.^2.*kapx'.^6 hx'.^6.*kapx'.^3 hx'.^3.*kapx'.^6  hx'.^6.*kapx'.^4 hx'.^4.*kapx'.^6 hx'.^6.*kapx'.^5 hx'.^5.*kapx'.^6  hx'.^6.*kapx'.^6 ...
                hx'.^7 kapx'.^7 hx'.^7.*kapx' hx'.*kapx'.^7 hx'.^7.*kapx'.^2 hx'.^2.*kapx'.^7 hx'.^7.*kapx'.^3 hx'.^3.*kapx'.^7  hx'.^7.*kapx'.^4 hx'.^4.*kapx'.^7 hx'.^7.*kapx'.^5 hx'.^5.*kapx'.^7  hx'.^7.*kapx'.^6 hx'.^6.*kapx'.^7  hx'.^7.*kapx'.^7 ];


    end
%% Standardise polynomial terms to have mean zero and sd 1 for numerical stability
    s = var(poly).^0.5;
    m = mean(poly);
    poly = ((poly - m)./s);
%% Use Regression to find Coefficients    
        b = [ones(size(hx,2),1) poly]\Value_Function;
%% translate coefficients back
        b(1,:) = b(1,:)-(m./s)*b(2:end,:);
        b(2:end,:) = b(2:end,:)./s';
end