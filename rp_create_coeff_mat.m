function [M] = rp_create_coeff_mat(xvec,lam)
% [M] = rp_create_coeff_mat(xvec,lam)
% Creates coefficient matrix for Fourier Series analysis
%  
%     xvec - x locations for sample points
%     lam - vector of wavenumbers used for the analysis
%

M = zeros(length(xvec),length(lam)*2);
for count = 1:length(xvec)
    for counter = 1:length(lam)
        M(count,counter) = cos(lam(counter)*xvec(count));
        M(count,counter+length(lam)) = sin(lam(counter)*xvec(count));
    end
end

end