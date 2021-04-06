% create box
% first row is horizontal coordinates; second row is vertical coordinates
my_pts = [2 2 3 3 2;2 3 3 2 2];
% display the original box
figure(1)
plot(my_pts(1,1:end),my_pts(2,1:end),'b*-');
% write code here to create your 2D rotation matrix my_rot
my_rot = [];
% write code to perform rotation using my_rot and my_pts and store the result in my_rot_pts
my_rot_pts = [];
% Plot output
hold on;
plot(my_rot_pts(1,1:end),my_rot_pts(2,1:end),'r*-');
axis([1.5 4.5 0 3.5]);