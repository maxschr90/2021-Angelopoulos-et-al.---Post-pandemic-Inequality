%% Gini %%
%% This function is based on a user supplied function and we are grateful to the author for allowing us to use their work

function [relpop,relz,g] = gini(yy1, probst)
% %Modified Matlab function "Gini" by Yvan Lengwiler% Release: $1.0$% Date   : $2010-06-27$
% the current version handles negative values as well. 
%
% Copyright (c) 2010, Yvan Lengwiler
% All rights reserved.
%  The original file can be found here:
% https://uk.mathworks.com/matlabcentral/fileexchange/28080-gini-coefficient-and-the-lorentz-curve
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

order_y=[probst yy1];
order_y=sortrows(order_y,2);

values=order_y(:,2);
prob=order_y(:,1);

z = values .* prob;
[~,ord] = sort(values);
prob    = prob(ord);     z    = z(ord);
prob    = cumsum(prob);  z    = cumsum(z);
relpop = prob/prob(end); 
relz = z/z(end);

g = 1 - sum((relz(1:end-1)+relz(2:end)) .* diff(relpop));

end