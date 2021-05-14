workingDir = 'C:\\Users\\jscot\\OneDrive\\Documents\\MATLAB\\NAVI\\AllDemoFiles';
% mkdir(workingDir,'images')
% demoVideo = VideoReader('demo.avi');

% i = 1;
% 
% while hasFrame(demoVideo)
%    img = readFrame(demoVideo);
%    filename = ['F' sprintf('%03d',i) '.jpg'];
%    fullname = fullfile(folder,'images',filename);
%    imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
%    i = i+1;
% end

imageNames = dir(fullfile(workingDir,'images','*.jpg'));
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(workingDir,'demo.avi'));
outputVideo.FrameRate = 1;
open(outputVideo)

for i = 1:length(imageNames)
   img = imread(fullfile(workingDir,'images',imageNames{i}));
   writeVideo(outputVideo,img)
end

close(outputVideo)

