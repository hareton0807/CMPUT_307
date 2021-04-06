% Author: Chenlin Cao, Student ID: 1480278
% References: 
% 1. https://www.mathworks.com/help/stats/kmeans.html#bueftl4-1
% 2. https://www.mathworks.com/help/matlab/
% 3. Lecture slides and Lecture notes
format long;

% Part a: Load the given data set
X = pcread("dragon.ply").Location;
figure(1);
scatter3(X(:,1),X(:,2),X(:,3),"b.");
title("Original Data Set");

% ----------------------------------------

% Part b: Dertermine N, the number of points
size_X = size(X);
N = size_X(1, 1);

% ----------------------------------------

% Part c: Use PCA to find the first eignvector 
% step 1: Subtract the mean for each dimension of the data
X_adjusted = bsxfun(@minus, X, mean(X, 1));
% disp(size(X_adjusted));
% step 2: Compute the covariance matrix
% step 3: Compute the eigen-values and eigen-vectors
covarianceMatrix = cov(X);
[V,D] = eig(covarianceMatrix);
% fprintf("All eigenvectors of X: \n");
% disp(V);
sorted_D = nonzeros(D)';
[M, I] = max(sorted_D);
% Find the first eigen-vector (it is a unit vector)
% The first eigen-vetocr is the eigen-vector with the largest eigen-value.
v0 = V(:, I);
% fprintf("The first eigenvector of X: \n");
% disp(v0);

% ----------------------------------------

% Part d: Transform all the points by a rotation
% step 1: Transform the first eigen-vector to  get a rotation matirx
v0 = v0';
target = [1 0 0];
a = cross(v0, target);
a = a/sqrt(sum(a.*a));
K = [0 -a(3) a(2); a(3) 0 -a(1); -a(2) a(1) 0];
theta = acos(sum(v0.*target) / (sqrt(sum(v0.*v0))*sqrt(sum(target.*target))));
R = eye(3) + sin(theta)*K + (1-cos(theta))*K*K;
rotation_matrix = expm(theta*K);
% fprintf("The rotation matrix is: \n");
% disp(rotation_matrix);
% step 2: Apply the rotation matrix to the entire data set
X_transformed = (rotation_matrix * X')';
% fprintf("The size of the transformed matrix is: \n");
% disp(size(X_transformed));
figure(2);
scatter3(X_transformed(:, 1), X_transformed(:, 2), X_transformed(:, 3), 'b.');
title("Transformed Data Set");

% ----------------------------------------

% Part e: Sort the transformed matrix by values in the X dimension
% The sorted matrix is arranged by the value on the X dimension for each
% row. The order is ascending.
[~, index] = sort(X_transformed(:, 1));
sorted_X = X_transformed(index, :);
% fprintf("The size of the sorted matrix is: \n");
% disp(size(sorted_X));

% ----------------------------------------

% Part f: Determine the min and max value on the X dimension of the data
% set
min_X = min(sorted_X(:, 1));
max_X = max(sorted_X(:, 1));
% fprintf("The min value in the X dimension is: \n");
% disp(min_X);
% fprintf("The max value in the X dimension is: \n");
% disp(max_X);

% ----------------------------------------

% Part g: Divide the interval (min_X, max_X) into 100 small sub-intervals
% and make sure that all intervals contain about the same number of points
% k: the number of clusters in each sub-interval
% interval_size: the size of each interval expect for the last one
k = ceil(N / 1000); 
interval_size = ceil(N / 100); 

% ----------------------------------------

% Part h: Perform clsutering on each sub-interval
t = 0;
centroids = zeros(k * 100, 3);
radius = zeros(k * 100, 1);
if isfile('lab8.mat')
    delete lab8.mat;
end
for i = 0 : interval_size : N
    if (i + interval_size) <= N
        pts = sorted_X((i + 1):(i + interval_size), :);
    else
        pts = sorted_X((i + 1):N, :);
    end
    % Matlab kmeans function is used here
    % It uses an heuristic method to initialize all cluster centers.
    %  Reference: https://www.mathworks.com/help/stats/kmeans.html#bueftl4-1
    % idx: cluster indexes for each point in the data set, a N-by-1 matrix 
    % C: centroids, a k-by-3 matrix ; D: point-to-centroid distances, a N-by-k matrix
    [idx,C,~,D] = kmeans(pts, k);
    centroids((t+1):(t+k), :) = C(:, :);
    % for each cluster, find the max distance
    % max distance = distance between the centroid and the furtherest point
    % in the cluster
    for m = 1 : k
        temp = D(idx == m, m);
        radius((t+m), 1) = max(temp);
    end
   
    t = t + k;

end

% ----------------------------------------

% Part i: Write the centroids and radiuses data to a mat file named
% 'lab8.mat'
save lab8.mat centroids radius;

fprintf('Success in saving the mat file.\n');

% ----------------------------------------

% Part j: Draw
figure(2);
scatter3(X_transformed(:, 1), X_transformed(:, 2), X_transformed(:, 3), 'b.');
hold on;

% replace all zero radiuses with a very small number. Otherwise, an error
% would occur. They are clusters with only one point.
[row, col] = find(~radius);
radius(row, col) = 1e-10;

% increase the radius to show the circles explicitly.
% this is to prove that the scatter3 functions are working.
% this helps generate the 'figure_to_show_spheres_explicitly.png' plot.
% radius = radius * 1e+7;

% draw the clusters as spheres
scatter3(centroids(:, 1), centroids(:, 2), centroids(:, 3), radius(:, 1), 'r');
title('Transformed Data Set');

hold off;  
fprintf("Completed in drawing the plots.");
