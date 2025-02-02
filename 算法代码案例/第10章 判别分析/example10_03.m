%--------------------------------------------------------------------------
%               加载fisheriris.mat中数据，进行Fisher判别
%--------------------------------------------------------------------------

%********************************加载数据***********************************
load fisheriris    % 把文件fisheriris.mat中数据导入MATLAB工作空间


%**********************************待判样品*********************************
% 定义待判样品观测值矩阵x
x = [5.8	2.7	1.8	0.73
    5.6	3.1	3.8	1.8
    6.1	2.5	4.7	1.1
    6.1	2.6	5.7	1.9
    5.1	3.1	6.5	0.62
    5.8	3.7	3.9	0.13
    5.7	2.7	1.1	0.12
    6.4	3.2	2.4	1.6
    6.7	3	1.9	1.1
    6.8	3.5	7.9	1
    ];


%*********************************Fisher判别********************************
% 利用fisher函数进行判别，返回各种结果（见fisher函数的注释）
[outclass,TabCan,TabL,TabCon,TabM,TabG] = fisher(x,meas,species)


%************************绘制两个判别式得分的散点图**************************
% 利用fisher函数进行判别，返回各种结果，其中ts为判别式得分
[outclass,TabCan,TabL,TabCon,TabM,TabG,ts] = fisher(x,meas,species);
% 提取各类的判别式得分
ts1 = ts(ts(:,1) == 1,:);  % setosa类的判别式得分
ts2 = ts(ts(:,1) == 2,:);  % versicolor类的判别式得分
ts3 = ts(ts(:,1) == 3,:);  % virginica类的判别式得分
plot(ts1(:,2),ts1(:,3),'ko')  % setosa类的判别式得分的散点图
hold on
plot(ts2(:,2),ts2(:,3),'k*')  % versicolor类的判别式得分的散点图
plot(ts3(:,2),ts3(:,3),'kp')  % virginica类的判别式得分的散点图
legend('setosa类','versicolor类','virginica类');  %加标注框
xlabel('第一判别式得分');  %给X轴加标签
ylabel('第二判别式得分');  %给Y轴加标签



%************************只用一个判别式进行Fisher判别************************
% 令fisher函数的第4个输入为0.5，就可以只用一个判别式进行判别
[outclass,TabCan,TabL,TabCon,TabM,TabG] = fisher(x,meas,species,0.5)
