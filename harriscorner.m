%% Identifying top 100 features
% STep 1: Finding the x and y derivatives
% Step 2: Using dx and dy, calculate the products of derivatives for every x and y
% Step 3: Compute the sums of the products of derivatives at each pixel
% Step 4: Generate a Matrix for the calculated x and y
% Step 5: Compute the response of the detector at each pixel
% Step 6: Calculate the threshold
% Step 7: Perform the nonmax suppression
% Step 8: Calculate the city block distance using the formula abs(x2-x1)+abs(y2-y1)
% Step 9: finding the top 100 features
function [x,y] = harriscorner(I)
    k = 0.04;
    Threshold = 8.5e8;
    sigma = 1;
    halfwid = sigma * 3;
    [xx, yy] = meshgrid(-halfwid:halfwid, -halfwid:halfwid);
    Gxy = exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
    Gx = xx .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
    Gy = yy .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
    numOfRows = size(I, 1);
    numOfColumns = size(I, 2);
    Ix = conv2(Gx, I);
    Iy = conv2(Gy, I);
    Ix2 = Ix .^ 2;
    Iy2 = Iy .^ 2;
    Ixy = Ix .* Iy;    
    Sx2 = conv2(Gxy, Ix2);
    Sy2 = conv2(Gxy, Iy2);
    Sxy = conv2(Gxy, Ixy);
    im = zeros(numOfRows, numOfColumns);
    for x=1:numOfRows
       for y=1:numOfColumns           
           H = [Sx2(x, y) Sxy(x, y); Sxy(x, y) Sy2(x, y)];           
           R = det(H) - k * (trace(H) ^ 2);           
           if (R > Threshold)
              im(x, y) = R; 
           end
       end
    end   
    output = im > imdilate(im, [1 1 1; 1 0 1; 1 1 1]);
    x1=[];y1=[];
    [height,width,~]=size(output);
    for i=1:height
        for j=1:width
            if output(i,j)==1
                x1=[x1 i];
                y1=[y1 j];
            end
        end
    end    
      x2=[];
      y2=[];
      for i=1:length(x1)-1
          if abs(x1(i+1)-x1(i))+abs(y1(i+1)-y1(i))>2
              x2=[x2 x1(i)];
              y2=[y2 y1(i)];
          end
      end
     x=[];
     y=[];
    for i=1:100
            if length(x2)>100 
                x=[x x2(i)];
                y=[y y2(i)];
            else 
                x=x2;
                y=y2;
            end
    end
end

