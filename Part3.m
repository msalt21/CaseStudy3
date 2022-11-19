load lightField.mat

% Set the distance you want to back propogate
d = 1; % meters

M_d = [1 -d 0 0 ;...
       0 1  0 0 ;...
       0 0  1 -d;...
       0 0  0 1 ];

rays_final = M_d * rays;
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