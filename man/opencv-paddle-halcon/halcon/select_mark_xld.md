
```text
* ================== 参数 ==================
GrayLow  := 9000
GrayHigh := 11000
* threshold_sub_pix 的等值线阈值（位于 9000~11000 之间）
Iso      := 10000           
* 环带外扩（像素）
OuterR   := 25              
* 环带内缩（像素）
InnerR   := 6               
* 轮廓最小长度过滤
MinLen   := 40              

* ==========================================

* 读图（可改为你的路径）
read_image (Image, 'E:/halcon/Merge9601/2-2__1101_0_5279_5_20250806114405_0_.tif')
dev_display (Image)


* 1) 粗分割：仅用于锁定 ROI（黑孔候选）
threshold (Image, RegionDark, GrayLow, GrayHigh)
connection (RegionDark, Conn)
select_shape (Conn, MarksCoarse, 'area', 'and', 80, 5000)   
* 面积按实际微调
count_obj (MarksCoarse, N)

Rows := []
Cols := []
Rads := []

for i := 1 to N by 1
    select_obj (MarksCoarse, RegI, i)

    * 2) 生成环形 ROI，保证跨过真实边缘
    dilation_circle (RegI, RegOut, OuterR)
    erosion_circle  (RegI, RegIn,  InnerR)
    difference (RegOut, RegIn, RingROI)
    reduce_domain (Image, RingROI, ImgROI)

    * ====== 方法A：灰度等值线（优先，稳定闭合） ======
    threshold_sub_pix (ImgROI, Border, Iso)
    select_contours_xld (Border, BorderClosed, 'closed', MinLen, 1e10, -0.5, 0.5)
    length_xld (BorderClosed, Len)
    IfUseFallback := false
    if (|Len| > 0)
        tuple_max (Len, maxLen)
        * 0-based
        tuple_find (Len, maxLen, idxLongest)            
        * 1-based
        select_obj (BorderClosed, Cont, idxLongest+1)    
    else
        IfUseFallback := true
    endif

    if (IfUseFallback)
        * ====== 方法B：Canny亚像素边缘（回退） ======
        edges_sub_pix (ImgROI, Edges, 'canny', 1.2, 20, 40)
        union_adjacent_contours_xld (Edges, EdgesU, 10, 1, 'attr_keep')
        select_contours_xld (EdgesU, Cont, 'contour_length', MinLen, 1e10, -0.5, 0.5)
        length_xld (Cont, Len2)
        if (|Len2| = 0)
            continue
        endif
        tuple_max (Len2, maxLen2)
        tuple_find (Len2, maxLen2, idxLongest2)
        select_obj (Cont, Cont, idxLongest2+1)
    endif

    * 安全检查：点数足够再拟合
    get_contour_xld (Cont, RowPts, ColPts)
    if (|RowPts| < 10)
        continue
    endif

    * 3) 鲁棒圆拟合（亚像素）
    * 参数依次是：算法、最大点数、最大闭合距离、端点裁剪、迭代次数、裁剪因子
    * 最后 6 个是输出：RowC, ColC, Radius, StartPhi, EndPhi, PointOrder（注意是输出变量！）
    fit_circle_contour_xld (Cont, 'geotukey', -1, 5.0, 0, 20, 2.0, RowC, ColC, Radius, StartPhi, EndPhi, PointOrder)

    Rows := [Rows, RowC]
    Cols := [Cols, ColC]
    Rads := [Rads, Radius]
endfor

if (|Rows| < 2)
    dev_disp_text ('未找到足够的黑孔（<2）。请微调 GrayLow/High、面积或环带参数。', 'window', 20, 20, 'red', [], [])
    stop ()
endif

* 4) 上/下排序（无需 sort_index）
tuple_min (Rows, minRow)
tuple_find (Rows, minRow, idxTop)
tuple_max (Rows, maxRow)
tuple_find (Rows, maxRow, idxBot)

RowTop := Rows[idxTop]
ColTop := Cols[idxTop]
RowBot := Rows[idxBot]
ColBot := Cols[idxBot]

* 5) 可视化：圆与十字
gen_circle_contour_xld (CircTop, RowTop, ColTop, Rads[idxTop], 0, 6.28318, 'positive', 1.5)
gen_circle_contour_xld (CircBot, RowBot, ColBot, Rads[idxBot], 0, 6.28318, 'positive', 1.5)
gen_cross_contour_xld (Cross, [RowTop, RowBot], [ColTop, ColBot], 30, 0)

dev_set_color ('magenta')
dev_display (CircTop)
dev_display (CircBot)
dev_set_color ('yellow')
dev_display (Cross)

dev_disp_text ('Top: (' + RowTop$'.2f' + ',' + ColTop$'.2f' + '),  R=' + Rads[idxTop]$'.2f',  'image', RowTop+40, ColTop+40, 'yellow', [], [])
dev_disp_text ('Bot: (' + RowBot$'.2f' + ',' + ColBot$'.2f' + '),  R=' + Rads[idxBot]$'.2f',  'image', RowBot+40, ColBot+40, 'yellow', [], [])
```