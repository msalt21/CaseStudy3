% matlab is boss

x1_origin = 0;
y1_origin = 0;
z1_origin = 0;

x2_origin = 0.01;
y2_origin = 0;
z3_origin = 0;

thetax_1 = [-pi/20 -pi/40 pi/20 pi/40 pi/1500];
thetay_1 = 0;

f = 0.15;%m
d_1 = 0.3;
d_2 = ((1/f)-(1/d_1))^-1;

rays_in_1 = zeros(4,5);
rays_in_1(2,:) = thetax_1;

rays_in_2 = zeros(4,5);
rays_in_2(1,:) = x2_origin;
rays_in_2(2,:) = thetax_1;

matrix_in = [1    d_1 0 0;
    0  1 0 0;
    0    0 1 d_1;
    0   0  0 1];
rays_out_1_1 = matrix_in*rays_in_1;
rays_out_2_1 = matrix_in*rays_in_2;

matrix_f = [1    0 0 0;
    -1/f 1 0 0;
    0    0 1 0;
    0   0   -1/f 1];

rays_out_1_2 = matrix_f*rays_out_1_1;
rays_out_2_2 = matrix_f*rays_out_2_1;

matrix_out = [1 d_2 0 0;
    0 1 0 0;
    0    0 1 d_2;
    0   0   0 1];

rays_out_1_3 = matrix_out*rays_out_1_2;
rays_out_2_3 = matrix_out*rays_out_2_2;


figure, hold on

%Plot Ray 1
ray_z_1_1 = [zeros(1,size(rays_in_1,2)); d_1*ones(1,size(rays_in_1,2))];
plot(ray_z_1_1, [rays_in_1(1,:); rays_out_1_1(1,:)],'-b');

ray_z_1_2 = [d_1*ones(1,size(rays_in_1,2)); d_2*ones(1,size(rays_in_1,2))];
plot(ray_z_1_2, [rays_out_1_1(1,:); rays_out_1_3(1,:)],'-b');

%Plot Ray 2
ray_z_2_1 = [zeros(1,size(rays_in_2,2)); d_1*ones(1,size(rays_in_2,2))];
plot(ray_z_2_1, [rays_in_2(1,:); rays_out_2_1(1,:)],'-r');

ray_z_2_2 = [d_1*ones(1,size(rays_in_2,2)); d_2*ones(1,size(rays_in_2,2))];
plot(ray_z_2_2, [rays_out_2_1(1,:); rays_out_2_3(1,:)],'-r');