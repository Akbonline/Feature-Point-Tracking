%% magnitude grad: Contains implementations for both horizontal and vertical Gradients
% Step 1: Calculate vertical and horizontal Gaussian kernel and
% derivatives
% Step 2: Calculating magnitude and angle
% Step 3: Using the Magnitude and Gradient Image pseudocode from the slides
% Step 4: Returning all the calculated values
% Modified for Lucas Kanade feature tracking...
function [Gx, Gy] = MagnitudeGradient(image, sig_val)
    [gauss, ~] = Gaussian(sig_val);
    [gauss_deriv, ~] = Gaussian_Deriv(sig_val);
    gauss_deriv = flipud(gauss_deriv);
    gauss_deriv = flip(gauss_deriv);
    horizontal = convolve(image, gauss');
    Gx = convolve(horizontal, gauss_deriv);
    vertical = convolve(image, gauss);
    Gy = convolve(vertical, gauss_deriv');
end

