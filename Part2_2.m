import rays2img.*
close all

% goal of this is to bend the rays so that they intersect at one point,
% allowing for a sharp image
% parameters:
% * focal length f
% * distance before lens d_1
% * distance after lens d_2

% NOTE: the light ray data we recieve is after the rays have travelled a
% distance d_1 from their respectice origins. 

% NOTE: the parameters must satisfy the equation given below:
% 1/f = 1/d_1 + 1/d_2
% This might not be particularily useful, since we don't know the value for
% d_1

% Importing the ray data (held in the matrix |rays|)
load 'lightField.mat'

% Setting values to the parameters
f = 0.5; % meters
d_2 = 1; % meters


% Matrix representing bending of rays through "lens"
M_2 = [1    0 0    0;...
       -1/f 1 0    0;...
       0    0 1    0;...
       0    0 -1/f 1];

% Matrix representing propogation of rays after hitting "lens"
M_3 = [1 d_2 0 0  ;...
       0 1   0 0  ;...
       0 0   1 d_2;...
       0 0   0 1  ];

% Processed rays
sharp_rays = M_3 * M_2 * rays;

% Before image
[rays_img, rays_x, rays_y] = rays2img(rays(1,:), rays(3,:), 0.005, 500);
[sharp_rays_img, sharp_rays_x, sharp_rays_y] = ...
    rays2img(sharp_rays(1,:), sharp_rays(3,:), 0.005, 500);

figure, hold on
image(rays_x([1 end]),rays_y([1 end]),rays_img)
axis image xy
colormap gray
hold off

figure, hold on
image(sharp_rays_x([1 end]), sharp_rays_y([1 end]), sharp_rays_img)
axis image xy
colormap gray
hold off

% Image seems to look like the planet Saturn.
% By doing calculations using the thin lens equation, d_1 = 2m when f =
% 0.5m and d_2 = 1m. This doesn't really make sense, because Saturn is
% definitely farther than 2m away from any sensor on Earth. Maybe tweak the
% values for d_2 and f to get a more sensical value for d_1? Not sure if
% this matters though for the purposes of this project.

