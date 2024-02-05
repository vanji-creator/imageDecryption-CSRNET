% Specify the path to your image
imagePath = 'D:\imageDecryption-CSRNET\images\tulips.png';

% Read the image
img = imread(imagePath);

% Get the size of the image
[height, width, ~] = size(img);

% Specify the block size
blockSize = 32;

% Calculate the number of blocks in each dimension
numBlocksX = floor(width / blockSize);
numBlocksY = floor(height / blockSize);

% Create a directory to store processed images
processedDir = 'D:\imageDecryption-CSRNET\processed_images';
if ~exist(processedDir, 'dir')
    mkdir(processedDir);
end

% Iterate through the blocks and process them
for i = 1:numBlocksY
    for j = 1:numBlocksX
        % Calculate the coordinates for each block
        xStart = (j - 1) * blockSize + 1;
        xEnd = j * blockSize;
        yStart = (i - 1) * blockSize + 1;
        yEnd = i * blockSize;
        
        % Extract the block from the image
        currentBlock = img(yStart:yEnd, xStart:xEnd, :);
        
        % Convert the block to grayscale
        grayBlock = rgb2gray(currentBlock);
        
        % Perform DCT on the grayscale block
        dctBlock = dct2(grayBlock);
        
        % Create a random binary matrix of size 32x16
        binaryMatrix = randi([0, 1], 32, 16);
        
        % Multiply the DCT block with the random binary matrix
        result = dctBlock * binaryMatrix ;
        
        % Generate a unique filename for each block
        filename = fullfile(processedDir, sprintf('block_%d_%d.png', i, j));
        
        % Save the processed block as an image file
        imwrite(result, filename);
    end
end

% Create imageDatastore for the processed images
imds = imageDatastore(processedDir, 'LabelSource', 'none');
