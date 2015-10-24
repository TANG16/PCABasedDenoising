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
N = (X-2*c)*(Y-2*c);

% each column of P is a patch
P = zeros(patchVectorSize,N);

% some locations of M correspoinding to the bottom right corner of the image
% have to be neglected
M = zeros(patchVectorSize,X-2*c,Y-2*c);

k=0;
for i=c+1:X-c
    for j=c+1:Y-c
        % getting the patch whose center is pixel(i,j) of the image
        patchMatrix = inputImage(i-c:i+c,j-c:j+c);
        patchVector = reshape(patchMatrix,[],1);
        k = k+1;
        P(:,k) = patchVector;
        M(:,i,j) = patchVector;
    end
end
disp(N);
disp(k);
