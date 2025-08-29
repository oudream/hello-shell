Option Explicit

'====================== 入口宏 ======================
Sub CleanDoc()
    Const EXACT_TEXT As String = "知舒芯老师 知舒芯老师"   ' 精确匹配艺术字
    Dim hdrDel&, artDel&, bgDel&

    hdrDel = ClearAllHeaders()                            '① 清空页眉
    artDel = DeleteExactWordArtInBody(EXACT_TEXT)         '② 删指定艺术字
    bgDel = DeleteOneBigPicturePerPage()                  '③ 每页删一个大背景图片

    MsgBox "已清空页眉：" & hdrDel & " 形状" & vbCrLf & _
           "已删艺术字：" & artDel & " 形状" & vbCrLf & _
           "已删背景图：" & bgDel & " 张", _
           vbInformation, "处理完成"
End Sub


'---------------- ① 清空所有节的页眉 ----------------
Private Function ClearAllHeaders() As Long
    Dim sec As Section, hdr As HeaderFooter, shp As Shape, n&
    For Each sec In ActiveDocument.Sections
        For Each hdr In sec.Headers                       '如需页脚换 Footers
            For Each shp In hdr.Shapes
                shp.Delete: n = n + 1
            Next shp
            hdr.Range.Delete                              '页眉文字
        Next hdr
    Next sec
    ClearAllHeaders = n
End Function


'---------------- ② 精确删除指定艺术字 ----------------
Private Function DeleteExactWordArtInBody(tgt$) As Long
    Dim rng As Range, n&, sr As ShapeRange
    For Each rng In ActiveDocument.StoryRanges            '正文 / 文本框
        Select Case rng.StoryType
            Case wdMainTextStory, wdTextFrameStory, wdFootnotesStory, _
                 wdEndnotesStory, wdCommentsStory

                 Set sr = rng.ShapeRange
                 n = n + DeleteExactShapes(sr, tgt)
        End Select
    Next rng
    DeleteExactWordArtInBody = n
End Function

Private Function DeleteExactShapes(sr As ShapeRange, tgt$) As Long
    Dim i&, n&
    For i = sr.Count To 1 Step -1
        If IsExactText(sr(i), tgt) Then sr(i).Delete: n = n + 1
    Next i
    DeleteExactShapes = n
End Function

Private Function IsExactText(shp As Shape, tgt$) As Boolean
    On Error Resume Next
    If shp.Type = msoGroup Then                    '递归分组
        Dim g As Shape
        For Each g In shp.GroupItems
            If IsExactText(g, tgt) Then IsExactText = True: Exit Function
        Next g
    Else
        Dim t$: t = ""
        If shp.TextFrame.HasText Then t = shp.TextFrame.TextRange.Text
        If shp.TextEffect.Text <> "" Then t = shp.TextEffect.Text
        If Trim(Replace(t, vbCr, vbNullString, , , vbTextCompare)) = tgt Then _
            IsExactText = True
    End If
    On Error GoTo 0
End Function


'---------------- ③ 每页删除一张大图片（靠顶部） ----------------
Private Function DeleteOneBigPicturePerPage() As Long
    Dim sr As ShapeRange, shp As Shape
    Dim i&, n&, pgW!, pgH!, thW!, thH!, topTh!
    Dim delPages As Object: Set delPages = CreateObject("Scripting.Dictionary")

    Dim firstPageRange As Range
    Set firstPageRange = ActiveDocument.Range(0, 0)
    pgW = firstPageRange.PageSetup.PageWidth
    pgH = firstPageRange.PageSetup.PageHeight
    thW = pgW * 0.9            ' 宽 ≥ 90%
    thH = pgH * 0.5            ' 高 ≥ 50%
    topTh = 80                 ' 顶部 ≤ 80pt ≈ 1.1厘米（可调整）

    Set sr = ActiveDocument.StoryRanges(wdMainTextStory).ShapeRange

    For i = sr.Count To 1 Step -1
        Set shp = sr(i)
        If shp.Type = msoPicture Or shp.Type = msoLinkedPicture Then
            If shp.Width >= thW And shp.Height >= thH Then
                If shp.Top <= topTh Then
                    Dim pgNum&
                    pgNum = shp.Anchor.Information(wdActiveEndPageNumber)
                    If Not delPages.Exists(pgNum) Then
                        shp.Delete
                        delPages.Add pgNum, True
                        n = n + 1
                    End If
                End If
            End If
        End If
    Next i

    DeleteOneBigPicturePerPage = n
End Function
