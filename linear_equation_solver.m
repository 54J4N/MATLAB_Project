% Generate random coefficient matrix A and constant vector b
A = rand(1000);
b = rand(1000, 1);

% Solve the system of linear equations
x = A \ b;

% Display the solution
disp('Solution vector x:');
disp(x);

% Save the solution vector to a MAT file
save('solution.mat', 'x');
