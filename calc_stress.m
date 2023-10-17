function [S_xx,S_yy,S_xy] = calc_stress(lam,A,B,X,Y,s_0,mu)
% calculate stresses according to the analytic solution presented
% by Sagy and lyakhovsky (2019).

% create meshes (x = x, y = y, z = lam, A, B)
LAM = zeros(size(X,1),size(X,2),length(lam));
AA = zeros(size(LAM));
BB = zeros(size(LAM));
XX = zeros(size(LAM));
YY = zeros(size(LAM));

% create first terms
S0 = ones(size(X)) * s_0;
MU = ones(size(X)) * mu;

for count = 1:length(lam)
    LAM(:,:,count) = lam(count);
    AA(:,:,count) = A(count);
    BB(:,:,count) = B(count);
    XX(:,:,count) = X;
    YY(:,:,count) = Y;
end

% create summation term matricies
TX = exp(-LAM.*YY).*LAM.*(AA.*(LAM.*YY - 2).*cos(LAM.*XX) + BB.*(LAM.*YY - 2).*sin(LAM.*XX));
TY = exp(-LAM.*YY).*(LAM.^2.*YY).*(AA.*cos(LAM.*XX) + BB.*sin(LAM.*XX));
TXY = exp(-LAM.*YY).*LAM.*(AA.*(1 - LAM.*YY).*sin(LAM.*XX) + BB.*(LAM.*YY - 1).*cos(LAM.*XX));

% sums
S_xx = S0 + ((2*mu.^2.*s_0) .* sum(TX,3));
S_yy = S0 - ((2*MU.^2.*S0) .* sum(TY,3));
S_xy = -(MU.*S0) + ((2*MU.^2.*S0) .* sum(TXY,3));

end