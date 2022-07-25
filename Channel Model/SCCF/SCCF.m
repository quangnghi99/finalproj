clear;clc;close
% Load data
load p=1_q_diff
% Plot
delta_q=1;
q_diff=linspace(0,35,36);

% for i=1:10
%     sum_NLos=0;
%     sigma1=f*1e9*(to_Los(i)-to_Los(i+1))+delta_f*to_Los(i+1);
%     rho_Los(i)=(K/(K+1))*h_Los(i)*conj(h_Los(i+1))*exp(2j*pi*sigma1);
% %     for n=1:number_cluster(i)
% %         for nn=1:number_cluster(i+1)
%             n=1;nn=1;
%             for m=1:number_ray(n,i)
%                 for mm=1:number_ray(n,i+1)
%                     sigma2(m,mm,i)=f*1e9*(to_pq_nm(m,n,i)-to_pq_nm(mm,nn,i+1))+delta_f*to_pq_nm(mm,nn,i+1);
%                     sum_NLos = sum_NLos + P_remain_f*h_NLos(m,n,i)*conj(h_NLos(mm,nn,i+1))*exp(2j*pi*sigma2(m,mm,i));
%                 end
%             end
% %         end
% %     end
%     rho_NLos(i)=(P_remain/(K+1))*mean(sum_NLos);
% end
for i=1:count
    sum_NLos=0;
    n=1;nn=1;
    for m=1:number_ray(n,1)
        for mm=1:number_ray(n,i)
            sigma2=f*1e9*(to_pq_nm(m,n,1)-to_pq_nm(mm,nn,i))+delta_f*to_pq_nm(mm,nn,i);
            sum_NLos = sum_NLos + P_remain_f*h_NLos(m,n,1)*conj(h_NLos(mm,nn,i))*exp(2j*pi*sigma2);
        end
    end
    rho_NLos(i)=(P_remain/(K+1))*mean(sum_NLos);
end
rho_corr=abs(rho_NLos);
rho_corr=rho_corr/rho_corr(1);
plot(q_diff,rho_corr,'bo-.');
grid on
hold on

% Load data
load p=3_q_diff
% Plot
% for i=1:10
%     sum_NLos=0;
%     sigma1=f*1e9*(to_Los(i)-to_Los(i+1))+delta_f*to_Los(i+1);
%     rho_Los1(i)=(K/(K+1))*h_Los(i)*conj(h_Los(i+1))*exp(2j*pi*sigma1);
% %     for n=1:number_cluster(i)
% %         for nn=1:number_cluster(i+1)
%             n=1;nn=1;
%             for m=1:number_ray(n,i)
%                 for mm=1:number_ray(n,i+1)
%                     sigma2(m,mm,i)=f*1e9*(to_pq_nm(m,n,i)-to_pq_nm(mm,nn,i+1))+delta_f*to_pq_nm(mm,nn,i+1);
%                     sum_NLos = sum_NLos + P_remain_f*h_NLos(m,n,i)*conj(h_NLos(mm,nn,i+1))*exp(2j*pi*sigma2(m,mm,i));
%                 end
%             end
% %         end
% %     end
%     rho_NLos1(i)=(P_remain/(K+1))*mean(sum_NLos);
% end
for i=1:count
    sum_NLos=0;
    n=1;nn=1;
    for m=1:number_ray(n,1)
        for mm=1:number_ray(n,i)
            sigma2=f*1e9*(to_pq_nm(m,n,1)-to_pq_nm(mm,nn,i))+delta_f*to_pq_nm(mm,nn,i);
            sum_NLos = sum_NLos + P_remain_f*h_NLos(m,n,1)*conj(h_NLos(mm,nn,i))*exp(2j*pi*sigma2);
        end
    end
    rho_NLos1(i)=(P_remain/(K+1))*mean(sum_NLos);
end
rho_corr1=abs(rho_NLos1);
rho_corr1=rho_corr1/rho_corr1(1);
plot(q_diff,rho_corr1,'ro-.');

% Load data
load p=35_q_diff
% Plot
% for i=1:10
%     sum_NLos=0;
%     sigma1=f*1e9*(to_Los(i)-to_Los(i+1))+delta_f*to_Los(i+1);
%     rho_Los1(i)=(K/(K+1))*h_Los(i)*conj(h_Los(i+1))*exp(2j*pi*sigma1);
% %     for n=1:number_cluster(i)
% %         for nn=1:number_cluster(i+1)
%             n=1;nn=1;
%             for m=1:number_ray(n,i)
%                 for mm=1:number_ray(n,i+1)
%                     sigma2(m,mm,i)=f*1e9*(to_pq_nm(m,n,i)-to_pq_nm(mm,nn,i+1))+delta_f*to_pq_nm(mm,nn,i+1);
%                     sum_NLos = sum_NLos + P_remain_f*h_NLos(m,n,i)*conj(h_NLos(mm,nn,i+1))*exp(2j*pi*sigma2(m,mm,i));
%                 end
%             end
% %         end
% %     end
%     rho_NLos2(i)=(P_remain/(K+1))*mean(sum_NLos);
% end
for i=1:count
    sum_NLos=0;
    n=1;nn=1;
    for m=1:number_ray(n,1)
        for mm=1:number_ray(n,i)
            sigma2=f*1e9*(to_pq_nm(m,n,1)-to_pq_nm(mm,nn,i))+delta_f*to_pq_nm(mm,nn,i);
            sum_NLos = sum_NLos + P_remain_f*h_NLos(m,n,1)*conj(h_NLos(mm,nn,i))*exp(2j*pi*sigma2);
        end
    end
    rho_NLos2(i)=(P_remain/(K+1))*mean(sum_NLos);
end
rho_corr2=abs(rho_NLos2);
rho_corr2=rho_corr2/rho_corr2(1);
plot(q_diff,rho_corr2,'yo-.');

title('Spatial CCF');
xlabel('\Delta_{q}');
ylabel('Absolute value of spatial CCF');
legend('p=1, q=1','p=3, q=1','p=35, q=1');