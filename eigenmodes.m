clc, close all, clear all

%% Eigenmodes undamped

omega = [-111.89,-631.8,-693.1,-1310.17,111.89,631.8,693.1,1310.17,-162.63,162.63];
mode = [-0.0371,-0.2731,-0.2768,0,-0.9205;0.9942,-0.0096,-0.0530,0,0.0935; 0.0576,-0.0898,0.014,0,-0.9942;0.0023,-0.0585,0.198,0,0.9785;
        -0.0371,-0.2731,-0.2768,0,-0.9205;0.9942,-0.0096,-0.0530,0,0.0935; 0.0576,-0.0898,0.014,0,-0.9942;0.0023,-0.0585,0.198,0,0.9785;
        0,0,0,-1,0;0,0,0,-1,0];
for k=1:length(omega)
    f = @(t,y) [y(6:10);-omega(k)^2*y(1:5)];
    [tsim,ysim] = ode45(f,[0,2],[mode(k,:),0,0,0,0,0]);
    figure
    plot(tsim,ysim)
    legend('x_1','x_2','x_3','y_4','\theta')
    plottitle = strcat('Vibration modes for \omega_{',num2str(k),"}");
    title(plottitle)
    F = gcf;
    filename = strcat("Figures\Eigenmode_undamped_",num2str(k));
    saveas(F,filename,"png")
    close all
end
    %% Eigenmodes damped
omega_d = [0.563,0.411,0.231,0.790, 0.081];
mode_d = [0,0,0,-8.397+0.5431*1i,0;0.003+0.0359*1i,-0.2206+0.1545*1i,-0.2236+0.1569*1i,0,-0.7677+0.5121*1i;
        
        0,0,0,-1,0;0,0,0,-1,0];
 

