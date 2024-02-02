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

% Initialize a cell array to store the blocks
blocks = cell(numBlocksY, numBlocksX);

% Create a figure for the grid display
%figure;

% Iterate through the blocks and extract them
for i = 1:numBlocksY
    for j = 1:numBlocksX
        % Calculate the coordinates for each block
        xStart = (j - 1) * blockSize + 1;
        xEnd = j * blockSize;
        yStart = (i - 1) * blockSize + 1;
        yEnd = i * blockSize;
        
        % Extract the block from the image
        blocks{i, j} = img(yStart:yEnd, xStart:xEnd, :);
        
        % Calculate the subplot position
        %subplot(numBlocksY, numBlocksX, (i-1)*numBlocksX + j);
        
        % Display each block
        %imshow(blocks{i, j});
        %title(['Block (' num2str(i) ',' num2str(j) ')']);
    end
end  
  % Assume 'blocks' is the cell array of 32x32 blocks obtained earlier

% Select a specific block (e.g., the first block)
selectedBlock = blocks{1, 1};

% Convert the selected block to grayscale
grayBlock = rgb2gray(selectedBlock);

% Perform DCT on the grayscale block
dctBlock = dct2(grayBlock);

% Create a random binary matrix of size 16x32
binaryMatrix = randi([0, 1], 16, 32);

% Multiply the DCT block with the random binary matrix
result = binaryMatrix * dctBlock;

% Display the original block, grayscale block, DCT block, and the result
figure;

subplot(1, 4, 1);
imshow(selectedBlock);
title('Original Block');

subplot(1, 4, 2);
imshow(grayBlock, []);
title('Grayscale Block');

subplot(1, 4, 3);
imshow(log(abs(dctBlock) + 1), []);
title('DCT of the Grayscale Block');

subplot(1, 4, 4);
imshow(result, []);
title('Result after Multiplication');
