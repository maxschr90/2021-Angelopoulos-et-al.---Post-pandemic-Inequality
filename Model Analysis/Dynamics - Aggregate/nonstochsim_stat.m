%%  Histogram Simulation
%% This function simulates the histogram for the stationary distribution

function [OMEGA, aa, hh, nn] = nonstochsim_stat(initdist,Transitions, h_choice, k_choice, grid_parms)
%% Read out grid parameters
nkap = grid_parms.nkap;
kap = grid_parms.kap; 
nh = grid_parms.nh;
h = grid_parms.h;

%% Simulate the model economy 
N=size(Transitions,2);
amin=min(kap);
amax=max(kap);
OMEGA=[];
Omegat=initdist;
Omegatp=zeros(nkap,nh,N);
hist_crit = 1;
H1_grid = reshape(h_choice,nkap, nh, N); 
K_grid = reshape(k_choice,nkap, nh, N); 
K_grid=amin.*(K_grid<amin)+amax.*(K_grid>amax)+K_grid.*(K_grid>=amin & K_grid<=amax);
H1_grid=0.1.*(H1_grid<0.1)+1.*(H1_grid>1)+H1_grid.*(H1_grid>=0.1 & H1_grid<=1);
       
%% Look-up index.
[hhg,aag]=meshgrid(h,kap);
aa=repmat(aag,1,1,N);
hh=repmat(hhg,1,1,N);
nn = ones(size(aa)).*reshape((1:1:N),1,1,N);
Im       = zeros(size(aa));
Jm       = zeros(size(aa));

%% Linear interpolation of probabilities
for j=1:N
        
   parfor ai = 1:nkap     
         for hi = 1:nh     
                Im(ai,hi,j) = find(K_grid(ai,hi,j)>=kap,1,'last');
                Jm(ai,hi,j) = find(H1_grid(ai,hi,j)>=h,1,'last');
                Im(ai,hi,j) = min(Im(ai,hi,j),nkap-1);
                Jm(ai,hi,j) = min(Jm(ai,hi,j),nh-1);
         end
   end
end

PI=squeeze(Transitions); 
while hist_crit >10^-8    
 for j=1:N
        % Linear interpolation of probabilities
   for ai = 1:nkap     
         for hi = 1:nh     
            for jp=1:N
                I =Im(ai,hi,j);
                J =Jm(ai,hi,j);
                rhok = (K_grid(ai,hi,j)-kap(I+1))./(kap(I)-kap(I+1));
                rhoh = (H1_grid(ai,hi,j)-h(J+1))./(h(J)-h(J+1));
                Omegatp(I,J,jp)   = Omegatp(I,J,jp)+Omegat(ai,hi,j)*PI(j,jp)*rhok*rhoh;
                Omegatp(I+1,J+1,jp) = Omegatp(I+1,J+1,jp)+Omegat(ai,hi,j)*PI(j,jp)*(1-rhok)*(1-rhoh);
                Omegatp(I+1,J,jp)   = Omegatp(I+1,J,jp)+Omegat(ai,hi,j)*PI(j,jp)*(1-rhok)*(rhoh);
                Omegatp(I,J+1,jp) = Omegatp(I,J+1,jp)+Omegat(ai,hi,j)*PI(j,jp)*(rhok)*(1-rhoh);
               
            end
         end
   end
 end
    OMEGA=[OMEGA Omegat(:)];
    hist_crit = norm(Omegat(:)-Omegatp(:),inf);  % check for convergence
    Omegat=Omegatp;
    Omegatp=zeros(nkap,nh,N);
end

aa = aa(:);
hh = hh(:);
nn = nn(:);
end