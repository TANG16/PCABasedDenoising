function [P_denoised] = closestPatchSearch(M,K,N,sigma)
% Performs the nearest neighbour search in a window for the patch based matrix M
% See function createPatchMatrices for the structure of M and P
%   param M: patch based matrix
%   param K: number of nearest neigbours
%   param N: window size
%   param sigma: sigma of gaussian noise

patchVectorSize = size(M,1);

% TODO: What to do if K nearest neighbour not possible?

X=size(M,2);
Y=size(M,3);

N1 = X*Y;
P_denoised = zeros(patchVectorSize,N1);
% Window defined using top left corner of the patch whereas M is defined using the center of the patch

% TODO: vectoring the knnsearchPart gives high speedup; see if possible
d=floor(N/2);
k=0;
for i=1:X
    for j=1:Y
        % Window from (i-c-N/2,j-c-N/2) to (i-c+N/2,i-c+N/2) 
        % Defining window edges
        x1 = i-d;
        y1 = j-d;
        x2 = i+d;
        y2 = j+d;
        
        % adjusting edges for the window
        if x1<1
            x1=1;
        end
        if y1<1
            y1=1;
        end
        if x2>X
            x2=X;
        end
        if y2>Y;
            y2=Y;
        end
        
        % patches as row vector in search domain and p
        searchDomain = squeeze(reshape(M(:,x1:x2,y1:y2),patchVectorSize,[],1));
        
        % TODO: check size of p, must be a row vector
        p = squeeze(M(:,i,j));
        q = searchDomain(:,knnsearch(searchDomain',p','K',K));
        
        [V,~]=eig(q*q');
        alpha = V'*q;   % compute the eigencoefficients
        %% Compute estimate of average squared
        alpha_avg_sq = zeros(patchVectorSize);
        for x=1:patchVectorSize
            alpha_avg_sq(x) = sumsqr(alpha(x,:))/K - sigma^2;
        end
        alpha_avg_sq=max(alpha_avg_sq,0);
        %% Wiener filter-like update
        alpha_denoised=zeros(size(alpha));
        for x=1:patchVectorSize
            if(alpha_avg_sq(x)==0)
                alpha_denoised(x,:) = 0;
            else
                alpha_denoised(x,:) = alpha(x,:)/(1+sigma^2/alpha_avg_sq(x));
            end
        end
        k=k+1;
        P_denoised(:,k) = V*alpha_denoised(:,1);        
    end
end
