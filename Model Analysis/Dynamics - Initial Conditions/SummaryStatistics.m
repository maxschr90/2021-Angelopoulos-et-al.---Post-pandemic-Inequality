%% FUNCTION XII - Calculate Summary Statistics %% 

function [Mean_K, Mean_H, Mean_C, Mean_U, Median_K, Median_H, Median_C,Median_U, P10_K,P10_H,P10_C,P10_U, P25_K,P25_H,P25_C,P25_U,P75_K,P75_H,P75_C,P75_U,P90_K,P90_H,P90_C,P90_U ] = SummaryStatistics(OMEGA, h_choice_agg, k_choice_agg, i_choice_agg, c_choice_agg, wages_agg, r, aa, nn,parms, worldstate)

        [T] = size(OMEGA,2);

        worldstate = [worldstate(1:end-1)];
 
        parfor t=1:T
            h_choice(:,t) = reshape(h_choice_agg(:,:,worldstate(t)),[],1);
            k_choice(:,t) = reshape(k_choice_agg(:,:,worldstate(t)),[],1);
            i_choice(:,t) = reshape(i_choice_agg(:,:,worldstate(t)),[],1);
            c_choice(:,t) = reshape(c_choice_agg(:,:,worldstate(t)),[],1);
            wages(t,:) =  wages_agg(worldstate(t),:);
        end
	
	parfor t=1:T
	    u_choice(:,t) = (h_choice(:,t).^parms.phi).*(c_choice(:,t).^(1-parms.phi));
	end
        
        Mean_H = sum(OMEGA.*h_choice);
        Mean_K = sum(OMEGA.*k_choice);
        Mean_C = sum(OMEGA.*c_choice);
        Mean_U = sum(OMEGA.*u_choice);

                           
        parfor t=1:T
            
            Median_H(t) = wprctile(h_choice(:,t),50,OMEGA(:,t),8);
            Median_K(t) = wprctile(k_choice(:,t),50,OMEGA(:,t),8);
            Median_C(t) = wprctile(c_choice(:,t),50,OMEGA(:,t),8);
            Median_U(t) = wprctile(u_choice(:,t),50,OMEGA(:,t),8);

            
            P10_H(t) = wprctile(h_choice(:,t),10,OMEGA(:,t),8);
            P10_K(t) = wprctile(k_choice(:,t),10,OMEGA(:,t),8);
            P10_C(t) = wprctile(c_choice(:,t),10,OMEGA(:,t),8);
            P10_U(t) = wprctile(u_choice(:,t),10,OMEGA(:,t),8);

            P25_H(t) = wprctile(h_choice(:,t),25,OMEGA(:,t),8);
            P25_K(t) = wprctile(k_choice(:,t),25,OMEGA(:,t),8);
            P25_C(t) = wprctile(c_choice(:,t),25,OMEGA(:,t),8);
            P25_U(t) = wprctile(u_choice(:,t),25,OMEGA(:,t),8);
             
            P75_H(t) = wprctile(h_choice(:,t),75,OMEGA(:,t),8);
            P75_K(t) = wprctile(k_choice(:,t),75,OMEGA(:,t),8);
            P75_C(t) = wprctile(c_choice(:,t),75,OMEGA(:,t),8);   
            P75_U(t) = wprctile(u_choice(:,t),75,OMEGA(:,t),8);   
                        
            P90_H(t) = wprctile(h_choice(:,t),90,OMEGA(:,t),8);
            P90_K(t) = wprctile(k_choice(:,t),90,OMEGA(:,t),8);
            P90_C(t) = wprctile(c_choice(:,t),90,OMEGA(:,t),8);   
            P90_U(t) = wprctile(u_choice(:,t),90,OMEGA(:,t),8);   
            
        end

end