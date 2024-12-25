two_cats = imread('two_cats.jpg');

h_filter = fspecial('sobel');
horizontal_edges = imfilter(two_cats, h_filter');
figure, imshow(horizontal_edges), title('Горизонтальные края');

vertical_edges = imfilter(two_cats, h_filter);
figure, imshow(vertical_edges), title('Вертикальные края');

combined_edges = horizontal_edges + vertical_edges;
figure, imshow(combined_edges), title('Комбинированные края');
