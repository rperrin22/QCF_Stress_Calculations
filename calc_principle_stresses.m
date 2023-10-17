function [S1,S2] = calc_principle_stresses(S_xx,S_yy,S_xy)
S1 = ((S_xx + S_yy)/2)+sqrt(((S_xx - S_yy)/2).^2 + S_xy.^2);
S2 = ((S_xx + S_yy)/2)-sqrt(((S_xx - S_yy)/2).^2 + S_xy.^2);
end