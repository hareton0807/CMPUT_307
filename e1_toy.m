clear all;
close all;

% Generate random spherical coordinates(radial, azimuthal, polar)
N = 5000;
radial = 8*(rand(N,1));
azimuthal = 2*pi*rand(N,1);
polar = pi*rand(N,1);

% Convert to cartesian
x = radial.*cos(azimuthal).*sin(polar);
y = radial.*sin(azimuthal).*sin(polar);
z = radial.*cos(polar);

% Convert to Homogeneous Coordinate
row = rand(1,N);
row(1:N) = 1;
sphere = [x.'; y.'; z.'; row];

% 3D Translation, on Original Sphere
M1 = [1 0 0 20; 0 1 0 20; 0 0 1 20; 0 0 0 1];
size(M1)
sphere_M1 = M1 * sphere;

% 3D Translation with Non-uniform scaling, on Original Sphere
M2 = [2 0 0 0; 0 4 0 0; 0 0 2 0; 0 0 0 1];
size(M2)
sphere_M2 = M2 * sphere_M1;

% 3D Rotations on Sphere M2
theta1 = pi/2;
theta2 = pi/3;
theta3 = pi/4;
R_X = [1 0 0 0; 0 cos(theta1) -sin(theta1) 0; 0 sin(theta1) cos(theta1) 0; 0 0 0 1];
R_Y = [cos(theta2) 0 sin(theta2) 0; 0 1 0 0; -sin(theta2) 0 cos(theta2) 0; 0 0 0 1];
R_Z = [cos(theta3) -sin(theta3) 0 0; sin(theta3) cos(theta3) 0 0; 0 0 1 0; 0 0 0 1];
sphere_R = R_Z * R_Y * R_X * sphere_M2;

% Composite Transformation
sphere_M = R_Z * R_Y * R_X * M2 * M1 * sphere;

% Check the norm after applying two equivalent transformations
fprintf('Norm: %i\n', norm(sphere_R - sphere_M))

% plot
figure(1)
hold on;
view(3);
scatter3(x, y, z, 2, 'filled', 'r')
scatter3(sphere_M1(1,:), sphere_M1(2,:), sphere_M1(3,:), 2, 'filled', 'b')
scatter3(sphere_M2(1,:), sphere_M2(2,:), sphere_M2(3,:), 2, 'filled', 'y')
scatter3(sphere_R(1,:), sphere_R(2,:), sphere_R(3,:), 2, 'filled', 'g')
scatter3(sphere_M(1,:), sphere_M(2,:), sphere_M(3,:), 2, 'filled', 'p')
axis vis3d equal
grid on;
xlabel X, ylabel Y, zlabel Z
hold off;
