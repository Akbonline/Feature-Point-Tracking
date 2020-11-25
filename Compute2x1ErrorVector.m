%% Error Vector computation function:
% Contains the bilinear interpolated values of I, J, Gx, and Gy
% Parse through the matrix
% Check the boundary conditions
% Interpolate as you go along and 
% Update the error list

function [error_list]=Compute2x1ErrorVector(I,J,Gx,Gy,i,j,frame,u)
    [rows, cols] = size(I);
    col=floor(frame/2);
    error_list=[0 0];
    for offsetx=-col:col 
        for offsety=-col:col 
            if(i+offsetx < rows && i+offsetx > 0 && j+offsety < cols && j+offsety > 0)
                Gx_inter=Interpolate(Gx,i+offsetx,j+offsety);
                Gy_inter=Interpolate(Gy,i+offsetx,j+offsety);
                I_inter=Interpolate(I, i+offsetx,j+offsety);
                J_inter=Interpolate(J,i+u(2)+offsetx,j+u(1)+offsety);
                error_list(1)=error_list(1)+Gx_inter*(I_inter - J_inter);
                error_list(2)=error_list(2)+Gy_inter*(I_inter - J_inter);
            end
        end
    end
end

