
```text
* 读取图像
read_image (Image, 'E:/halcon/Merge9601/2-2__1101_0_5279_5_20250806114405_0_.tif')
get_image_size (Image, Width, Height)

* 显示原图
dev_display (Image)

* 按灰度阈值分割（9000–11000）
threshold (Image, Region, 9000, 11000)

* 连通域分割
connection (Region, Connected)

* 按面积和圆度筛选，保留可能的Mark点
select_shape (Connected, Marks, ['area','circularity'], 'and', [200,0.7], [999999,1.0])

* 提取圆心坐标
area_center (Marks, Area, Row, Column)

* 显示检测到的圆点
dev_set_color ('red')
dev_display (Marks)
dev_set_color ('green')
dev_set_draw ('margin')
* 取当前活动窗口句柄
dev_get_window (WindowHandle)

for Index := 0 to |Row|-1 by 1
    disp_cross(WindowHandle, Row[Index], Column[Index], 20, 0)
    dev_disp_text ('Mark ' + (Index+1), 'image', Row[Index]+25, Column[Index]-25, 'green', [], [])
endfor
```