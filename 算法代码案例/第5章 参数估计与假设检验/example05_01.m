%--------------------------------------------------------------------------
%                         常见分布的参数估计
%--------------------------------------------------------------------------

% 例5.1
x = [15.14  14.81  15.11  15.26  15.08  15.17  15.12  14.95  15.05  14.87];    % 定义样本观测值向量
% 调用normfit函数求正态总体参数的最大似然估计和置信区间
% 返回总体均值的最大似然估计muhat和90%置信区间muci，
% 还返回总体标准差的最大似然估计sigmahat和90%置信区间sigmaci
[muhat,sigmahat,muci,sigmaci] = normfit(x,0.1)
