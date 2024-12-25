img = imread('building.jpg');

% Преобразование в оттенки серого, если изображение цветное
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

edges_canny_custom = edge(img_gray, 'Canny', [0.08 0.20], 1.4);
figure, imshow(edges_canny_custom);

edges_zerocross_custom = edge(img_gray, 'log', 0.04, 1.1);
figure, imshow(edges_zerocross_custom);
