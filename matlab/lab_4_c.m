image = imread('building.jpg');
grayImage = rgb2gray(image);
edges = edge(grayImage, 'Canny');

[H, theta, rho] = hough(edges);

numPeaks = 10;
peaks = houghpeaks(H, numPeaks, 'threshold', ceil(0.3 * max(H(:)))); 
lines = houghlines(edges, theta, rho, peaks, 'FillGap', 5, 'MinLength', 20);

figure;
imshow(image);
hold on;

for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'green');
    
    plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'yellow');
    plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');
end
hold off;

figure;
imshow(imadjust(rescale(H)), 'XData', theta, 'YData', rho, ...
       'InitialMagnification', 'fit');
xlabel('\theta (градусы)');
ylabel('\rho');
axis on;
axis normal;
hold on;
plot(theta(peaks(:,2)), rho(peaks(:,1)), 's', 'color', 'red');
