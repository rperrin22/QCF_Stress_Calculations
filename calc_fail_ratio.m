function [FR] = calc_fail_ratio(S1,S2,mu,C)
FR = S1 ./ ((S2) + (2*(C + mu*S2)*sqrt(1 + mu^2)) + (mu));
end