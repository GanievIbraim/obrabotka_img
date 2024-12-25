@echo off
REM Конвертация RAW в PNG
REM magick sunset.cr2 sunset.png
REM echo PNG создан: sunset.png
REM pause

REM Конвертация RAW в WebP без потерь
REM magick sunset.cr2 -define webp:lossless=true sunset_lossless.webp
REM echo WebP без потерь создан: sunset_lossless.webp
REM pause

REM Конвертация RAW в JPEG без потерь
REM magick sunset.cr2 -quality 100 -sampling-factor 4:4:4 -interlace JPEG -colorspace RGB sunset_lossless.jpg
REM echo JPEG без потерь создан: sunset_lossless.jpg
REM pause

REM Конвертация RAW в WebP с качеством 30%
REM magick sunset.cr2 -quality 30 sunset_webp_30.webp
REM echo WebP с качеством 30% создан: sunset_webp_30.webp
REM pause

REM Конвертация RAW в WebP с качеством 60%
REM magick sunset.cr2 -quality 60 sunset_webp_60.webp
REM echo WebP с качеством 60% создан: sunset_webp_60.webp
REM pause

REM Узнать размер файла sunset_webp_60.webp
REM for /f "delims=" %%i in ('magick identify -format "%%b" sunset_webp_60.webp') do set size=%%i
REM echo Размер WebP 60%: %size% байт
REM pause

REM Конвертация RAW в JPEG с качеством 30%
REM magick sunset.cr2 -quality 30 sunset_jpeg_30.jpg
REM echo JPEG с качеством 30% создан: sunset_jpeg_30.jpg
REM pause

REM Конвертация RAW в JPEG с качеством 60%
REM magick sunset.cr2 -quality 60 sunset_jpeg_60.jpg
REM echo JPEG с качеством 60% создан: sunset_jpeg_60.jpg
REM pause

REM Попытка создать JPEG файл того же размера, что и WebP 60%
REM Начнем с качества 60 и будем корректировать
set quality=60
set size=0

@echo off
setlocal enabledelayedexpansion

REM Инициализация переменной качества
set quality=60

REM Получаем размер WebP файла
for /f "delims=" %%i in ('magick identify -format "%%b" sunset_webp_60.webp') do set size=%%i

REM Начало цикла корректировки качества
:loop
magick sunset.cr2 -quality !quality! sunset_jpeg_60_size.jpg

REM Получаем размер JPEG файла
for /f "delims=" %%i in ('magick identify -format "%%b" sunset_jpeg_60_size.jpg') do set jpeg_size=%%i

REM Проверка размера файла
echo Размер WebP: !size! байт
echo Размер JPEG: !jpeg_size! байт

REM Если JPEG меньше WebP, увеличиваем качество
if !jpeg_size! LSS !size! (
    set /a quality+=1
) else if !jpeg_size! GTR !size! (
    set /a quality-=1
) else (
    goto :end
)

REM Переход к следующей итерации
REM Добавим ограничение на количество итераций, чтобы избежать бесконечного цикла
if !quality! lss 1 goto :end
if !quality! gtr 100 goto :end

goto :loop

:end
echo JPEG с размером, близким к WebP 60%, создан: sunset_jpeg_60_size.jpg
pause


REM Сравнение файлов
REM magick compare sunset.png sunset_lossless.webp -compose difference diff_png_webp_lossless.png
REM echo Сравнение PNG и WebP без потерь: diff_png_webp_lossless.png


REM magick compare sunset.png sunset_lossless.jpg -compose difference diff_png_jpeg_lossless.png
REM echo Сравнение PNG и JPEG без потерь: diff_png_jpeg_lossless.png


REM magick compare sunset.cr2 sunset_webp_60.webp -compose difference diff_raw_webp_60.png
REM echo Сравнение RAW и WebP 60%: diff_raw_webp_60.png


REM magick compare sunset.cr2 sunset_jpeg_60_size.jpg -compose difference diff_raw_jpeg_60.png
REM echo Сравнение RAW и JPEG 60%: diff_raw_jpeg_60.png

magick compare sunset_webp_60.webp sunset_jpeg_60_size.jpg -compose difference diff_webp_jpeg_60.png
echo Сравнение WebP 60% и JPEG 60%: diff_webp_jpeg_60.png

REM Изменение размера файлов-разниц до 1x1 пикселя
magick diff_png_webp_lossless.png -resize 1x1! diff_png_webp_lossless_1x1.png
magick diff_png_jpeg_lossless.png -resize 1x1! diff_png_jpeg_lossless_1x1.png
magick diff_raw_webp_60.png -resize 1x1! diff_raw_webp_60_1x1.png
magick diff_raw_jpeg_60.png -resize 1x1! diff_raw_jpeg_60_1x1.png
magick diff_webp_jpeg_60.png -resize 1x1! diff_webp_jpeg_60_1x1.png

REM Получение значений пикселей
for /f "delims=" %%i in ('magick diff_png_webp_lossless_1x1.png -format "%%[pixel:p{0,0}]" info:') do set png_webp_lossless_pixel=%%i
echo Значение пикселя для diff_png_webp_lossless_1x1.png: %png_webp_lossless_pixel%


for /f "delims=" %%i in ('magick diff_png_jpeg_lossless_1x1.png -format "%%[pixel:p{0,0}]" info:') do set png_jpeg_lossless_pixel=%%i
echo Значение пикселя для diff_png_jpeg_lossless_1x1.png: %png_jpeg_lossless_pixel%


for /f "delims=" %%i in ('magick diff_raw_webp_60_1x1.png -format "%%[pixel:p{0,0}]" info:') do set raw_webp_60_pixel=%%i
echo Значение пикселя для diff_raw_webp_60_1x1.png: %raw_webp_60_pixel%


for /f "delims=" %%i in ('magick diff_raw_jpeg_60_1x1.png -format "%%[pixel:p{0,0}]" info:') do set raw_jpeg_60_pixel=%%i
echo Значение пикселя для diff_raw_jpeg_60_1x1.png: %raw_jpeg_60_pixel%


for /f "delims=" %%i in ('magick diff_webp_jpeg_60_1x1.png -format "%%[pixel:p{0,0}]" info:') do set webp_jpeg_60_pixel=%%i
echo Значение пикселя для diff_webp_jpeg_60_1x1.png: %webp_jpeg_60_pixel%
pause
