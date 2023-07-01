function readyCheque = chequePreProcess(im)
    
    % Gaussian
    imgauss = imgaussfilt(im, 0.1);
    % figure, imshowpair(im, imgauss, "montage");
    % title('To remove the noisy pixels which are visible on right side of the image '); 
    
    % Grayscale and Binarize
    imgray = rgb2gray(imgauss);
    imbw = im2bw(imgray);
    % figure, imshowpair(imgauss, imbw, "montage");
    % title('To make finding the border coordinates of the cheque easily');
    
    % Bwareaopen
    % NO NEED for our image as noise easily was removed by gaussian filtering
    
    % Crop
    imcropcheque = imbw;
    imcropcheque = imresize(imcropcheque,[3000,4000]);
    % Resizing to reduce the resources needed for processing as it still
    % maintains the required information clearly even after resizing it
    
    imcropcheque = bwareaopen(imcropcheque,20);
    
    measurements = regionprops(imcropcheque,'BoundingBox','Area');
    area = cat(1,measurements.Area);
    [~,maxAreaIdx] = max(area);
    margins = round(measurements(maxAreaIdx).BoundingBox);
    
    croppedCheque = imcropcheque(margins(2):margins(2)+margins(4),margins(1):margins(1)+margins(3),:);
    figure, imshow(croppedCheque)

    readyCheque = croppedCheque;

end