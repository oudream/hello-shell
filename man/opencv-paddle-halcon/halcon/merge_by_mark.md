```text
* ================== 参数 ==================
GrayLow  := 9000
GrayHigh := 11000
* 等值线阈值（位于 GrayLow~GrayHigh）
Iso      := 10000          
* 环带外扩（像素）
OuterR   := 25             
* 环带内缩（像素）
InnerR   := 6              
* 轮廓最小长度过滤
MinLen   := 40             
* ==========================================

* ========== 读图（按需改路径） ==========
FileRight := 'E:/halcon/Merge9601/2-2__1101_0_5279_5_20250806114405_0_.tif'
FileLeft  := 'E:/halcon/Merge9601/2-2__1101_0_5279_5_20250806114409_1_.tif'
read_image (ImageRight, FileRight)
read_image (ImageLeft,  FileLeft)

* ---------- 公用变量 ----------
RowsR := []
ColsR := []
RadsR := []
RowsL := []
ColsL := []
RadsL := []

* =========================================================
* =============== 右图：查找两个黑孔 Mark ================
* =========================================================
threshold (ImageRight, RegionDarkR, GrayLow, GrayHigh)
connection (RegionDarkR, ConnR)
select_shape (ConnR, MarksCoarseR, 'area', 'and', 80, 5000)
count_obj (MarksCoarseR, NR)

for i := 1 to NR by 1
    select_obj (MarksCoarseR, RegI, i)
    dilation_circle (RegI, RegOut, OuterR)
    erosion_circle  (RegI, RegIn,  InnerR)
    difference (RegOut, RegIn, RingROI)
    reduce_domain (ImageRight, RingROI, ImgROI)

    * --- A：等值线（首选） ---
    threshold_sub_pix (ImgROI, Border, Iso)
    select_contours_xld (Border, BorderClosed, 'closed', 1, 1, -0.5, 0.5)
    select_contours_xld (BorderClosed, BorderClosed, 'contour_length', MinLen, 1e10, -0.5, 0.5)
    length_xld (BorderClosed, Len)
    IfUseFallback := false
    if (|Len| > 0)
        tuple_max (Len, maxLen)
        tuple_find (Len, maxLen, idxLongest)
        select_obj (BorderClosed, Cont, idxLongest+1)
    else
        IfUseFallback := true
    endif

    if (IfUseFallback)
        * --- B：Canny 亚像素（回退） ---
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

    get_contour_xld (Cont, RowPts, ColPts)
    if (|RowPts| < 10)
        continue
    endif

    fit_circle_contour_xld (Cont, 'geotukey', -1, 5.0, 0, 20, 2.0, RowC, ColC, Radius, StartPhi, EndPhi, PointOrder)
    RowsR := [RowsR, RowC]
    ColsR := [ColsR, ColC]
    RadsR := [RadsR, Radius]
endfor

if (|RowsR| < 2)
    dev_disp_text ('右图 Mark 不足2个，请调参。', 'window', 20, 20, 'red', [], [])
    stop ()
endif

* 上/下排序
tuple_min (RowsR, minRowR)
tuple_find (RowsR, minRowR, idxTopR)
tuple_max (RowsR, maxRowR)
tuple_find (RowsR, maxRowR, idxBotR)
RowTopR := RowsR[idxTopR]
ColTopR := ColsR[idxTopR]
RowBotR := RowsR[idxBotR]
ColBotR := ColsR[idxBotR]

* 可视化（右）
dev_display (ImageRight)
gen_circle_contour_xld (circRT, RowTopR, ColTopR, RadsR[idxTopR], 0, 6.28318, 'positive', 1.5)
gen_circle_contour_xld (circRB, RowBotR, ColBotR, RadsR[idxBotR], 0, 6.28318, 'positive', 1.5)
gen_cross_contour_xld (crossR, [RowTopR,RowBotR], [ColTopR,ColBotR], 30, 0)
dev_set_color ('magenta')
dev_display (circRT)
dev_display (circRB)
dev_set_color ('yellow')
dev_display (crossR)

* =========================================================
* =============== 左图：查找两个黑孔 Mark ================
* =========================================================
threshold (ImageLeft, RegionDarkL, GrayLow, GrayHigh)
connection (RegionDarkL, ConnL)
select_shape (ConnL, MarksCoarseL, 'area', 'and', 80, 5000)
count_obj (MarksCoarseL, NL)

for i := 1 to NL by 1
    select_obj (MarksCoarseL, RegI, i)
    dilation_circle (RegI, RegOut, OuterR)
    erosion_circle  (RegI, RegIn,  InnerR)
    difference (RegOut, RegIn, RingROIL)
    reduce_domain (ImageLeft, RingROIL, ImgROIL)

    threshold_sub_pix (ImgROIL, BorderL, Iso)
    select_contours_xld (BorderL, BorderClosedL, 'closed', 1, 1, -0.5, 0.5)
    select_contours_xld (BorderClosedL, BorderClosedL, 'contour_length', MinLen, 1e10, -0.5, 0.5)
    length_xld (BorderClosedL, LenL)
    IfUseFallbackL := false
    if (|LenL| > 0)
        tuple_max (LenL, maxLenL)
        tuple_find (LenL, maxLenL, idxLongestL)
        select_obj (BorderClosedL, ContL, idxLongestL+1)
    else
        IfUseFallbackL := true
    endif

    if (IfUseFallbackL)
        edges_sub_pix (ImgROIL, EdgesL, 'canny', 1.2, 20, 40)
        union_adjacent_contours_xld (EdgesL, EdgesUL, 10, 1, 'attr_keep')
        select_contours_xld (EdgesUL, ContL, 'contour_length', MinLen, 1e10, -0.5, 0.5)
        length_xld (ContL, Len2L)
        if (|Len2L| = 0)
            continue
        endif
        tuple_max (Len2L, maxLen2L)
        tuple_find (Len2L, maxLen2L, idxLongest2L)
        select_obj (ContL, ContL, idxLongest2L+1)
    endif

    get_contour_xld (ContL, RowPtsL, ColPtsL)
    if (|RowPtsL| < 10)
        continue
    endif

    fit_circle_contour_xld (ContL, 'geotukey', -1, 5.0, 0, 20, 2.0, RowCL, ColCL, RadiusL, StartPhiL, EndPhiL, PointOrderL)
    RowsL := [RowsL, RowCL]
    ColsL := [ColsL, ColCL]
    RadsL := [RadsL, RadiusL]
endfor

if (|RowsL| < 2)
    dev_disp_text ('左图 Mark 不足2个，请调参。', 'window', 60, 20, 'red', [], [])
    stop ()
endif

* 上/下排序
tuple_min (RowsL, minRowL)
tuple_find (RowsL, minRowL, idxTopL)
tuple_max (RowsL, maxRowL)
tuple_find (RowsL, maxRowL, idxBotL)
RowTopL := RowsL[idxTopL]
ColTopL := ColsL[idxTopL]
RowBotL := RowsL[idxBotL]
ColBotL := ColsL[idxBotL]

* 可视化（左）
dev_display (ImageLeft)
gen_circle_contour_xld (circLT, RowTopL, ColTopL, RadsL[idxTopL], 0, 6.28318, 'positive', 1.5)
gen_circle_contour_xld (circLB, RowBotL, ColBotL, RadsL[idxBotL], 0, 6.28318, 'positive', 1.5)
gen_cross_contour_xld (crossL, [RowTopL,RowBotL], [ColTopL,ColBotL], 30, 0)
dev_set_color ('magenta')
dev_display (circLT)
dev_display (circLB)
dev_set_color ('yellow')
dev_display (crossL)

* =========================================================
* ============== 建立点对 → 求右->左单应矩阵 ===============s
* =========================================================
LeftPoints  := [RowTopL, ColTopL, RowBotL, ColBotL]
RightPoints := [RowTopR, ColTopR, RowBotR, ColBotR]

hom_vector_to_proj_hom_mat2d (RightPoints, LeftPoints, 'gold_standard', HomMat2D)

* =========================================================
* =================== 无缝拼接并显示 ======================
* =========================================================
gen_projective_mosaic ([ImageLeft, ImageRight], MosaicImage, 0, [1], [0], [HomMat2D], 'default')
dev_display (MosaicImage)
dev_disp_text ('完成：基于上下黑孔 Mark 的右->左拼接（gen_projective_mosaic）', 'window', 20, 20, 'white', [], [])

```