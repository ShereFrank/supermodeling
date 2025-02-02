%--------------------------------------------------------------------------
%              读取原始数据，调用regress函数作一元线性回归
%--------------------------------------------------------------------------

%*****************************读取数据，绘制散点图***************************
ClimateData = xlsread('examp08_01.xls');    % 从Excel文件读取数据
x = ClimateData(:, 1);    % 提取ClimateData的第1列，即年平均气温数据
y = ClimateData(:, 5);    % 提取ClimateData的第5列，即全年日照时数数据
plot(x, y, 'k.', 'Markersize', 15)    % 绘制x和y的散点图
xlabel('年平均气温(x)')     % 给X轴加标签
ylabel('全年日照时数(y)')    % 给Y轴加标签


%*****************************计算相关系数**********************************
R = corrcoef(x, y)    %计算x和y的线性相关系数矩阵R


%***********************调用regress函数作一元线性回归************************
xdata = [ones(size(x, 1), 1), x];    % 在原始数据x的左边加一列1，即模型包含常数项
[b, bint, r, rint, s] = regress(y, xdata);    % 调用regress函数作一元线性回归
yhat = xdata*b;    % 计算y的估计值

% 定义元胞数组，以元胞数组形式显示系数的估计值和估计值的95%置信区间
head1 = {'系数的估计值','估计值的95%置信下限','估计值的95%置信上限'};
[head1; num2cell([b, bint])]

% 定义元胞数组，以元胞数组形式显示y的真实值、y的估计值、残差和残差的95%置信区间
head2 = {'y的真实值','y的估计值','残差','残差的95%置信下限','残差的95%置信上限'};
% 同时显示y的真实值、y的估计值、残差和残差的95%置信区间
[head2; num2cell([y, yhat, r, rint])]

% 定义元胞数组，以元胞数组形式显示判定系数、F统计量的观测值、检验的p值和误差方差的估计值
head3 = {'判定系数','F统计量的观测值','检验的p值','误差方差的估计值'};
[head3; num2cell(s)]


%*****************************绘制回归直线**********************************
plot(x, y, 'k.', 'Markersize', 15)    % 画原始数据散点
hold on
plot(x, yhat, 'linewidth', 3)    % 画回归直线
xlabel('年平均气温(x)')     % 给X轴加标签
ylabel('全年日照时数(y)')   % 给Y轴加标签
legend('原始散点','回归直线');    % 加标注框



%--------------------------------------------------------------------------
%              剔除异常数据，重新调用regress函数作一元线性回归
%--------------------------------------------------------------------------

%*******************************残差分析************************************
figure    % 新建一个图形窗口
rcoplot(r,rint)    %按顺序画出各组观测对应的残差和残差的置信区间

%******************剔除异常数据，重新计算相关系数矩阵*************************
xt = x(y<3000 & y>1250);    % 根据条件y<3000 & y>1250剔除异常数据
yt = y(y<3000 & y>1250);
figure    % 新建一个空的图形窗口
plot(xt, yt, 'ko')    % 画剔除异常数据后的散点图
xlabel('年平均气温(x)')    % 为X轴加标签
ylabel('全年日照时数(y)')   % 为Y轴加标签
Rt = corrcoef(xt, yt)    % 重新计算相关系数矩阵

%**********************重新调用regress函数作一元线性回归*********************
xtdata = [ones(size(xt, 1), 1),  xt];    % 在数据xt的左边加一列1
% 调用regress函数对处理后数据作一元线性回归
[b, bint, r, rint, s] = regress(yt, xtdata);
b    % 显示常数项和回归系数的估计值
s    % 显示判定系数 、 F统计量的观测值、 p值和误差方差的估计值
ythat = xtdata*b;    % 重新计算y的估计值

%*************************绘制两次回归分析的回归直线*************************
figure;    % 新建一个图形窗口
plot(x, y, 'ko');    % 画原始数据散点
hold on;    % 图形叠加
[xsort, id1] = sort(x);    % 为了画图的需要将x从小到大排序
yhatsort = yhat(id1);    % 将估计值yhat按x排序
plot(xsort, yhatsort, 'r--','linewidth',3);    % 画原始数据对应的回归直线，红色虚线
plot(xt, ythat, 'linewidth', 3);    % 画剔除异常数据后的回归直线，蓝色实线
legend('原始数据散点','原始数据回归直线','剔除异常数据后回归直线')    % 为图形加标注框
xlabel('年平均气温(x)');    % 为X轴加标签
ylabel('全年日照时数(y)');    % 为Y轴加标签