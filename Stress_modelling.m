%% parameters

% fault creation
lambda_vec = 100; % wavelength [m]
HL_ratio = 0.05;

% rock props
s_0 = 30; % [MPa]
mu=0.7;
cohesion = 20; % [MPa]

%% running script

% building fault surface--------------------------------------------
lam = 2.*pi./lambda_vec;
dx = min(lambda_vec)/1000; % cell spacing

xvector = (-1*max(lambda_vec)):dx:(1*max(lambda_vec)); % along-strike distance
M = rp_create_coeff_mat(xvector,lam);

A = lambda_vec.*HL_ratio/2;
B = zeros(size(A));

yvector = M*[A'; B']; % fault height

% calculating stresses-----------------------------------------------
% set up mesh
yvec = min(yvector):dx:(max(lambda_vec)/3); % mesh yvector
[X,Y] = meshgrid(xvector,yvec); % mesh using mesh yvector and along-strike xvector

% calc
[S_xx,S_yy,S_xy] = calc_stress(lam,A,B,X,Y,s_0,mu);
[S1,S2] = calc_principle_stresses(S_xx,S_yy,S_xy);
SD = (S1 - S2)*0.5;
[FR] = calc_fail_ratio(S1,S2,mu,cohesion);
[FR2] = calc_fail_ratio(S1,S2,0.3,cohesion);

% normalize
scaled_xy = (-S_xy - mu*s_0)./(mu*s_0);
scaled_xx = (S_xx - s_0)./(s_0);
scaled_yy = (S_yy - s_0)./(s_0);
scaled_sd = (SD - mu*s_0)./(mu*s_0);


%% plotting

% plot fault surface
figure;
plot(xvector,yvector)
xlabel('Along strike (m)')
ylabel('Distance from fault (m)')
grid on

% plot stresses
figure;
ax(3) = subplot(223);
plot_stress(scaled_xy,xvector,yvec,'\sigma_{xy}')

ax(4) = subplot(224);
% plot_FR(FR_shifted,xvector,yvec,yvector,lambda_vec)
plot_stress(scaled_sd,xvector,yvec,'\sigma_{d}')

ax(1) = subplot(221);
plot_stress(scaled_xx,xvector,yvec,'\sigma_{xx}')

ax(2) = subplot(222);
plot_stress(scaled_yy,xvector,yvec,'\sigma_{yy}')

linkaxes(ax,'xy')

% plot means
figure;
bx(1) = subplot(211);
a_stress = mean(abs(scaled_xy),2)*100;
plot(yvec,a_stress,'linewidth',2)
xlabel('Distance from fault (m)')
ylabel('Mean unsigned shear stress perturbation (%)')
grid on

% plot FR
bx(2) = subplot(212);
a_FR = max(FR,[],2);
plot(yvec,a_FR,'linewidth',2)
xlabel('Distance from fault (m)')
ylabel('Maximum Failure Ratio')
grid on

linkaxes(bx,'x')

set(gca,'xlim',[0 max(yvec)]);

% write to table and export
OO = array2table([yvec' a_stress a_FR],'VariableNames',{'Distance','mean_stress','max_FR'});


%% additional functions
function plot_stress(M,xvec,yvec,tag)
    imagesc(xvec,yvec,M*100);
    grid on
    h = colorbar;
    ylabel(h,sprintf('Normalized %s (%%)',tag));
    set(gca,'ydir','normal')
    xlabel('X - distance [m]')
    ylabel('Y - distance [m]')
    hold on
    
    color_lim =15;
    colormap jet
    set(gca,'clim',[-color_lim color_lim])

end

