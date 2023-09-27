function [beta]=SR(X,y)
% Sparse representation 
% call Homotopy algorithm
lambda=1.e-2;
tolerance=1.e-3;
[beta, ~] = SolveHomotopy(X, y, 'lambda',lambda,'tolerance',tolerance);
end
