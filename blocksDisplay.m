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
figure;

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
        subplot(numBlocksY, numBlocksX, (i-1)*numBlocksX + j);
        
        % Display each block
        imshow(blocks{i, j});
        title(['Block (' num2str(i) ',' num2str(j) ')']);
    end
end
