building = imread('building.jpg');
building_gray = rgb2gray(building);
imshow(building_gray);
title('Исходное изображение в оттенках серого');

edge_image1 = imread('zerocross_building.jpg');
imshow(edge_image1);
title('Изображение 1');

edge_image2 = imread('canny_building.jpg');
imshow(edge_image2);
title('Изображение 2');

T_low = 0.04;
T_high = 0.1;
sigma = 1;
edge_canny = edge(building_gray, 'canny', [T_low T_high], sigma);
figure, imshow(edge_canny);
title('Детектор Канни');

edge_zerocross = edge(building_gray, 'zerocross');
figure, imshow(edge_zerocross);
title('Детектор Пересечения нулевого уровня');
