A = [22, 5;
    4, 11;
    13, 2];

B = [17, 9, 2, 1, 3;
    6, 4, 11, 9, 16];

C = [1, 0, 0;
    0, 1, 0;
    0, 0, 1];

D = A;
D(2, 1) = 1;
E = D * 3;
F = D';

G = B;
G(:, 3) = 3;
H = G;
H(:, [2, 4]) = [];
H = fliplr(H);

I = C;
I(:, 3) = [];
I(3, :) = [];

J = I;
J(2, 2) = -1;

K = D;
K(:, 2) = K(:, 2) * -1;

disp('Matrix A:');
disp(A);
disp('Matrix B:');
disp(B_old);
disp('Matrix C:');
disp(C);
disp('Matrix D');
disp(D);
disp('Matrix E');
disp(E);
disp('Matrix F');
disp(F);
disp('Matrix G');
disp(G);
disp('Matrix H');
disp(H);
disp('Matrix I');
disp(I);
disp('Matrix J');
disp(J);
disp('Matrix K');
disp(K);