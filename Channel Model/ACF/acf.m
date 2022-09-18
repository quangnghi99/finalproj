clc
clear all
close all

% 300Ghz
load 300GHz_timediff.mat
%ACF

time=count;
t=linspace(0,delta_t*(time),time-1);
rho_corr=zeros(1,time);
rho_Los=zeros(1,time);rho_NLos=zeros(1,time);
for i=1:count-1
    sum_NLos=0;
    n=1;nn=1;
    for m=1:number_ray(n,1)
        for mm=1:number_ray(n,i)
            sigma2=f*1e9*(to_pq_nm(m,n,i)-to_pq_nm(mm,nn,i+1))+delta_f*to_pq_nm(mm,nn,i+1);
            sum_NLos = sum_NLos + P_remain_f*h_NLos(m,n,i)*conj(h_NLos(mm,nn,i+1))*exp(2j*pi*sigma2);
        end
    end
    rho_NLos1(i)=(P_remain/(K+1))*mean(sum_NLos);
end
rho_corr1=abs(real(rho_NLos1));
rho_corr=rho_corr1/rho_corr1(1);
plot(t,rho_corr,'b.-.');
grid on
hold on

% 350Ghz
load 350GHz_timediff.mat
for i=1:count-1
    sum_NLos=0;
    n=1;nn=1;
    for m=1:number_ray(n,1)
        for mm=1:number_ray(n,i)
            sigma2=f*1e9*(to_pq_nm(m,n,i)-to_pq_nm(mm,nn,i+1))+delta_f*to_pq_nm(mm,nn,i+1);
            sum_NLos = sum_NLos + P_remain_f*h_NLos(m,n,i)*conj(h_NLos(mm,nn,i+1))*exp(2j*pi*sigma2);
        end
    end
    rho_NLos2(i)=(P_remain/(K+1))*mean(sum_NLos);
end
rho_corr2=abs(real(rho_NLos2));
rho_corr=rho_corr2/rho_corr2(1);
plot(t,rho_corr,'r.-.');
title('ACF');
xlabel('time diffirent \Delta_{t}(s)');
ylabel('Value of ACF');
legend('Simulation at 300Ghz','Simulation at 350Ghz');
