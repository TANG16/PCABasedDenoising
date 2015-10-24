function [P,M,N] = createPatchMatrices(inputImage, patchDimension)
% Create Patch based matrices P and M
% P: Contains each patch as a column vector
% M: Each element of the 2D matrix is a patch

X = size(inputImage,1);
Y = size(inputImage,2);

patchVectorSize = patchDimension^2;
c = floor(patchDimension/2);
% Calculating the number of patches; Image locations in the bottom right
% corner do not have a patch
N = X*Y - patchDimension*patchDimension;

% each column of P is a patch
P = zeros(patchVectorSize,N);

% some locations of M correspoinding to the bottom right corner of the image
% have to be neglected
M = zeros(patchVectorSize,X-2*c,Y-2*c);

k=1;
for i=1:X-2*c
    for j=1:Y-2*c
        % getting the patch whose center is pixel(i,j) of the image
        patchMatrix = inputImage(i-c:i+c,j-c:j+c);
        patchVector = reshape(patchMatrix,[],1);
        
        P(:,k) = patchVector;
        k = k+1;
        M(:,i,j) = patchVector;
    end
end
