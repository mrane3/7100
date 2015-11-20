function [thres] = myMedianThres(nvt, order, lambda)
thres=lambda + medfilt1(nvt,order);
% fig(1);
% plot(nvt);
% hold on;
% plot(thres);
% hold on;


