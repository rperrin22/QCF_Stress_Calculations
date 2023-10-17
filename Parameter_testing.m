%% test wavelength
% test vector
testvec = linspace(5,1000,50);

% fault creation
HL_ratio = 0.05;

% rock props
s_0 = 30; % [MPa]
mu=0.7;
cohesion = 20; % [MPa]

% plotting yvec
yvec_plot = linspace(0,300,500);
plot_mat_sxy = zeros(length(yvec_plot),length(testvec));
plot_mat_fr = zeros(length(yvec_plot),length(testvec));

for count = 1:length(testvec)
    lambda_vec = testvec(count);
    [S_xx,S_yy,S_xy,S1,S2,FR,scaled_xy,scaled_xx,scaled_yy,yyvec] = Calc_stresses_yo(lambda_vec,HL_ratio,s_0,mu,mu,cohesion);
    asdf_xy = mean(abs(scaled_xy),2)*100;
    asdf_fr = max(FR,[],2);

    plot_mat_sxy(:,count) = interp1(yyvec,asdf_xy,yvec_plot,'linear',0);
    plot_mat_fr(:,count) = interp1(yyvec,asdf_fr,yvec_plot,'linear',0);

end

figure;
ax(1) = subplot(121);
contourf(testvec,(yvec_plot),plot_mat_sxy,25,'edgecolor','none')
tempX = testvec;
tempY = yvec_plot;
tempZ = plot_mat_sxy;
grd_write(tempZ,min(tempX),max(tempX),min(tempY),max(tempY),'sxy_wavelength.grd');

xlabel('Wavelength (m)')
ylabel({'Distance';'from fault (m)'})
h = colorbar('southoutside');
xlabel(h,'Mean stress perturb (%)','FontName','Times new roman','FontWeight','Bold')
set(gca,'ydir','normal')
%grid on
set(gca,'clim',[-7.5 7.5])
hold on
plot([min(testvec) max(testvec)],[.16*min(testvec) .16*max(testvec)],'k:','linewidth',3)

ax(2) = subplot(122);
contourf(testvec,(yvec_plot),plot_mat_fr,25,'edgecolor','none')
tempX = testvec;
tempY = yvec_plot;
tempZ = plot_mat_fr;
grd_write(tempZ,min(tempX),max(tempX),min(tempY),max(tempY),'FR_wavelength.grd');
xlabel('Wavelength (m)')
%ylabel({'Distance';'from fault (m)'})
% set(gca,'ytick',[]);
h = colorbar('southoutside');
xlabel(h,'Maximum failure ratio','FontName','Times new roman','FontWeight','Bold')
set(gca,'ydir','normal')
%grid on
set(gca,'clim',[0.5 1])
hold on
plot([min(testvec) max(testvec)],[.16*min(testvec) .16*max(testvec)],'k:','linewidth',3)

% make colormap
rbg_map1 = colorcet('D09');
rbg = colorcet('L18');

colormap(ax(1),rbg_map1);
colormap(ax(2),rbg);

% fontsize(14,'points')
set(findobj(gcf,'type','axes'),'FontName','Times new roman','FontSize',12,'FontWeight','Bold')

%% test HL_ratio
% test vector
testvec = linspace(0.001,0.1,50);

% fault creation
lambda_vec = 100; % wavelength [m]

% rock props
s_0 = 30; % [MPa]
mu=0.7;
cohesion = 20; % [MPa]

% plotting yvec
yvec_plot = linspace(0,lambda_vec/3,200);
plot_mat_sxy = zeros(length(yvec_plot),length(testvec));
plot_mat_fr = zeros(length(yvec_plot),length(testvec));

for count = 1:length(testvec)
    HL_ratio = testvec(count);
    [S_xx,S_yy,S_xy,S1,S2,FR,scaled_xy,scaled_xx,scaled_yy,yyvec] = Calc_stresses_yo(lambda_vec,HL_ratio,s_0,mu,mu,cohesion);
    asdf_xy = mean(abs(scaled_xy),2)*100;
    asdf_fr = max(FR,[],2);

    plot_mat_sxy(:,count) = interp1(yyvec,asdf_xy,yvec_plot,'linear','extrap');
    plot_mat_fr(:,count) = interp1(yyvec,asdf_fr,yvec_plot,'linear','extrap');

end

figure;
ax(1) = subplot(421);
contourf(testvec,(yvec_plot./lambda_vec)*100,plot_mat_sxy,25,'edgecolor','none')
tempX = testvec;
tempY = (yvec_plot./lambda_vec)*100;
tempZ = plot_mat_sxy;
grd_write(tempZ,min(tempX),max(tempX),min(tempY),max(tempY),'sxy_HL.grd');
xlabel('H/L')
ylabel({'Normalized Distance';'from fault (%)'})
% h = colorbar;
% ylabel(h,'Mean stress perturb (%)','FontName','Times new roman','FontWeight','Bold')
set(gca,'ydir','normal')
% grid on
set(gca,'clim',[-7.5 7.5])
hold on
plot([min(testvec) max(testvec)],[16 16],'k:','linewidth',3)

ax(2) = subplot(422);
contourf(testvec,(yvec_plot./lambda_vec)*100,plot_mat_fr,25,'edgecolor','none')
tempX = testvec;
tempY = (yvec_plot./lambda_vec)*100;
tempZ = plot_mat_fr;
grd_write(tempZ,min(tempX),max(tempX),min(tempY),max(tempY),'FR_HL.grd');
xlabel('H/L')
%ylabel({'Normalized Distance';'from fault (%)'})
% h = colorbar;
% ylabel(h,'Maximum failure ratio','FontName','Times new roman','FontWeight','Bold')
set(gca,'ydir','normal')
% grid on
set(gca,'clim',[0.5 1])
hold on
plot([min(testvec) max(testvec)],[16 16],'k:','linewidth',3)
colormap hsv



% test s_0
% test vector
testvec = linspace(10,50,50);

% fault creation
lambda_vec = 100; % wavelength [m]
HL_ratio = 0.05;

% rock props
mu=0.7;
cohesion = 20; % [MPa]

% plotting yvec
yvec_plot = linspace(0,lambda_vec/3,200);
plot_mat_sxy = zeros(length(yvec_plot),length(testvec));
plot_mat_fr = zeros(length(yvec_plot),length(testvec));

for count = 1:length(testvec)
    s_0 = testvec(count);
    [S_xx,S_yy,S_xy,S1,S2,FR,scaled_xy,scaled_xx,scaled_yy,yyvec] = Calc_stresses_yo(lambda_vec,HL_ratio,s_0,mu,mu,cohesion);
    asdf_xy = mean(abs(scaled_xy),2)*100;
    asdf_fr = max(FR,[],2);

    plot_mat_sxy(:,count) = interp1(yyvec,asdf_xy,yvec_plot,'linear','extrap');
    plot_mat_fr(:,count) = interp1(yyvec,asdf_fr,yvec_plot,'linear','extrap');

end

ax(3) = subplot(423);
contourf(testvec,(yvec_plot./lambda_vec)*100,plot_mat_sxy,25,'edgecolor','none')
tempX = testvec;
tempY = (yvec_plot./lambda_vec)*100;
tempZ = plot_mat_sxy;
grd_write(tempZ,min(tempX),max(tempX),min(tempY),max(tempY),'sxy_S0.grd');
xlabel('\sigma_0 (MPa)')
ylabel({'Normalized Distance';'from fault (%)'})
% h = colorbar;
% ylabel(h,'Mean stress perturb (%)','FontName','Times new roman','FontWeight','Bold')
set(gca,'ydir','normal')
% grid on
set(gca,'clim',[-7.5 7.5])
hold on
plot([min(testvec) max(testvec)],[16 16],'k:','linewidth',3)

ax(4) = subplot(424);
contourf(testvec,(yvec_plot./lambda_vec)*100,plot_mat_fr,25,'edgecolor','none')
tempX = testvec;
tempY = (yvec_plot./lambda_vec)*100;
tempZ = plot_mat_fr;
grd_write(tempZ,min(tempX),max(tempX),min(tempY),max(tempY),'FR_S0.grd');
xlabel('\sigma_0 (MPa)')
%ylabel({'Normalized Distance';'from fault (%)'})
% h = colorbar;
%ylabel(h,'Maximum failure ratio','FontName','Times new roman','FontWeight','Bold')
set(gca,'ydir','normal')
% grid on
set(gca,'clim',[0.5 1])
hold on
plot([min(testvec) max(testvec)],[16 16],'k:','linewidth',3)
colormap hsv



% test mu
% test vector
testvec = linspace(0.3,0.8,50);

% fault creation
lambda_vec = 100; % wavelength [m]
HL_ratio = 0.05;

% rock props
s_0 = 30; % [MPa]
mu_surf=0.7;
cohesion = 20; % [MPa]

% plotting yvec
yvec_plot = linspace(0,lambda_vec/3,200);
plot_mat_sxy = zeros(length(yvec_plot),length(testvec));
plot_mat_fr = zeros(length(yvec_plot),length(testvec));

for count = 1:length(testvec)
    mu = testvec(count);
    [S_xx,S_yy,S_xy,S1,S2,FR,scaled_xy,scaled_xx,scaled_yy,yyvec] = Calc_stresses_yo(lambda_vec,HL_ratio,s_0,mu,mu_surf,cohesion);
    asdf_xy = mean(abs(scaled_xy),2)*100;
    asdf_fr = max(FR,[],2);

    plot_mat_sxy(:,count) = interp1(yyvec,asdf_xy,yvec_plot,'linear','extrap');
    plot_mat_fr(:,count) = interp1(yyvec,asdf_fr,yvec_plot,'linear','extrap');

end

ax(5) = subplot(425);
contourf(testvec,(yvec_plot./lambda_vec)*100,plot_mat_sxy,25,'edgecolor','none')
tempX = testvec;
tempY = (yvec_plot./lambda_vec)*100;
tempZ = plot_mat_sxy;
grd_write(tempZ,min(tempX),max(tempX),min(tempY),max(tempY),'sxy_mu.grd');
xlabel('\mu')
ylabel({'Normalized Distance';'from fault (%)'})
% h = colorbar;
% ylabel(h,'Mean stress perturb (%)','FontName','Times new roman','FontWeight','Bold')
set(gca,'ydir','normal')
% grid on
set(gca,'clim',[-7.5 7.5])
hold on
plot([min(testvec) max(testvec)],[16 16],'k:','linewidth',3)

ax(6) = subplot(426);
contourf(testvec,(yvec_plot./lambda_vec)*100,plot_mat_fr,25,'edgecolor','none')
tempX = testvec;
tempY = (yvec_plot./lambda_vec)*100;
tempZ = plot_mat_fr;
grd_write(tempZ,min(tempX),max(tempX),min(tempY),max(tempY),'FR_mu.grd');
xlabel('\mu')
%ylabel({'Normalized Distance';'from fault (%)'})
% h = colorbar;
% ylabel(h,'Maximum failure ratio','FontName','Times new roman','FontWeight','Bold')
set(gca,'ydir','normal')
% grid on
set(gca,'clim',[0.5 1])
hold on
plot([min(testvec) max(testvec)],[16 16],'k:','linewidth',3)
colormap hsv

% test cohesion
% test vector
testvec = linspace(15,40,50);

% fault creation
lambda_vec = 100; % wavelength [m]
HL_ratio = 0.05;

% rock props
s_0 = 30; % [MPa]
mu=0.7;
cohesion = 20; % [MPa]

% plotting yvec
yvec_plot = linspace(0,lambda_vec/3,200);
plot_mat_sxy = zeros(length(yvec_plot),length(testvec));
plot_mat_fr = zeros(length(yvec_plot),length(testvec));

for count = 1:length(testvec)
    cohesion = testvec(count);
    [S_xx,S_yy,S_xy,S1,S2,FR,scaled_xy,scaled_xx,scaled_yy,yyvec] = Calc_stresses_yo(lambda_vec,HL_ratio,s_0,mu,mu,cohesion);
    asdf_xy = mean(abs(scaled_xy),2)*100;
    asdf_fr = max(FR,[],2);

    plot_mat_sxy(:,count) = interp1(yyvec,asdf_xy,yvec_plot,'linear','extrap');
    plot_mat_fr(:,count) = interp1(yyvec,asdf_fr,yvec_plot,'linear','extrap');

end

ax(7) = subplot(427);
contourf(testvec,(yvec_plot./lambda_vec)*100,plot_mat_sxy,25,'edgecolor','none')
tempX = testvec;
tempY = (yvec_plot./lambda_vec)*100;
tempZ = plot_mat_sxy;
grd_write(tempZ,min(tempX),max(tempX),min(tempY),max(tempY),'sxy_C.grd');
xlabel('C (MPa)')
ylabel({'Normalized Distance';'from fault (%)'})
originalSize1 = get(gca,'Position');
h = colorbar('southoutside');
h.Position = h.Position + [0 -0.1 0 0];
xlabel(h,'Mean stress perturb (%)','FontName','Times new roman','FontWeight','Bold')
set(gca,'ydir','normal')
% grid on
set(gca,'clim',[-7.5 7.5])
hold on
plot([min(testvec) max(testvec)],[16 16],'k:','linewidth',3)
% set(ax(7),'Position',originalSize1);

ax(8) = subplot(428);
contourf(testvec,(yvec_plot./lambda_vec)*100,plot_mat_fr,25,'edgecolor','none')
tempX = testvec;
tempY = (yvec_plot./lambda_vec)*100;
tempZ = plot_mat_fr;
grd_write(tempZ,min(tempX),max(tempX),min(tempY),max(tempY),'FR_C.grd');
xlabel('C (MPa)')
%ylabel({'Normalized Distance';'from fault (%)'})
h = colorbar('southoutside');
h.Position = h.Position + [0 -0.1 0 0];
xlabel(h,'Maximum failure ratio','FontName','Times new roman','FontWeight','Bold')
set(gca,'ydir','normal')
% grid on
set(gca,'clim',[0.5 1])
hold on
plot([min(testvec) max(testvec)],[16 16],'k:','linewidth',3)


colormap(ax(1),rbg_map1);
colormap(ax(2),rbg);

colormap(ax(3),rbg_map1);
colormap(ax(4),rbg);

colormap(ax(5),rbg_map1);
colormap(ax(6),rbg);

colormap(ax(7),rbg_map1);
colormap(ax(8),rbg);

% fontsize(12,'points')
set(findobj(gcf,'type','axes'),'FontName','Times new roman','FontSize',12,'FontWeight','Bold')
