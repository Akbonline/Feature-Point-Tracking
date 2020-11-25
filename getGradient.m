%% Get Gradient function:
% Calculate Horizontal and Vertical intensities
% Convolve and return Gx and Gy 
function [Gx, Gy] = getGradient(image, sig_val)
    [gauss, ~] = Gaussian(sig_val);
    [gauss_deriv, ~] = Gaussian_Deriv(sig_val);
    gauss_deriv = flipud(gauss_deriv);
    gauss_deriv = flip(gauss_deriv);
    temp_horizontal = convolve(image, gauss');
    Gx = convolve(temp_horizontal, gauss_deriv);
    temp_vertical = convolve(image, gauss);
    Gy = convolve(temp_vertical, gauss_deriv');
end

