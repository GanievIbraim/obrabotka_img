image1 = load('image.dat');

i_low = min(image1(:));
i_high = max(image1(:));
i_mean = mean(image1(:));

k = 255 / (i_high - i_low);
image2 = image1 - i_low;
image3 = image2 * k;

figure, imshow(uint8(image1));
figure, imshow(uint8(image2));
figure, imshow(uint8(image3));