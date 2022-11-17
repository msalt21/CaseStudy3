%Part 1

%Simulate the rays originating from two points on an object: one at (𝑥, 𝑦, 𝑧) = 
% (0, 0, 0) and the other at (𝑥, 𝑦, 𝑧) = (10, 0, 0) mm. 
% 
% For each point, simulate rays at several small angles, e.g., 5 rays with angles 𝜃𝑥 
% between −𝜋/20 rad and 𝜋/20 rad. 
% Let 𝑦 = 0 and 𝜃𝑦 = 0 for all rays in your simulation.

x1_origin = 0;
y1_origin = 0;
z1_origin = 0;

x2_origin = 0.01;
y2_origin = 0;
z3_origin = 0;

thetax_1 = [-pi/20 -pi/40 pi/20 pi/40 pi/1500];
thetay_1 = 0;

d = 0.2;

rays_in_1 = zeros(4,5); 
rays_in_1(2,:) = thetax_1;

rays_in_2 = zeros(4,5);
rays_in_2(1,:) = x2_origin;
rays_in_2(2,:) = thetax_1;


transfer_m = [1 d 0 0;
              0 1 0 0;
              0 0 1 d;
              0 0 0 1];

figure, hold on

rays_out_1 = transfer_m*rays_in_1;
rays_out_2 = transfer_m*rays_in_2;


%Plot Ray 1
ray_z_1 = [zeros(1,size(rays_in_1,2)); d*ones(1,size(rays_in_1,2))];
plot(ray_z_1, [rays_in_1(1,:); rays_out_1(1,:)],'-b');

%Plot Ray 1
ray_z_2 = [zeros(1,size(rays_in_2,2)); d*ones(1,size(rays_in_2,2))];
plot(ray_z_2, [rays_in_2(1,:); rays_out_2(1,:)],'-r');