% Author: Chenlin Cao, Student ID: 1480278
% This program performs k-means clustering algorithm to a 2d and a 3d
% data set.
% References:
% 1. Lecture slides and notes
% 2. https://www.mathworks.com/help/matlab/

% ----- 2d case -----
N = 10000;
% randn: generates rand numbers with the standard normal distribution 
X = [randn(N, 2) * 0.55 - ones(N, 2); randn(N, 2) * 0.65 + ones(N, 2)];
% initialize the number of clusters
k = 2;
% Apply the k-means clustering algorithm
fprintf("2d: \n");
[indexes, centroids] = K_means(X, k);
% Plot the original data set and the clustered data set (2d)
plot_2d(X, k, indexes, centroids);


% ----- 3d case -----
filename = "bun_zipper.mat";
file = load(filename);
X = file.X;
% Change the value of k (the number of clusters) here
k = 2;
% Apply the k-means clustering
fprintf("3d: \n");
[indexes, centroids] = K_means(X, k);
% Plot the original data set and the clustered data set (3d)
plot_3d(X, k, indexes, centroids, filename);

% k-means clustering alg.
function [indexes, centroids] = K_means(X, k)
    % get the number of samples and the dimension of the X data set
    size_X = size(X);
    num_samples = size_X(1, 1);
    d = size_X(1, 2);
    % generate k random centroids
    % centroids = init_centroids_heuristic_a(X, k);
    centroids = init_centroids_heuristic_b(k, num_samples, d);
    % compute point-to-cluster-centroid distance between all points in the
    % data set and every centroid
    distances = zeros(num_samples, k);
    indexes = zeros(num_samples, 1);
    prev_indexes = indexes;
    convergence = false;
    num_iterations = 0;
    while convergence == false
        for row = 1 : num_samples
            for c = 1 : k
                distances(row, c) = norm(X(row, :) - centroids(c, :));
            end
            % The first return value is the minimum value and it is not used
            % here
            [~, I] = min(distances(row, :));
            indexes(row, 1) = I;
        end
        for i = 1 : k
        % re-compute the values of the centroids
            point_indexes = (indexes == i);
            points = X(any(point_indexes, 2), :);
            if any(point_indexes)
                centroids(i, :) = mean(points, 1);
            else
                centroids(i, :) = zeros(1, d);
            end
        end
        % Here is the convergence condition:
        % Stop the iterations when the cluster assignments of all the
        % points are not changed
        if prev_indexes == indexes
            convergence = true;
        else
            prev_indexes = indexes;
            num_iterations = num_iterations + 1;
        end
    end
    fprintf("No. of iterations : " + num_iterations + "\n");
end

% plot the clusters and their corresponding centroids in different colors
function plot_3d(X, k, indexes, centroids, filename)
    figure(3);
    scatter3(X(:, 1), X(:, 2), X(:, 3), 'b.');
    title(filename)
    figure(4);
    view(3);
    hold on;
    for i = 1 : k
        point_indexes = (indexes == i);
        points = X(any(point_indexes, 2), :);
        scatter3(points(:, 1), points(:, 2), points(:, 3), 'filled', 'DisplayName', strcat('Cluster ', int2str(i)));
    end
    s = scatter3(centroids(:, 1), centroids(:, 2), centroids(:, 3), 'kx', 'DisplayName', 'Centroids');
    s.SizeData = 70;
    legend("show");
    title("Cluster Assignments and Centroids");
    hold off;
end

% plot the clusters and their corresponding centroids in different colors
function plot_2d(X, k, indexes, centroids)
    figure(1);
    scatter(X(:, 1), X(:, 2), 'b.');
    title("Randomly generated data");
    figure(2);
    hold on;
    for i = 1 : k
        point_indexes = (indexes == i);
        points = X(any(point_indexes, 2), :);
        scatter(points(:, 1), points(:, 2), 'filled', 'DisplayName', strcat('Cluster ', int2str(i)));
    end
    scatter(centroids(:, 1), centroids(:, 2), 'kx', 'DisplayName', 'Centroids');
    legend('show');
    title("Cluster Assignments and Centroids");
    hold off;
end

function centroids = init_centroids_heuristic_a(X, k)
    % Choose the first k points
    centroids = X(1:k, :);
end

function centroids = init_centroids_heuristic_b(k, N, d)
    % Generate k random numbers that are between 1 and N
    a = 1;
    b = N;
    centroids = (b - a) .* rand(k, d) + a;
end