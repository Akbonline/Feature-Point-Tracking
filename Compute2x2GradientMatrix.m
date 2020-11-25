%% Z Vector computation function:
% Contains the bilinear interpolated values of I, J, Gx, and Gy and the
% window
% Parse through the matrix
% Check the boundary conditions
% Interpolate as you go along and calculate the sum of the Gradient value
% present in the window
% Update the error list

function [Z]=Compute2x2GradientMatrix(Gx,Gy,i,j,window)
    [rows, cols] = size(Gx);
    [x,y,xy,w] = deal(0,0,0,window/2);
    w=floor(w);
    for offsetx=-w: w 
        for offsety=-w: w 
            if(i+offsetx < rows && i+offsetx > 0 &&  j+offsety < cols && j+offsety > 0)
                Gx_interpolate=Interpolate(Gx,i+offsetx,j+offsety);
                Gy_interpolate=Interpolate(Gy,i+offsetx,j+offsety);
                x=x+Gx_interpolate^2;
                y=y+Gy_interpolate^2;
                xy=xy+Gx_interpolate*Gy_interpolate;
            end
        end
    end
    Z=[x xy;xy y];
end

