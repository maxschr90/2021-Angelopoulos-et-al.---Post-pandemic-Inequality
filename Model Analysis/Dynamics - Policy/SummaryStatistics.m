%% Calculate Summary Statistics %% 

function [Share_Healthstatus, Share_Class, Share_HTM, Mean_K, Mean_H, Mean_C, Mean_I,  GINI_H, GINI_K, Mean_H_Class, Mean_K_Class, Mean_C_Class,GINI_H_Class, GINI_K_Class, GINI_C_Class,  Share_HTM_Class, Wagstaffindex_K, Erregyersindex_K, Share_vulnerable_K, Share_vulnerable_C,Quintile_Share,Mean_K_Quint,Mean_H_Quint,Mean_C_Quint,Total_cost, Policycover] = SummaryStatistics(OMEGA, h_choice_agg, k_choice_agg, i_choice_agg, c_choice_agg, wages_agg,cost_agg, r, aa, nn,worldstate)

        [T] = size(OMEGA,2);
        r = [r(1), r(37), r(73) , r(110), 0.0056,r(1), r(37), r(73) , r(110)];
        risk_premium = [0.01*ones(1,T)];
        earningspctiles = [0.4517    0.5663    0.6762    0.8686    0.9636    0.9636    1.0465    1.5724    1.5724];

        worldstate = [worldstate(1:end-1)];
 
        parfor t=1:T
            h_choice(:,t) = reshape(h_choice_agg(:,:,worldstate(t)),[],1);
            k_choice(:,t) = reshape(k_choice_agg(:,:,worldstate(t)),[],1);
            i_choice(:,t) = reshape(i_choice_agg(:,:,worldstate(t)),[],1);
            c_choice(:,t) = reshape(c_choice_agg(:,:,worldstate(t)),[],1);
            cost(:,t) = reshape(cost_agg(:,:,worldstate(t)),[],1);
        end

        health = (nn>12) + (nn>24) + 1;
        class =       ((nn<4)+  (nn>12 & nn<=15)+(nn>24 & nn<=27))...
                      + 2*((nn>3 & nn<=6)+  (nn>15 & nn<=18)+(nn>27 & nn<=30))...
                      + 3*((nn>6 & nn<=9)+  (nn>18 & nn<=21)+(nn>30 & nn<=33))...
                      + 4*((nn>9 & nn<=12)+ (nn>21 & nn<=24)+(nn>33 & nn<=36));
        Share_Healthstatus = [sum(OMEGA(health ==1,:)); sum(OMEGA(health ==2,:)); sum(OMEGA(health ==3,:))];
        Share_Class = [sum(OMEGA(class ==1,:)); sum(OMEGA(class ==2,:)); sum(OMEGA(class ==3,:)); sum(OMEGA(class ==4,:))];
        
        Mean_H = sum(OMEGA.*h_choice);
        Mean_K = sum(OMEGA.*k_choice);
        Mean_I = sum(OMEGA.*i_choice);
        Mean_C = sum(OMEGA.*c_choice);
        Total_cost = sum(OMEGA.*cost);
         
        for t=1:T
            vulnerability_k_class(:,t) =(k_choice(:,t)<=0)+2*(k_choice(:,t)>0&k_choice(:,t)<=0.25);
            Share_vulnerable_K(:,t) = [sum(OMEGA(vulnerability_k_class(:,t) ==1,t)); sum(OMEGA(vulnerability_k_class(:,t) ==2,t))];
            vulnerability_c_class(:,t) = (c_choice(:,t)<=0.4513)+(c_choice(:,t)<=0.5422)+(c_choice(:,t)<=0.6338);
            vulnerability_c_class(vulnerability_c_class(:,t)==0,t) =Inf;
            Share_vulnerable_C(:,t) = [sum(OMEGA(vulnerability_c_class(:,t) ==1,t)); sum(OMEGA(vulnerability_c_class(:,t) <=2,t)); sum(OMEGA(vulnerability_c_class(:,t) <=3,t))];
            quints(:,t) = zeros(size(OMEGA,1),1)+(k_choice(:,t)<=wprctile(k_choice(:,t),20,OMEGA(:,t),8)&h_choice(:,t)<=wprctile(h_choice(:,t),20,OMEGA(:,t),8))+...
                                        2*(k_choice(:,t)<=wprctile(k_choice(:,t),40,OMEGA(:,t),8)&h_choice(:,t)<=wprctile(h_choice(:,t),40,OMEGA(:,t),8)&(k_choice(:,t)>wprctile(k_choice(:,t),20,OMEGA(:,t),8)&h_choice(:,t)>wprctile(h_choice(:,t),20,OMEGA(:,t),8))) +...
                                        3*(k_choice(:,t)<=wprctile(k_choice(:,t),60,OMEGA(:,t),8)&h_choice(:,t)<=wprctile(h_choice(:,t),60,OMEGA(:,t),8)&(k_choice(:,t)>wprctile(k_choice(:,t),40,OMEGA(:,t),8)&h_choice(:,t)>wprctile(h_choice(:,t),40,OMEGA(:,t),8))) +...
                                        4*(k_choice(:,t)<=wprctile(k_choice(:,t),80,OMEGA(:,t),8)&h_choice(:,t)<=wprctile(h_choice(:,t),80,OMEGA(:,t),8)&(k_choice(:,t)>wprctile(k_choice(:,t),60,OMEGA(:,t),8)&h_choice(:,t)>wprctile(h_choice(:,t),60,OMEGA(:,t),8))) +...
                                        5*(k_choice(:,t)>wprctile(k_choice(:,t),80,OMEGA(:,t),8)&h_choice(:,t)>wprctile(h_choice(:,t),80,OMEGA(:,t),8));

            Quintile_Share(:,t) = [sum(OMEGA(quints(:,t)==1,t));sum(OMEGA(quints(:,t)==2,t));sum(OMEGA(quints(:,t)==3,t));sum(OMEGA(quints(:,t)==4,t));sum(OMEGA(quints(:,t)==5,t))];
       end

        parfor t=1:T
             Share_HTM(t) = sum(OMEGA(:,t).*(k_choice(:,t)<10^-6));
            [~,~, Erregyersindex_K(t), Wagstaffindex_K(t)] = concentrationindex(h_choice(:,t),aa,OMEGA(:,t),[0.1,1]);


            [~,~,GINI_H(t)] =  gini( h_choice(:,t),OMEGA(:,t));
            [~,~,GINI_K(t)] =  gini( k_choice(:,t), OMEGA(:,t));
            
            Policycover(t) = sum(OMEGA(:,t).*(aa<=0.2411))/sum(OMEGA(:,t).*(aa<=0.2411));
            for n = 1:4
                
                Share_HTM_Class(n,t) = sum(OMEGA(class==n,t).*(k_choice(class==n,t)<10^-6))/ sum(OMEGA(class==n,t));

                Mean_H_Class(n,t) = h_choice(class==n,t)'*OMEGA(class==n,t)/sum(OMEGA(class==n,t));
                Mean_K_Class(n,t) = k_choice(class==n,t)'*OMEGA(class==n,t)/sum(OMEGA(class==n,t));
                Mean_C_Class(n,t) = c_choice(class==n,t)'*OMEGA(class==n,t)/sum(OMEGA(class==n,t));
                                
                [~,~,GINI_H_Class(n,t)] = gini( h_choice(class==n,t),OMEGA((class==n),t));
                [~,~,GINI_K_Class(n,t)] = gini(  k_choice(class==n,t),OMEGA((class==n),t));
                [~,~,GINI_C_Class(n,t)] = gini( c_choice(class==n,t),OMEGA((class==n),t));

            end
            for q = 1:5
                
                Mean_H_Quint(q,t) = h_choice(quints(:,t)==q,t)'*OMEGA(quints(:,t)==q,t)/sum(OMEGA(quints(:,t)==q,t));
                Mean_K_Quint(q,t) = k_choice(quints(:,t)==q,t)'*OMEGA(quints(:,t)==q,t)/sum(OMEGA(quints(:,t)==q,t));
                Mean_C_Quint(q,t) = c_choice(quints(:,t)==q,t)'*OMEGA(quints(:,t)==q,t)/sum(OMEGA(quints(:,t)==q,t));
                                

           end

        end

end