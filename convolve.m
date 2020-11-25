%% Convolution Function: 
% So we have two matrices: Offset and the original matrices to convolve over
% Step 1: We flip the offset(Done inside the innermost for loop
% Step 2: We figure out the middle of the offset and allign it with the
% offset
% Step 3: Until every pixel in the original image is visited:
% Step 3.1: We apply the filter by taking sum of products
% Step 4: Return the convoluted image
function [output] = convolve(image,offset)
    [x,y]=size(image);
    [rows,cols]=size(offset);
    output=zeros(x,y);
    for i=1:x
        for j=1:y
            sum=0;
            for k=1:rows
                for m=1:cols
                    % Flipping the offset horizontally and vertically
                    x0=-1*floor(rows/2)+k-1;
                    y0=-1*floor(cols/2)+m-1;                   
                    if (i+x0) > 0 && (i+x0) <= x && (j+y0) > 0 && (j+y0) <= y
                        % Calculating Sum of Products
                        sum=sum+image(i+x0,j+y0)*offset(k,m);
                    end
                end
            end
            output(i,j)=sum;
        end
    end    
end
