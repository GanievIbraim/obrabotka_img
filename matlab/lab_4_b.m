text = imread('text.jpg');
imshow(text);
title('Исходное изображение');
building_gray = rgb2gray(text);
T = graythresh(building_gray);
binary_image = imbinarize(building_gray, T);
figure, imshow(binary_image);
title('Пороговая обработка');
