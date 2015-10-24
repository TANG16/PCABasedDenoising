function [outputImage] = imageFromPatches(P,X,Y)
% imageFromPatches recreates the image from overlapping patches
%   param P: the patch matrix
%   param X,Y: the image size

outputImage = zeros(X,Y);

% numberOfPatches hold the number of patches for that corresponding pixel
numberOfPatches = zeros(X,Y);

patchVectorSize = size(P,1);
patchDimension = sqrt(patchVectorSize);
c = floor(patchDimension/2);


k=0;
for i=c+1:X-c
    for j=c+1:Y-c
        k=k+1;
        patch = reshape(P(:,k),patchDimension,patchDimension); 
        outputImage(i-c:i+c,j-c:j+c) = outputImage(i-c:i+c,j-c:j+c) + patch;
        numberOfPatches(i-c:i+c,j-c:j+c) = numberOfPatches(i-c:i+c,j-c:j+c) + 1;
    end
end
outputImage = outputImage./numberOfPatches;
        

