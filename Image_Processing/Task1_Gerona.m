%% Gerona, Lucky Niwre M.
% 2015-00532
% May 4, 2019
% MATLAB R2018a

%% Task 1.

im1 = imread('Incineroar.png');                                 % load images
im2 = imread('Cloud.png');
%% 1.

maskA = [2:2:250];                                              % create a gradient from 2-250 with increments of 2
maskA = [maskA fliplr(maskA)];                                  % concatenate with the reverse of the vector to create one row of the symmetric image seen on sample maskA
maskA = uint8(repmat(maskA,250,1,3));                           % use repmat() to repeat for 250 rows then cast into uint8 type

maskB = [1:250];                                                % creates a vector from 1-250
maskB = uint8(repmat(maskB',1,250,3));                          % then turns it into a column, then repeats for 250 columns then cast into uint8 type

%% 2. 

maskedA = uint8(double(maskA)./250 .* double(im1));             % normalize the value of the mask so it ranges only from 0-1 and thus, values wont exceed 255
maskedB = uint8(double(maskB)./250 .* double(im2));             % multiply both to respective normalized masks

%% 3.

blended = 0.5 * maskedA + 0.5 * maskedB;                        % use given equation to blend

%% 4.

figure                                                          % simple plotting of images
subplot(1,3,1)
imshow(maskedA)
title('Masked Incineroar')
subplot(1,3,2)
imshow(maskedB)
title('Masked Cloud')
subplot(1,3,3)
imshow(blended)
title('Blended Incineroar and Cloud')

%% 5.
imwrite(maskedA,'maskedA.png','PNG')                             % use imwrite to save an image
imwrite(maskedB,'maskedB.png','PNG')
imwrite(blended,'blended.png','PNG')