%% Gerona, Lucky Niwre M.
% 2015-00532
% May 4, 2019
% MATLAB R2018a

%% Task 2.

% code is reproduced from
% https://blogs.mathworks.com/steve/2011/12/13/exploring-shortest-paths-part-5/ 
% few tweaks were made to retrofit the sampled code into the given maze image
% while the concepts were referenced from series posts from the same page

%% 1.

im = imread('maze.png');                                       % load image
im = im(:,:,1);                                                % select one plane/matrix from the image

walls = imdilate(im < 100, ones(16,16));                             % this highlights the possible paths to take into account, imdilate to increase wall width which is governed by the size of ones(18,18)

D1 = bwdistgeodesic(~walls, 1000,1, 'quasi-euclidean');        % bwdisgeodesic calculates the distances from the coordinates to every other pixel/point in the possible paths.
D2 = bwdistgeodesic(~walls, 1000,1200 , 'quasi-euclidean');    % bwdistgeodesic() takes into account the walls/ unpassables in calculating distance 
D = D1 + D2;                                                   % from the reference, adding the distance matrices then picking the path of smallest values, the path can be found
D = round(D * 4) / 4;                                          % normalize distances by a certain factor

D(isnan(D)) = inf;                                             % any NAN is turned into Inf which means the point is unreachable from the stated starting point.
paths = imregionalmin(D);                                      % this finds the minimum region, stated by the comment earlier, which becomes the possible path to take

solution_path = bwmorph(paths, 'thin', inf);                   % using bwmorph turns the region of paths into a very thin path
thick_solution_path = imdilate(solution_path, ones(7,7));      % use imdilate again to make the path thicker 
P = imoverlay(im, thick_solution_path, [1 0 0]);               % super impose the original maze and the solution
imshow(P, 'InitialMagnification', 'fit')                       % imshow to show image

imwrite(P,'soln.png','png');                                   % create .png image of the solution