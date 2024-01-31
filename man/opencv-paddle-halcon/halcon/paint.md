

```text
*** 将小方块绘制到图像上
* 初始化
list_files('e:/image9', ['files','follow_links'], ImageFiles)
tuple_regexp_select(ImageFiles, ['\\.tif$','ignore_case'], ImageFiles)

* 遍历图像
for Index := 0 to |ImageFiles| - 1 by 1
    * 读取图像
    read_image(Image, ImageFiles[Index])

    * 初始化一个空的区域
    gen_empty_region(Squares)

    * 根据索引画出相应数量的小方块
    for i := 0 to Index by 1
        * 生成小方块区域
        gen_rectangle1(Rectangle, 10, 10+i*30, 30, 30+i*30)  // 增加间隔，每个方块间隔30像素
        concat_obj(Squares, Rectangle, Squares)
    endfor
    
    * 将小方块绘制到图像上
    paint_region(Squares, Image, Image, 255, 'fill')

    * 存储图像
    write_image(Image, 'tiff', 0, ImageFiles[Index])
endfor
```