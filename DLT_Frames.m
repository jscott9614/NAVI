function [xyz] = DLT_Frames(u1, v1, u2, v2)
% written by Jeremiah Scott
% Mar. 13, 2021
% for the purpose of taking two pictures from different vantage points and
% creating a virtual 3-D environment
% if at first this code throws an error, be sure to have
% "DLT_workspace.mat" loaded

points = 15;

% points = 15; A1 = imread('L095.jpg');
% image(A1); axis image; [u1, v1] = ginput(points);
%collects 15 data points from 15 mouse clicks

% points = 15; A2 = imread('R050.jpg');
% image(A2); axis image; [u2, v2] = ginput(points);
%collects 15 data points from 15 mouse clicks

[L,R] = DLT_Demo(u1, v1, u2, v2);
% This accesses the calibration points that were used for the environment

i = 0;
for index = 127:24:800
    
    i = i+1;
    
    A1 = imread(['L' sprintf('%03d',index+45) '.jpg']);
    image(A1); axis image; [a1(i), b1(i)] = ginput(1);
    
    A1 = imread(['R' sprintf('%03d',index) '.jpg']);
    image(A1); axis image; [a2(i), b2(i)] = ginput(1);
    
    D(1,:) = [L(1)-L(9)*a1(i), L(2)-L(10)*a1(i), L(3)-L(11)*a1(i)];
    D(2,:) = [L(5)-L(9)*b1(i), L(6)-L(10)*b1(i), L(7)-L(11)*b1(i)];
    D(3,:) = [R(1)-R(9)*a2(i), R(2)-R(10)*a2(i), R(3)-R(11)*a2(i)];
    D(4,:) = [R(5)-R(9)*b2(i), R(6)-R(10)*b2(i), R(7)-R(11)*b2(i)];
    %Calculations to populate matrix D solve for the location of the point
    %of interest
    
    f = [a1(i)-L(4); b1(i)-L(8); a2(i)-R(4); b2(i)-R(8)];
    % output vector for [D][xyz]=[f]
    
    % Solve for the unknown point (vector xyz)
    xyz(i,:) = (inv(D' * D) * D' * f)';
    
    %after completing the loop xyz ends up as a matrix of size 29x3 column
    %1 is x, column 2 is y, column 3 is z
end
end