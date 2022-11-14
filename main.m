clc, close all, clear all
variables
%% State space approach
Q = [-k_1,-c_1;0,0;0,0;0,0;0,0;];
M_inv = inv(M);
A = [zeros([5,5]),eye(5); -M_inv*K,-M_inv*C];
B = [zeros([5,2]);M_inv*Q];
% C = [eye(5),zeros([5,5])];
D = 0;
% sys = ss(A,B,C,D);




%% Define and simulate differential equations

A_undamped = [zeros([5,5]),eye(5); -M_inv*K,-M_inv*0];
A_damped =   [zeros([5,5]),eye(5); -M_inv*K,-M_inv*C];
f_damped = @(t,x) [A_damped *x]; % define function f(t,y)
f_undamped = @(t,x) [A_undamped *x]; % define function f(t,y)

x_0 = [0,0,0,m_3*g/k_5,pi/2,0,0,0,0,0]';
t0=0;
T=5;
[ts_damped,ys_damped] = ode45(f_damped,[t0,T],x_0);
[ts_undamped,ys_undamped] = ode45(f_undamped,[t0,T],x_0);

% close all
% plot(ts,ys(:,1:5))
% legend('x_1','x_2','x_3','y_4','theta')
%% show the configuration
close all
h=1;
s=1;
y4=0;
tic
ys=ys_damped;
for j=1:floor(length(ys_damped))/100
    i=100*j;
    x1=ys(i,1)*100;
    x2=ys(i,2)*100;
    x3=ys(i,3)*100;
    x4=ys(i,4)*100;
    x5=ys(i,5);
        
    X_1=s*[-1,1,1,-1,-1]+(x1)*[1,1,1,1,1];
    Y=h*[1,1,-1,-1,1];
    X_2=s*[-1,1,1,-1,-1]+(x2+3)*[1,1,1,1,1];
    
    X_3=s*[-1,1,1,-1,-1]+(x3+6)*[1,1,1,1,1];

    X_4 = [0,   5*s*cos(x5),    5*s*cos(x5)-s*sin(x5),  -s*sin(x5),  0]+(x3+6)*[1,1,1,1,1];
    Y_l = [0,   5*s*sin(x5),    5*s*sin(x5)+s*cos(x5),  s*cos(x5),  0]+y4*[1,1,1,1,1];
    X_baseline = [-5,8];
    Y_baseline = [-3,-3];



    plot(X_1,Y,Color="b")
    hold on
    plot(X_baseline,Y_baseline)
    plot(X_2,Y,Color="b")
    
    plot(X_4,Y_l,Color="b")
    domain = [-5,15,-10,10];
    title('system at time = ',ts_damped(i))
    axis(domain)
    axis equal
    F_damped(j) = getframe;
    close all
    
end

toc

ys=ys_undamped;
for j=1:floor(length(ys_undamped))/100
    i=100*j;
    
    x1=ys(i,1)*100;
    x2=ys(i,2)*100;
    x3=ys(i,3)*100;
    x4=ys(i,4)*100;
    x5=ys(i,5);
        
    X_1=s*[-1,1,1,-1,-1]+(x1)*[1,1,1,1,1];
    Y=h*[1,1,-1,-1,1];
    X_2=s*[-1,1,1,-1,-1]+(x2+3)*[1,1,1,1,1];
    
    X_3=s*[-1,1,1,-1,-1]+(x3+6)*[1,1,1,1,1];

    X_4 = [0,   5*s*cos(x5),    5*s*cos(x5)-s*sin(x5),  -s*sin(x5),  0]+(x3+6)*[1,1,1,1,1];
    Y_l = [0,   5*s*sin(x5),    5*s*sin(x5)+s*cos(x5),  s*cos(x5),  0]+y4*[1,1,1,1,1];
    X_baseline = [-5,8];
    Y_baseline = [-3,-3];



    plot(X_1,Y,Color="b")
    hold on
    plot(X_baseline,Y_baseline)
    plot(X_2,Y,Color="b")
    
    plot(X_4,Y_l,Color="b")
    domain = [-5,15,-10,10];
    title('system at time = ',ts_undamped(i ))
    axis(domain)
    axis equal
    F_undamped(j) = getframe;
    close all
    
end

toc

%%
movie(F_undamped)

