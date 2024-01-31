
```text
* 关闭窗口后重新打开
dev_close_window()
dev_open_window (0, 0, 600, 400, 'black', WindowHandle)
* 创建一张空白图片
gen_empty_obj (Images)
* 遍历文件夹
list_files ('e:/image9', ['files','follow_links'], ImageFiles)
tuple_regexp_select (ImageFiles, ['\\.(tif|tiff|gif|bmp|jpg|jpeg|jp2|png|pcx|pgm|ppm|pbm|xwd|ima|hobj)$','ignore_case'], ImageFiles)
for Index := 0 to |ImageFiles| - 1 by 1
    read_image (Image, ImageFiles[Index])
    * 图片统一大小
    zoom_image_size (Image, ImageZoom, 200, 200, 'constant')
    concat_obj (Images, ImageZoom, Images)
endfor
* 合并图片(按行填充，一行填满4张图片后再填充下一行)
tile_images (Images, TiledImage, 4, 'horizontal')
dev_display (TiledImage)
```


```text
* 关闭窗口后重新打开
dev_close_window()
dev_open_window(0, 0, 600, 400, 'black', WindowHandle)

* 创建一张空白图片
gen_empty_obj (Images)

* 遍历文件夹
list_files('e:/image9', ['files','follow_links'], ImageFiles)
tuple_regexp_select(ImageFiles, ['\\.tif$','ignore_case'], ImageFiles)

* 初始化
ConcatenatedName := ''
Count := 0

* 遍历图像
for Index := 0 to |ImageFiles| - 1 by 1
    read_image(Image, ImageFiles[Index])
    
    * 图片旋转90度
    rotate_image(Image, RotatedImage, 90, 'constant')

    * 将旋转后的图片添加到对象中
    concat_obj(Images, RotatedImage, Images)
    Count := Count + 1

    * 提取文件名，用于后续命名
    parse_filename (ImageFiles[Index], BaseName, Extension, Directory)
    ConcatenatedName := ConcatenatedName + BaseName + '-'

    Mod := Count % 5
    * 每5张图像合成一张，并保存
    if (Mod = 0)
        * 合并图片
        tile_images(Images, TiledImage, 5, 'horizontal')
        dev_display(TiledImage)

        * 保存合成图像
        write_image(TiledImage, 'tiff', 0, 'e:/image9/' + ConcatenatedName)
        
        * 重置变量
        gen_empty_obj(Images)
        ConcatenatedName := ''
    endif
endfor

Mod := Count % 5
* 处理剩余的图像（如果有）
if (Mod = 0)
    * 合并图片
    tile_images(Images, TiledImage, 5, 'horizontal')
    dev_display(TiledImage)

    * 保存合成图像
    write_image(TiledImage, 'tiff', 0, 'e:/image9/' + ConcatenatedName)
endif
```