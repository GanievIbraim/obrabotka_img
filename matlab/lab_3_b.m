function g = intrans(f, varargin)
error(nargchk(2, 4, nargin)) 
classin = class(f);

if strcmp(class(f), 'double') && max(f(:)) > 1 && ~strcmp(varargin{1}, 'log')
f = mat2gray(f);
else
f = im2double(f);
end

method = varargin{1};

switch method
case 'neg'
    g = imcomplement(f);
case 'log'
    if length(varargin) == 1
        c = 1;
    elseif length(varargin) == 2
        c = varargin{2};
    elseif length(varargin) == 3
        c = varargin{2};
        classin = varargin{3};
    else
        error('Incorrect number of inputs for the log option.')
    end
    g = c * (log(1 + double(f)));
case 'gamma'
    if length(varargin) < 2
        error('Not enough inputs for the gamma option.')
    end
    gam = varargin{2};
    g = imadjust(f, [], [], gam);
case 'stretch'
    if length(varargin) < 2
        M = mean2(im2double(f));
        E = 4;
    else
        M = varargin{2};
        if length(varargin) < 3
            E = 4;
        else
            E = varargin{3};
        end
    end
    g = 1 ./ (1 + (M ./ (f + eps)).^E);
otherwise
    error('Unknown enhancement method.')
end

switch classin
case 'uint8'
    g = im2uint8(g);
case 'uint16'
    g = im2uint16(g);
case 'double'
    g = im2double(g);
otherwise
    error('Unsupported image class.');
end
end

I = imread('liftingbody_r0.png');

% Фотографический негатив
neg = intrans(I, 'neg');

% Преобразование растяжения контрастности
m = mean2(im2double(I));
contrast = intrans(I, 'stretch', m, 10);

% Логарифмическое преобразование
log_img = intrans(I, 'log', 2);

% Гамма-преобразование
gamma = intrans(I, 'gamma', 3);

figure, imshow(neg); title('Photographic Negative');
figure, imshow(contrast); title('Contrast Stretch Transformation');
figure, imshow(log_img); title('Logarithmic Transformation');
figure, imshow(gamma); title('Gamma Transformation');

