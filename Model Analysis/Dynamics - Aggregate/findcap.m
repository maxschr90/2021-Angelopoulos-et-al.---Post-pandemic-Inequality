%% Find consumption ceiling
%% This function evaluates by how much mean consumption would drop if a certain limit was imposed 
function [Error] = findcap(C,D,cap,drop)
    %% rescale Distribution
    D = D/sum(D);
    Mean_C = C'*D;
    
    %% impose cap
    C(C>cap) = cap;
    Error = (C'*D - drop*Mean_C);

end