%% Lab 05: Lucas Kanade Motion tracking 
% Ask for choosing from the two options: 1. Cherry Pick 2. Lucas Kanade
% Ask for the first image from the sequence
% If Cherry pick:
    % Select 21 points(preferrably corners)
    % Run Lucas-Kanade Algorithm and display it on the image
% If Harris corner selected: 
% Select the first image from the sequence
% Click ok when prompted to jump on the next frame image
clear all
clc
num_points = 21;
temp = zeros(num_points, 2);
n = input(' Please select fromt the below algorithms:\n 1. Cherry picked Lucas-Kanade (1) \n 2. Lucas-Kanade using Harris corner detection (2) \n');
switch n
    case 1
        [FileName, FilePath] = uigetfile('*');
        image = imread(strcat(FilePath,FileName));
        imshow(image);
        trueSize = ([500,500]);
        [height, width, numColors]=size(image);
        for curr=1:num_points
            [temp(curr,2), temp(curr,1)] = (ginput(1));
            temp(curr,1) = uint32(temp(curr,1));
            temp(curr,2) = uint32(temp(curr,2));
        end                
        if( numColors == 1)
            image3 = image;
            image1 = cat(3, image3, image3, image3);
        else
            image1 = image;
        end
        disp("Please enter 21 Markers(Preferrably corners) \n")
        [image1] = Place_Markers(image1, temp);
        figure;
        imshow(image1);
        [image2, image_num, I, window]=deal(0,030,double(image),11);
        counter = 0;
        while(1)
            %image4 = imread(sprintf('statue_seq/img0%d.bmp', image_num));% input second frame 
            image4 = imread(sprintf('flowergarden/img0%d.pgm', image_num));
            J = image4;
            J = double(J);
            imshow(image1);
            truesize([500,500]);
            counter=counter+1;
            title(['Image: ',num2str(counter)]);
            [image1] = Place_Markers(image1, temp);
            h = msgbox('Click here to move to the next frame');
            waitfor(h);
            [temp] = Lucas_Kanade(I, J, temp, window);
            image3 = uint8(image4);
            image1 = repmat(image3, [1 1 3]);
            image1 = cat(3, image3, image3, image3);
            I= J;
            image_num = image_num+1;
        end
    case 2
        [FileName, FilePath] = uigetfile('*');
        image = imread(strcat(FilePath,FileName));
        imshow(image);
        [height, width, numColors]=size(image);
        [x,y] = harriscorner(double(image));
        temp(length(x),2)=zeros;
        for curr=1:length(x)
            temp(curr,1) = uint8(x(curr));
            temp(curr,2) = uint8(y(curr));
        end
        if( numColors == 1)
            image3 = image;
            image1 = cat(3, image3, image3, image3);
        else
            image1 = image;
        end
        [image1] = Place_Markers(image1, temp);
        figure;
        imshow(image1);
        [image2, image_num, I, window]=deal(0,030,double(image),11);
        counter =0;
        while(1)
            image4 = imread(sprintf('flowergarden/img0%d.pgm', image_num)); %<= Change the path here to test on a different image sequence
            J = image4;
            J = double(J);
            imshow(image1);
            truesize([500,500]);
            counter=counter+1;
            title(['Image: ',num2str(counter)]);
            [image1] = Place_Markers(image1, temp);
            h = msgbox('Click here to move to the next frame');
            waitfor(h);
            [temp] = Lucas_Kanade(I, J, temp, window);
            [image3,image1,image1,I,image_num]=deal(uint8(image4),repmat(image3, [1 1 3]),cat(3, image3, image3, image3),J,image_num+1);
        end
end