#!/usr/bin/env python

# This simple example shows how to do basic rendering and pipeline
# creation.

# noinspection PyUnresolvedReferences
import vtkmodules.vtkInteractionStyle
# noinspection PyUnresolvedReferences
import vtkmodules.vtkRenderingOpenGL2
from vtkmodules.vtkCommonColor import vtkNamedColors
from vtkmodules.vtkFiltersSources import vtkCylinderSource
from vtkmodules.vtkRenderingCore import (
    vtkActor,
    vtkPolyDataMapper,
    vtkRenderWindow,
    vtkRenderWindowInteractor,
    vtkRenderer
)


def main():
    colors = vtkNamedColors()
    # Set the background color.
    bkg = map(lambda x: x / 255.0, [26, 51, 102, 255])
    colors.SetColor("BkgColor", *bkg)

    # This creates a polygonal cylinder model with eight circumferential
    # facets.
    cylinder = vtkCylinderSource()
    cylinder.SetResolution(8)

    # The mapper is responsible for pushing the geometry into the graphics
    # library. It may also do color mapping, if scalars or other
    # attributes are defined.
    cylinderMapper = vtkPolyDataMapper()
    cylinderMapper.SetInputConnection(cylinder.GetOutputPort())

    # The actor is a grouping mechanism: besides the geometry (mapper), it
    # also has a property, transformation matrix, and/or texture map.
    # Here we set its color and rotate it -22.5 degrees.
    cylinderActor = vtkActor()
    cylinderActor.SetMapper(cylinderMapper)
    cylinderActor.GetProperty().SetColor(colors.GetColor3d("Tomato"))
    cylinderActor.RotateX(30.0)
    cylinderActor.RotateY(-45.0)

    # Create the graphics structure. The renderer renders into the render
    # window. The render window interactor captures mouse events and will
    # perform appropriate camera or actor manipulation depending on the
    # nature of the events.
    ren = vtkRenderer()
    renWin = vtkRenderWindow()
    renWin.AddRenderer(ren)
    iren = vtkRenderWindowInteractor()
    iren.SetRenderWindow(renWin)

    # Add the actors to the renderer, set the background and size
    ren.AddActor(cylinderActor)
    ren.SetBackground(colors.GetColor3d("BkgColor"))
    renWin.SetSize(300, 300)
    renWin.SetWindowName('CylinderExample')

    # This allows the interactor to initalize itself. It has to be
    # called before an event loop.
    iren.Initialize()

    # We'll zoom in a little by accessing the camera and invoking a "Zoom"
    # method on it.
    ren.ResetCamera()
    ren.GetActiveCamera().Zoom(1.5)
    renWin.Render()

    # Start the event loop.
    iren.Start()


if __name__ == '__main__':
    main()




3.1、配置、日志、并行/内存池、单元测试框架
3.2、校准功能：光源、探测器运动连线要同心；两个运动圆轨迹要同轴、同步对角等角运动、角度均匀；运动圆各自在自己的水平面，而且要平行。
3.3、运控功能：运控板卡、传感器驱动及配置，调试页面
3.4、取图功能：光源、探测器驱动及配置，调试页面，取图模块，存图模块
3.5、重建功能：重建配置；亮暗场矫正；评估及选择合理原图；重建所使用的数据结构定义及程序逻辑；使用及调用接口实现；
3.6、去伪影：环状伪影、硬化伪影、金属伪影等；
3.7、标定：影像坐标 vs 真实物理坐标（比如 CT 中 1 像素 = 0.1mm）
3.8、配准：影像 vs 影像（CT vs CT，CT vs MRI，CT vs CAD 模型）【优先低】
3.9、切割：MPR（三正交+任意斜切）、切割/裁剪【先做正交、斜切】
3.9、渲染：VR（体渲染）【先做灰度值】
3.10、测量：测量、分割（阈值/区域成长/半自动）
3.11、打包：结果打包
3.12、接口：使用接口、调试接口实现