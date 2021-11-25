%% Simulate the distribution with aggregate uncertainty
%% This function simulates the histogram under aggregate uncertainty

function [OMEGA, aa, hh, nn] = nonstochsim_agg(initdist,Transitions, h_choice, k_choice, grid_parms, worldstate)

%% setup grids
nkap = grid_parms.nkap;
kap = grid_parms.kap; 
nh = grid_parms.nh;
h = grid_parms.h;

%% simulate the model economy 
N=size(Transitions,2);
[T] = size(worldstate,2)-1;
amin=min(kap);
amax=max(kap);
OMEGA=[];

Omegat=initdist;
Omegatp=zeros(nkap,nh,N);

H1_grid(:,:,:,1) = reshape(h_choice(:,:,1),nkap, nh, N); 
K_grid(:,:,:,1) = reshape(k_choice(:,:,1),nkap, nh, N); 
K_grid(:,:,:,1)=amin.*(K_grid(:,:,:,1)<amin)+amax.*(K_grid(:,:,:,1)>amax)+K_grid(:,:,:,1).*(K_grid(:,:,:,1)>=amin & K_grid(:,:,:,1)<=amax);
H1_grid(:,:,:,1)=0.1.*(H1_grid(:,:,:,1)<0.1)+1.*(H1_grid(:,:,:,1)>1)+H1_grid(:,:,:,1).*(H1_grid(:,:,:,1)>=0.1 & H1_grid(:,:,:,1)<=1);

H1_grid(:,:,:,2) = reshape(h_choice(:,:,2),nkap, nh, N); 
K_grid(:,:,:,2) = reshape(k_choice(:,:,2),nkap, nh, N); 
K_grid(:,:,:,2)=amin.*(K_grid(:,:,:,2)<amin)+amax.*(K_grid(:,:,:,2)>amax)+K_grid(:,:,:,2).*(K_grid(:,:,:,2)>=amin & K_grid(:,:,:,2)<=amax);
H1_grid(:,:,:,2)=0.1.*(H1_grid(:,:,:,2)<0.1)+1.*(H1_grid(:,:,:,2)>1)+H1_grid(:,:,:,2).*(H1_grid(:,:,:,2)>=0.1 & H1_grid(:,:,:,2)<=1);

H1_grid(:,:,:,3) = reshape(h_choice(:,:,3),nkap, nh, N); 
K_grid(:,:,:,3) = reshape(k_choice(:,:,3),nkap, nh, N); 
K_grid(:,:,:,3)=amin.*(K_grid(:,:,:,3)<amin)+amax.*(K_grid(:,:,:,3)>amax)+K_grid(:,:,:,3).*(K_grid(:,:,:,3)>=amin & K_grid(:,:,:,3)<=amax);
H1_grid(:,:,:,3)=0.1.*(H1_grid(:,:,:,3)<0.1)+1.*(H1_grid(:,:,:,3)>1)+H1_grid(:,:,:,3).*(H1_grid(:,:,:,3)>=0.1 & H1_grid(:,:,:,3)<=1);
    
H1_grid(:,:,:,4) = reshape(h_choice(:,:,4),nkap, nh, N); 
K_grid(:,:,:,4) = reshape(k_choice(:,:,4),nkap, nh, N); 
K_grid(:,:,:,4)=amin.*(K_grid(:,:,:,4)<amin)+amax.*(K_grid(:,:,:,4)>amax)+K_grid(:,:,:,4).*(K_grid(:,:,:,4)>=amin & K_grid(:,:,:,4)<=amax);
H1_grid(:,:,:,4)=0.1.*(H1_grid(:,:,:,4)<0.1)+1.*(H1_grid(:,:,:,4)>1)+H1_grid(:,:,:,4).*(H1_grid(:,:,:,4)>=0.1 & H1_grid(:,:,:,4)<=1); 

H1_grid(:,:,:,5) = reshape(h_choice(:,:,5),nkap, nh, N); 
K_grid(:,:,:,5) = reshape(k_choice(:,:,5),nkap, nh, N); 
K_grid(:,:,:,5)=amin.*(K_grid(:,:,:,5)<amin)+amax.*(K_grid(:,:,:,5)>amax)+K_grid(:,:,:,5).*(K_grid(:,:,:,5)>=amin & K_grid(:,:,:,5)<=amax);
H1_grid(:,:,:,5)=0.1.*(H1_grid(:,:,:,5)<0.1)+1.*(H1_grid(:,:,:,5)>1)+H1_grid(:,:,:,5).*(H1_grid(:,:,:,5)>=0.1 & H1_grid(:,:,:,5)<=1); 

H1_grid(:,:,:,6) = reshape(h_choice(:,:,6),nkap, nh, N); 
K_grid(:,:,:,6) = reshape(k_choice(:,:,6),nkap, nh, N); 
K_grid(:,:,:,6)=amin.*(K_grid(:,:,:,6)<amin)+amax.*(K_grid(:,:,:,6)>amax)+K_grid(:,:,:,6).*(K_grid(:,:,:,6)>=amin & K_grid(:,:,:,6)<=amax);
H1_grid(:,:,:,6)=0.1.*(H1_grid(:,:,:,6)<0.1)+1.*(H1_grid(:,:,:,6)>1)+H1_grid(:,:,:,6).*(H1_grid(:,:,:,6)>=0.1 & H1_grid(:,:,:,6)<=1); 

H1_grid(:,:,:,7) = reshape(h_choice(:,:,7),nkap, nh, N); 
K_grid(:,:,:,7) = reshape(k_choice(:,:,7),nkap, nh, N); 
K_grid(:,:,:,7)=amin.*(K_grid(:,:,:,7)<amin)+amax.*(K_grid(:,:,:,7)>amax)+K_grid(:,:,:,7).*(K_grid(:,:,:,7)>=amin & K_grid(:,:,:,7)<=amax);
H1_grid(:,:,:,7)=0.1.*(H1_grid(:,:,:,7)<0.1)+1.*(H1_grid(:,:,:,7)>1)+H1_grid(:,:,:,7).*(H1_grid(:,:,:,7)>=0.1 & H1_grid(:,:,:,7)<=1); 

H1_grid(:,:,:,8) = reshape(h_choice(:,:,8),nkap, nh, N); 
K_grid(:,:,:,8) = reshape(k_choice(:,:,8),nkap, nh, N); 
K_grid(:,:,:,8)=amin.*(K_grid(:,:,:,8)<amin)+amax.*(K_grid(:,:,:,8)>amax)+K_grid(:,:,:,8).*(K_grid(:,:,:,8)>=amin & K_grid(:,:,:,8)<=amax);
H1_grid(:,:,:,8)=0.1.*(H1_grid(:,:,:,8)<0.1)+1.*(H1_grid(:,:,:,8)>1)+H1_grid(:,:,:,8).*(H1_grid(:,:,:,8)>=0.1 & H1_grid(:,:,:,8)<=1); 

H1_grid(:,:,:,9) = reshape(h_choice(:,:,9),nkap, nh, N); 
K_grid(:,:,:,9) = reshape(k_choice(:,:,9),nkap, nh, N); 
K_grid(:,:,:,9)=amin.*(K_grid(:,:,:,9)<amin)+amax.*(K_grid(:,:,:,9)>amax)+K_grid(:,:,:,9).*(K_grid(:,:,:,9)>=amin & K_grid(:,:,:,9)<=amax);
H1_grid(:,:,:,9)=0.1.*(H1_grid(:,:,:,9)<0.1)+1.*(H1_grid(:,:,:,9)>1)+H1_grid(:,:,:,9).*(H1_grid(:,:,:,9)>=0.1 & H1_grid(:,:,:,9)<=1); 

%% Look-up index.

[hhg,aag]=meshgrid(h,kap);
aa=repmat(aag,1,1,N);
hh=repmat(hhg,1,1,N);
nn = ones(size(aa)).*reshape((1:1:N),1,1,N);
Im       = zeros([size(aa),2]);
Jm       = zeros([size(aa),2]);

for j=1:N
   for ai = 1:nkap     
         for hi = 1:nh     
             %% Linear interpolation of probabilities
                Im(ai,hi,j,1) = find(K_grid(ai,hi,j,1)>=kap,1,'last');
                Jm(ai,hi,j,1) = find(H1_grid(ai,hi,j,1)>=h,1,'last');
                Im(ai,hi,j,1) = min(Im(ai,hi,j,1),nkap-1);
                Jm(ai,hi,j,1) = min(Jm(ai,hi,j,1),nh-1);
                
                Im(ai,hi,j,2) = find(K_grid(ai,hi,j,2)>=kap,1,'last');
                Jm(ai,hi,j,2) = find(H1_grid(ai,hi,j,2)>=h,1,'last');
                Im(ai,hi,j,2) = min(Im(ai,hi,j,2),nkap-1);
                Jm(ai,hi,j,2) = min(Jm(ai,hi,j,2),nh-1);

                Im(ai,hi,j,3) = find(K_grid(ai,hi,j,3)>=kap,1,'last');
                Jm(ai,hi,j,3) = find(H1_grid(ai,hi,j,3)>=h,1,'last');
                Im(ai,hi,j,3) = min(Im(ai,hi,j,3),nkap-1);
                Jm(ai,hi,j,3) = min(Jm(ai,hi,j,3),nh-1);
                
                Im(ai,hi,j,4) = find(K_grid(ai,hi,j,4)>=kap,1,'last');
                Jm(ai,hi,j,4) = find(H1_grid(ai,hi,j,4)>=h,1,'last');
                Im(ai,hi,j,4) = min(Im(ai,hi,j,4),nkap-1);
                Jm(ai,hi,j,4) = min(Jm(ai,hi,j,4),nh-1);
                
                Im(ai,hi,j,5) = find(K_grid(ai,hi,j,5)>=kap,1,'last');
                Jm(ai,hi,j,5) = find(H1_grid(ai,hi,j,5)>=h,1,'last');
                Im(ai,hi,j,5) = min(Im(ai,hi,j,5),nkap-1);
                Jm(ai,hi,j,5) = min(Jm(ai,hi,j,5),nh-1);   
                
                Im(ai,hi,j,6) = find(K_grid(ai,hi,j,6)>=kap,1,'last');
                Jm(ai,hi,j,6) = find(H1_grid(ai,hi,j,6)>=h,1,'last');
                Im(ai,hi,j,6) = min(Im(ai,hi,j,6),nkap-1);
                Jm(ai,hi,j,6) = min(Jm(ai,hi,j,6),nh-1);
                                        
                Im(ai,hi,j,7) = find(K_grid(ai,hi,j,7)>=kap,1,'last');
                Jm(ai,hi,j,7) = find(H1_grid(ai,hi,j,7)>=h,1,'last');
                Im(ai,hi,j,7) = min(Im(ai,hi,j,7),nkap-1);
                Jm(ai,hi,j,7) = min(Jm(ai,hi,j,7),nh-1);
                                
                Im(ai,hi,j,8) = find(K_grid(ai,hi,j,8)>=kap,1,'last');
                Jm(ai,hi,j,8) = find(H1_grid(ai,hi,j,8)>=h,1,'last');
                Im(ai,hi,j,8) = min(Im(ai,hi,j,8),nkap-1);
                Jm(ai,hi,j,8) = min(Jm(ai,hi,j,8),nh-1);
                              
                Im(ai,hi,j,9) = find(K_grid(ai,hi,j,9)>=kap,1,'last');
                Jm(ai,hi,j,9) = find(H1_grid(ai,hi,j,9)>=h,1,'last');
                Im(ai,hi,j,9) = min(Im(ai,hi,j,9),nkap-1);
                Jm(ai,hi,j,9) = min(Jm(ai,hi,j,9),nh-1);  
         end
   end
end

for t=1:T
    if worldstate(t+1) >5
        PI=Transitions(:,:,worldstate(t+1)-5); 
    else
        PI=Transitions(:,:,worldstate(t+1)); 
    end
        
 for j=1:N
   for ai = 1:nkap     
         for hi = 1:nh     
            for jp=1:N
            %% Linear interpolation of probabilities
                I =Im(ai,hi,j,worldstate(t));
                J =Jm(ai,hi,j,worldstate(t));
                rhok = (K_grid(ai,hi,j,worldstate(t))-kap(I+1))./(kap(I)-kap(I+1));
                rhoh = (H1_grid(ai,hi,j,worldstate(t))-h(J+1))./(h(J)-h(J+1));
                Omegatp(I,J,jp)   = Omegatp(I,J,jp)+Omegat(ai,hi,j)*PI(j,jp)*rhok*rhoh;
                Omegatp(I+1,J+1,jp) = Omegatp(I+1,J+1,jp)+Omegat(ai,hi,j)*PI(j,jp)*(1-rhok)*(1-rhoh);
                Omegatp(I+1,J,jp)   = Omegatp(I+1,J,jp)+Omegat(ai,hi,j)*PI(j,jp)*(1-rhok)*(rhoh);
                Omegatp(I,J+1,jp) = Omegatp(I,J+1,jp)+Omegat(ai,hi,j)*PI(j,jp)*(rhok)*(1-rhoh);
            end
         end
   end
end

   OMEGA=[OMEGA Omegat(:)];
  
    Omegat=Omegatp;
    Omegatp=zeros(nkap,nh,N);
end

aa = aa(:);
hh = hh(:);
nn = nn(:);
end
