d_x = 1; % howmuchever you want to translate in horizontal direction
d_y = 3; % howmuchever you want to translate in vertical direction
% create the original box
% first row has horizontal coordinates, second row has vertical coordinates
my_points = [1 1 2 2 1;1 2 2 1 1];
% Plot the original box
figure(1)
plot(my_points(1,1:end),my_points(2,1:end),'b*-');
% write code to create your Homogeneous 2D Translation matrix my_trans using d_x and d_y
my_trans = [];
% Next, we perform the translation
% write code to convert my_points to the homogeneous system and store the result in 
hom_my_points = [];
% write code to perform translation in the homogeneous system using my_trans and 
% hom_my_points and store the result in trans_my_points
trans_my_points = [];
% Plot the Translated box (output) which has to be done in Cartesian, so...
% cut out the X, Y points and ignore the 3rd dimension
hold on
plot(trans_my_points(1,1:end),trans_my_points(2,1:end),'r*-');
axis([0.5 3.5 0.5 5.5]); % just to make the plot nicely visible