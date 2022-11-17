load lightField.mat
%4 × 𝑁 matrix, 'rays', with each row describing:
%Row 1: the 𝑥 position of 𝑁 rays
%Row 2: the propagation direction (in radians) in the 𝑥𝑧 plane of 𝑁 rays
%Row 3: the 𝑦 position of 𝑁 rays
%Row 4: the propagation direction (in radians) in the 𝑦𝑧 plane of 𝑁 rays

%Set up inputs
x_pos = rays(1,:);
y_pos = rays(3,:);
xz_prop = rays(2,:);
yz_prop = rays(4,:);
sensor_width = 0.005; %m
num_pixels = 200;

thetax_1 = [-pi/20 -pi/40 pi/20 pi/40 pi/1500];
thetay_1 = 0;

d = 1;%m


%Call the rays2img function
[img,x,y] = rays2img(x_pos,y_pos,sensor_width,num_pixels);

figure(1);
image(x([1 end]),y([1 end]),img); axis image xy;
colormap gray;
title('rays in')

rays_in = zeros(4,size(x_pos,2));
rays_in(1,:) = x_pos;
rays_in(2,:) = xz_prop;
rays_in(3,:) = y_pos;
rays_in(4,:) = yz_prop;

disp('here 1')

transfer_M = [1 d 0 0;
    0 1 0 0;
    0 0 1 d;
    0 0 0 1];

rays_out = transfer_M*rays_in;

disp('here 2')

[img_out,x_out,y_out] = rays2img(rays_out(1,:),rays_out(3,:),sensor_width,num_pixels);

figure(2)
image(x_out([1 end]),y_out([1 end]),img_out); axis image xy;
colormap gray;
title('rays out')





