# PaddleDetection CPU-GPU C++部署示例

本说明文档主要介绍部署示例使用方法。阅读本文档前建议提前阅读部署包目录下的部署包使用文档。

**使用部署示例前请确认：**

**1.按照使用文档要求安装 FastDeploy**

**2.完成部署示例编译**

## 1. 运行部署示例

推理命令格式为：
```
执行文件目录 预测模型文件路径 预测数据路径 推理后端数字选项
```
**注意：FastDeploy优先保证模型使用Paddle Inference和Paddle-TensorRT后端部署的正确性，推荐优先使用这两个后端，其他后端可能出现部署错误，请知悉。如果需要体验其他推理后端，可参考本文档第二节`部署示例选项说明`进行设置。**

```bash
# 准备一张测试图片，例如test.jpg

# 在CPU上使用Paddle Inference推理
./build/infer_demo model test.png 0
# 在GPU上使用Paddle Inference推理（需要安装GPU版本的FastDeploy）
./build/infer_demo model test.png 4

infer_demo.exe E:\image\FastDeploy\model 0.2mm9_front.bmp 4 0.2mm10_front.bmp 0.2mm12_front.bmp

infer_demo.exe ./../../../model 0.2mm9_front.bmp 4 0.2mm10_front.bmp 0.2mm12_front.bmp

infer_demo.exe ./../../../model/infer_model/inference.pdmodel ./test.jpeg 0

# 在GPU上使用Paddle TensorRT推理（需要安装GPU版本的FastDeploy）
# Paddle TensorRT推理后端可能存在TensorRT建图耗时较长情况，请留意
./build/infer_demo model test.png 5

# 注意：Windows系统需要将执行文件地址`./build/infer_dmo`更换为`.\build\Release\infer_demo.exe`
```

注意：在使用paddle_trt或者trt推理时，如遇到推理失败，需要调整trt_shape，min/max/opt需要设置相同的Shape

例如picodet_s_320_lcnet,调整的代码如下：
```c++
// paddle trt
option.UseGpu();
option.UsePaddleBackend();
option.paddle_infer_option.enable_trt = true;  // Paddle-TensorRT
option.paddle_infer_option.collect_trt_shape = true;
option.trt_option.SetShape("im_shape", {1, 2}, {1, 2}, {1, 2});
option.trt_option.SetShape("image", {1, 3, 320, 320}, {1, 3, 320, 320},
                               {1, 3, 320, 320});
option.trt_option.SetShape("scale_factor", {1, 2}, {1, 2}, {1, 2});

// trt  
option.UseGpu();
option.UseTrtBackend();  // TensorRT
option.trt_option.SetShape("im_shape", {1, 2}, {1, 2}, {1, 2});
option.trt_option.SetShape("image", {1, 3, 320, 320}, {1, 3, 320, 320},
                               {1, 3, 320, 320});
option.trt_option.SetShape("scale_factor", {1, 2}, {1, 2}, {1, 2});
```
## 2. 部署示例选项说明  

推理后端数字选项具体说明如下表所示：

|数字选项|含义|  
|:---:|:---:|  
|0| 在CPU上使用Paddle Inference推理 |  
|1| 在CPU上使用OpenVINO推理 |  
|2| 在CPU上使用ONNX Runtime推理 |  
|3| 在CPU上使用Paddle Lite推理 |  
|4| 在GPU上使用Paddle Inference推理 |  
|5| 在GPU上使用Paddle TensorRT推理 |  
|6| 在GPU上使用ONNX Runtime推理 |  
|7| 在GPU上使用Nvidia TensorRT推理 |  

## 3. 更多指南
- [PaddleDetection系列 C++ API查阅](https://www.paddlepaddle.org.cn/fastdeploy-api-doc/cpp/html/namespacefastdeploy_1_1vision_1_1detection.html)
