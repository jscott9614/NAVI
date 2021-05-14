function []=AerialPlot(u1, v1, u2, v2, xyz)
% written by Jeremiah Scott
% Mar. 13, 2021
% to be used after having received the output from "DLT_Frames.m"
% for the purpose of taking two pictures from different vantage points and
% creating a virtual 3-D environment
% if at first this code throws an error, be sure to have
% "DLT_workspace.mat" loaded

[L,R,P] = DLT_Demo(u1, v1, u2, v2);

x = P(:,1);
y = -P(:,3);

X = xyz(:,1);
Y = -xyz(:,3);

% Generate 3D stem plot
% Also specify marker size, type, and color, and line width
for i=1:length(X)
    a = 28 + Y(i);
    b = 120 - X(i);

    figure
    plot(a,b,'o','Color','r');
    hold on;
    plot(0,0,'*','Color','b');
    hold off;
    axis([-100 100 -150 150]);
    d = sqrt((120 - X(i))^2 + (-28 - Y(i))^2);
    title(['Time = ' num2str(i) ' sec;  Distance = ' num2str(d) ' inches']);
    legend('Detected Object','Your Vessel','Location','south');

    % Set axes so major grids are equal in size
    axis equal
    % Turn on grid
    grid on
    
    fileName = ['F' sprintf('%03d',i) '.jpg'];
    saveas(gcf,fileName);
end