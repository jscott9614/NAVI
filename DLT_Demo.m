function [L,R,P] = DLT_Demo(u1, v1, u2, v2)
% written by Jeremiah Scott
% Mar. 13, 2021
% for the purpose of taking two pictures from different vantage points and
% creating a virtual 3-D environment
points = 15;

% points = 15; A1 = imread('L095.jpg');
% image(A1); axis image; [u1, v1] = ginput(points);
%collects 15 data points from 15 mouse clicks

% points = 15; A2 = imread('R050.jpg');
% image(A2); axis image; [u2, v2] = ginput(points);
%collects 15 data points from 15 mouse clicks

%P = zeros(points,3);
T = readtable('DLT_Data.csv');      % measured in inches

P = table2array(T);
P = [P(1:7,:); P(9:13,:); P(15:17,:)];

%Initialize vectors and matrices
M1 = zeros(2*points,11);
M2 = zeros(2*points,11);
g1 = zeros(2*points,1);
g2 = zeros(2*points,1);

% Populate Matrix M1 and output vector g1 of 2D coordinates
counter1 = 1;
counter2 = 1;
for i=1:2*points
    if (rem(i,2) == 1)
        g1(i) = u1(counter1);
        M1(i,:) = [P(counter1,:) 1 0 0 0 0 -u1(counter1)*P(counter1,:)];
        counter1 = counter1 + 1;
    else % if (rem(i,2) == 0))
        g1(i) = v1(counter2);
        M1(i,:) = [0 0 0 0 P(counter2,:) 1 -v1(counter2)*P(counter2,:)];
        counter2 = counter2 + 1;
    end
end

%Solve for L by multiplying by an inverted matrix
L = inv(M1' * M1)* M1' * g1;

% Populate Matrix M2 and output vector g2 of 2D coordinates
counter1 = 1;
counter2 = 1;
for i=1:2*points
    if (rem(i,2) == 1)
        g2(i) = u2(counter1);
        M2(i,:) = [P(counter1,:) 1 0 0 0 0 -u2(counter1)*P(counter1,:)];
        counter1 = counter1 + 1;
    else % if (rem(i,2) == 0))
        g2(i) = v2(counter2);
        M2(i,:) = [0 0 0 0 P(counter2,:) 1 -v2(counter2)*P(counter2,:)];
        counter2 = counter2 + 1;
    end
end

%Solve for R by multiplying by an inverted matrix
R = inv(M2' * M2)* M2' * g2;

end