%% Function to place markers:
% We wait for the pixel coordinates to be selected
% Then mark/plot it
% return the output image
function [output] = Place_Markers(output, pxls)
    [cols, ~,~] = size(pxls);  
    for curr = 1: cols  
        hold on
        x = pxls(curr,1);
        y = pxls(curr,2);
        plot(y,x, 'r*')
    end
end

