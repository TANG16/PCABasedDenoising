function [q] = closestPatchSearch(M,K,N,patchDimension)
% Performs the nearest neighbour search in a window for the patch based matrix M
% See function createPatchMatrices for the structure of M and P
%   param M: patch based matrix
%   param K: number of nearest neigbours
%   param N: window size
%   param patchDimension: the dimension of the patch (either row or column)

patchVectorSize = size(M,1);
c= patchDimension/2;


% TODO: What to do if K nearest neighbour not possible?
Q = zeros(patchVectorSize,K);

X=size(M,2);
Y=size(M,3);

% Window defined using top left corner of the patch whereas M is defined using the center of the patch

% TODO: vectoring the knnsearchPart gives high speedup; see if possible


for i=1:X
    for j=1:Y
        % Window from (i-c-N/2,j-c-N/2) to (i-c+N/2,i-c+N/2) 
        % Defining window edges
        x1 = i-c-N/2;
        y1 = j-c-N/2;
        x2 = i-c+N/2;
        y2 = j-c+N/2;
        
        % adjusting edges for the window
        if x1<1
            x1=1;
        end
        if y1<1
            y1=1;
        end
        if x2<1
            x2=1;
        end
        if y2<1;
            y2=1;
        end
        
        % patches as row vector in search domain and p
        searchDomain = squeeze(reshape(M(:,x1:x2,y1:y2),patchVectorSize,[],1))';
        
        % TODO: check size of p, must be a row vector
        p = squeeze(M(:,i,j));
        q = knnsearch(searchDomain,p,K);
    end
end
