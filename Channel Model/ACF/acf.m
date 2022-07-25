clc
clear all
close all

% Load data
load 300GHz_timediff.mat
%ACF

time=count;
t=linspace(0,delta_t*(time),time);
rho_corr=zeros(1,time);
rho_Los=zeros(1,time);rho_NLos=zeros(1,time);
% for i=1:time-1
%     sum_NLos=0;
%     sigma1=f*1e9*(to_Los(i)-to_Los(i+1))+delta_f*to_Los(i+1);
%     rho_Los(i)=(K/(K+1))*h_Los(i)*conj(h_Los(i+1))*exp(2j*pi*sigma1);
%     %for n=1:N
%         %for nn=1:N
%         n=1;nn=1;
%             for m=1:number_ray(n,i)
%                 for mm=1:number_ray(n,i+1)
%                     sigma2=f*1e9*(to_pq_nm(m,n,i)-to_pq_nm(mm,nn,i+1))+delta_f*to_pq_nm(mm,nn,i+1);
%                     sum_NLos = sum_NLos + P_remain_f*h_NLos(m,n,i)*conj(h_NLos(mm,nn,i+1))*exp(2j*pi*sigma2);
%                 end
%             end
%         %end
%     %end
%     rho_NLos1(i)=(P_remain/(K+1))*mean(sum_NLos);
%     
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
rho_corr1=abs(real(rho_NLos1));
rho_corr1=rho_corr1/rho_corr1(1);
plot(t,rho_corr1,'b.-.');
grid on
hold on

% Load data
load 350GHz_timediff.mat

% for i=1:time-1
%     sum_NLos=0;
%     sigma1=f*1e9*(to_Los(i)-to_Los(i+1))+delta_f*to_Los(i+1);
%     rho_Los(i)=(K/(K+1))*h_Los(i)*conj(h_Los(i+1))*exp(2j*pi*sigma1);
% %     for n=1:number_cluster(i)
% %         for nn=1:number_cluster(i+1)
%             n=1;nn=1;
%             for m=1:number_ray(n,i)
%                 for mm=1:number_ray(n,i+1)
%                     sigma2=f*1e9*(to_pq_nm(m,n,i)-to_pq_nm(mm,nn,i+1))+delta_f*to_pq_nm(mm,nn,i+1);
%                     sum_NLos = sum_NLos + P_remain_f*h_NLos(m,n,i)*conj(h_NLos(mm,nn,i+1))*exp(2j*pi*sigma2);
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
rho_corr2=abs(real(rho_NLos2));
rho_corr2=rho_corr2/rho_corr2(1);
plot(t,rho_corr2,'r.-.');
title('ACF');
xlabel('time diffirent \Delta_{t}(s)');
ylabel('Value of ACF');
legend('Simulation at 300Ghz','Simulation at 350Ghz');
