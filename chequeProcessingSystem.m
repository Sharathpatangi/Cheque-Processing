clear all;

% Reading our cheque image to be used
im = imread("49ercheque.jpg");

% Running our PreProcessing function 
chequeReady = chequePreProcess(im);

%% Database Fill

Banks = ["WellsFargo" ; "Bank 2"];

Fields = ["Name"; "Amount"; "Date"];
boundaries = ["578.5100, 549.5100, 1.076980000000000e+03, 77.980000"; "2948.51000000000, 660.510000000000, 446.980000000000, 86.9800000000000"; "2692.51000000000, 278.510000000000, 305.980000000000, 76.9800000000000"]

chequeBounds = table(Fields,boundaries);

%% Switch Case

disp("Select the Bank for your Cheque : ")
disp("1. Wells Fargo Bank")
disp("2. Bank 2")
n = input(['Type Selection : ']);

switch n
    case 1
        disp('Store Wells Fargo Data Here')

        % AFter adding database it will be NameArea = Database.Column
        NameArea = str2num(chequeBounds.boundaries(1));
        AmountArea = str2num(chequeBounds.boundaries(2));
        DateArea = str2num(chequeBounds.boundaries(3));
    case 2
        disp('Store Bank 2 Data Here')
    otherwise
        disp('Invalid Input')
end




%% EXTRACTING NAME
nameCrop = imcrop(chequeReady, NameArea);
figure, imshow(nameCrop);
nameResults = ocr(nameCrop);
name = strtrim(nameResults.Text)

%% EXTRACTING AMOUNT

amountCrop = imcrop(chequeReady, AmountArea);
amountResults = ocr(amountCrop);
amount = strtrim(amountResults.Text)
figure, imshow(amountCrop);

%% EXTRACTING DATE

dateCrop = imcrop(chequeReady, DateArea);
figure, imshow(dateCrop);
dateResults = ocr(dateCrop);
date = strtrim(dateResults.Text)

% TO DO ADD IF STATEMENT FOR CONCAT DATE

%word = results3.Words{1}
%word = results3.Words{2}

%% TABULAR FORM FOR EXTRACTED DATA

Title = ["Bank Name" ; "Name on the Cheque"; "Amount" ; "Date"];
Data = ["WellsFargo" ; name; amount; date];

ExtractedData = table(Title, Data);