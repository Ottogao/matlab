function [nx ny ] = generateNodePosition(N, X, Y) 
nx = rand(1, N)*X;    % node coordinates
    ny = rand(1, N)*Y;
    nx(1) = X/2;        % set sink in the center of the area.
    ny(1) = Y/2;