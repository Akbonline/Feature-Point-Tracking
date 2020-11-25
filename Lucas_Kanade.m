%% Lucas Kanade Function 
% Step 1: Get the horizontal and vertical gradient of the image
% Step 2: Incremental displacement vector initialized to zero
% Step 3: Iterate through the images and update deltau
% Step 4: Keep updating the value of u
% Step 5: Update the feature points in topfeatures
% Step 6: Updating the correct displacement value
function [topfeatures] = Lucas_Kanade(I, J, topfeatures, window)
    sigma = 0.6;
    [Gx, Gy] = getGradient(I, sigma);
    for i=1: size(topfeatures)
        u = [0 0];
        keypt_x = topfeatures(i,1);
        keypt_y = topfeatures(i,2);
        [Z]=Compute2x2GradientMatrix(Gx,Gy,keypt_x,keypt_y, window); 
        count = 0;
        deltau = [0 0];
        while(1)
            [err]=Compute2x1ErrorVector(I,J,Gx,Gy, keypt_x, keypt_y, window,u);
            [deltau]=Solve2x2LinearSystem(Z,err);
            u(1)=u(1)+deltau(1); 
            u(2)=u(2)+deltau(2);
            if(count+1 > 10)
                break;
            end
            if(deltau <=0.2)
                break;
            end
            count = count + 1;
        end
        topfeatures(i,1)=topfeatures(i,1) + u(2); 
        topfeatures(i,2)=topfeatures(i,2) + u(1);
    end
end

