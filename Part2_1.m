% 
% x1_origin = 0;
% y1_origin = 0;
% z1_origin = 0;
% 
% x2_origin = 0.01;
% y2_origin = 0;
% z3_origin = 0;
% 
% thetax_1 = [-pi/20 -pi/40 pi/20 pi/40 pi/1500];
% thetay_1 = 0;
% 
% f = 0.15;%m
% d_1 = 0.3;
% d_2 = 0.6;% ((1/f)-(1/d_1))^-1 + d_1;
% 
% rays_in_1 = zeros(4,5);
% rays_in_1(2,:) = thetax_1;
% 
% rays_in_2 = zeros(4,5);
% rays_in_2(1,:) = x2_origin;
% rays_in_2(2,:) = thetax_1;
% 
% matrix_in = [1    d_1 0 0;
%     0  1 0 0;
%     0    0 1 d_1;
%     0   0  0 1];
% rays_out_1_1 = matrix_in*rays_in_1;
% rays_out_2_1 = matrix_in*rays_in_2;
% 
% matrix_f = [1    0 0 0;
%     -1/f 1 0 0;
%     0    0 1 0;
%     0   0   -1/f 1];
% 
% rays_out_1_2 = matrix_f*rays_out_1_1;
% rays_out_2_2 = matrix_f*rays_out_2_1;
% 
% matrix_out = [1 d_2 0 0;
%     0 1 0 0;
%     0    0 1 d_2;
%     0   0   0 1];
% 
% rays_out_1_3 = matrix_out*rays_out_1_2;
% rays_out_2_3 = matrix_out*rays_out_2_2;
% 
% 
% figure, hold on
% 
% %Plot Ray 1
% ray_z_1_1 = [zeros(1,size(rays_in_1,2)); d_1*ones(1,size(rays_in_1,2))];
% plot(ray_z_1_1, [rays_in_1(1,:); rays_out_1_1(1,:)],'-b');
% 
% ray_z_1_2 = [d_1*ones(1,size(rays_in_1,2)); d_2*ones(1,size(rays_in_1,2))];
% plot(ray_z_1_2, [rays_out_1_1(1,:); rays_out_1_3(1,:)],'-b');
% 
% %Plot Ray 2
% ray_z_2_1 = [zeros(1,size(rays_in_2,2)); d_1*ones(1,size(rays_in_2,2))];
% plot(ray_z_2_1, [rays_in_2(1,:); rays_out_2_1(1,:)],'-r');
% 
% ray_z_2_2 = [d_1*ones(1,size(rays_in_2,2)); d_2*ones(1,size(rays_in_2,2))];
% plot(ray_z_2_2, [rays_out_2_1(1,:); rays_out_2_3(1,:)],'-r');

theta_x = [-pi/20 -pi/40 pi/20 pi/40 pi/1500];
rays_1 = [zeros(1,5); theta_x; zeros(2,5)];

% Setting initial x position of the rays as x = 0.010
rays_2 = [ones(1,5) * 0.010; theta_x; zeros(2,5)];

f = 0.15;
d_1 = 0.30;
d_2 = (1/f-1/d_1)^-1;

% Matrix representing propogation of rays before hitting lens
M_1 = [1 d_1 0 0  ;...
       0 1   0 0  ;...
       0 0   1 d_1;...
       0 0   0 1  ];

% Matrix representing bending of rays through lens 
M_2 = [1    0 0    0;...
       -1/f 1 0    0;...
       0    0 1    0;...
       0    0 -1/f 1];

% Matrix representing propogation of rays after hitting lens
M_3 = [1 d_2 0 0  ;...
       0 1   0 0  ;...
       0 0   1 d_2;...
       0 0   0 1  ];
% _1 means right before lens, _2 means right after lens, _3 means once the
% rays have converged
rays_1_1 = M_1 * rays_1;
rays_1_2 = M_2 * rays_1_1;
rays_1_3 = M_3 * rays_1_2;

rays_2_1 = M_1 * rays_2;
rays_2_2 = M_2 * rays_2_1;
rays_2_3 = M_3 * rays_2_2;

% Plotting each of the rays. ray_z_{x}_{y} represents the travel of the
% rays in the z axis (i.e. the direction of propogation). {x} represents
% which cluster of rays (either 1 or 2), and {y} represents where the rays
% are (1 for before the lens, 2 for after the lens, and 3 at the point of
% intersection) This matrix is of size 2 x n, where n is the number of rays

% Note: we will be skipping rays_z_{x}_2 because, since we are assuming a
% thin lens, we also assume that when the rays are bent by the lens, they
% do not propogate at all in the z direction. 
rays_z_1_1 = [zeros(1,size(rays_1,2)); d_1*ones(1,size(rays_1,2))];
rays_z_1_3 = [d_1*ones(1,size(rays_1,2)); ...
    (d_1+ d_2)*ones(1,size(rays_1,2))];

rays_z_2_1 = [zeros(1,size(rays_2,2)); d_1*ones(1,size(rays_2,2))];
rays_z_2_3 = [d_1*ones(1,size(rays_2,2)); ...
    (d_1 + d_2)*ones(1,size(rays_2,2))];

% Plotting all of the rays on the same graph. The columns of each matrix
% can be thought of as the before point and the after point. rays_z_...
% represents the x coordinates and rays_1_... represents the z coordinates.

figure, hold on
plot(rays_z_1_1, [rays_1(1,:); rays_1_1(1,:)], '-r');
plot(rays_z_1_3, [rays_1_1(1,:); rays_1_3(1,:)],'-r');

plot(rays_z_2_1, [rays_2(1,:); rays_2_1(1,:)],'-b');
plot(rays_z_2_3, [rays_2_1(1,:); rays_2_3(1,:)],'-b');
hold off

