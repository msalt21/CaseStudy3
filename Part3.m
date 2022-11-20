load lightField.mat

% Set the distance you want to back propogate
d = 1; % meters

% This distance was a "guess" but could also be determined using the
% equation 1/f = 1/d_1 + 1/d_2, with the values for d_2 and f used in
% part 2

% This is the inverse of the propogation matrix M_d, derived in the report
M_d_inverse = [1 -d 0 0 ;...
       0 1  0 0 ;...
       0 0  1 -d;...
       0 0  0 1 ];

rays_final = M_d_inverse * rays;
[rays_final_img, rays_final_x, rays_final_y] = ...
    rays2img(rays_final(1,:), rays_final(3,:), 0.005, 500);

figure, hold on
image(rays_final_x([1 end]), rays_final_y([1 end]), rays_final_img)
axis image xy
colormap gray
hold off

% Yes the image is sharp! It looks almost exactly the same as the image in
% part two, except the image is upside down -- why is this? Something to do
% with not having the "lens"?