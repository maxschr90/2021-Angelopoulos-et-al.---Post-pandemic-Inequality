%% Calculate Policy
%% This function calculates the post-policy earnings of hh and the associated costs
function [wage, cost] = calculatepolicy(wage, replacement, cutoff)

earningspctiles = [0.4517    0.5663    0.6762    0.8686    0.9636    0.9636    1.0465    1.5724    1.5724];
w = reshape(wage,36,[])';

if isempty(cutoff)==1
    
    cost = (w(4,:)-w(1:2,:))*replacement;
    w(1:2,:) = w(1:2,:)+cost;
else
    cost = (w(4,:)-w(1:2,:))*replacement.*(w(1:2,:)<=earningspctiles(cutoff));
    w(1:2,:) = w(1:2,:)+cost;
end
wage = [w(1,:), w(2,:), w(3,:), w(4,:)];
cost = [cost(1,:), cost(2,:), zeros(1,72)];

end