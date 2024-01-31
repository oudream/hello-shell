import numpy as np
import cv2
from matplotlib import pyplot as plt
import matplotlib
matplotlib.use('TkAgg')

# 假设img是一个16位的灰度图像，首先读取图像
img = cv2.imread('E:/image9/5.tif', cv2.IMREAD_UNCHANGED)

# # 确定灰度拉伸区间
# low_thresh, high_thresh = 1000, 60000  # 示例值，实际应根据图像直方图确定
#
# # 应用灰度拉伸
# img_stretched = np.clip((img - low_thresh) / (high_thresh - low_thresh) * 65535, 0, 65535).astype(np.uint16)
#
# # 显示结果
# plt.figure(figsize=(10, 5))
# plt.subplot(1, 2, 1)
# plt.imshow(img, cmap='gray')
# plt.title('Original Image')
# plt.subplot(1, 2, 2)
# plt.imshow(img_stretched, cmap='gray')
# plt.title('Stretched Image')
# plt.show()
# 计算直方图，对于16位图像，我们使用更多的bins





# # 应用双边滤波
# # 假设img是一个16位的灰度图像
# # 转换图像到32位浮点数格式
# img_float32 = np.float32(img) / 65535.0  # 将值范围从[0, 65535]映射到[0, 1]
# # 注意：双边滤波的参数可能需要根据你的具体需求进行调整
# img_bilateral_filtered = cv2.bilateralFilter(img_float32, 9, 75, 75)
# # 将过滤后的图像转换回16位整数格式（如果需要）
# img_bilateral_filtered_uint16 = np.uint16(img_bilateral_filtered * 65535)




# 使用高斯滤波进行噪声过滤
# img_filtered = cv2.GaussianBlur(img, (5, 5), 0)
# img_median_filtered = cv2.medianBlur(img, 5)  # 中值滤波 使用5x5的核进行中值滤波
# img_bilateral_filtered = cv2.bilateralFilter(img, 9, 75, 75)  # 双边滤波 参数diameter=9, sigmaColor=sigmaSpace=75
# img_nlm_filtered = cv2.fastNlMeansDenoising(img, None, 30, 7, 21)  # 对于彩色图像使用cv2.fastNlMeansDenoisingColored

# 计算直方图，对于16位图像，我们使用更多的bins
hist, bins = np.histogram(img.flatten(), 65536, [0, 65536])

# hist, bins = np.histogram(img.flatten(), 65536, [0,65536])

# 计算累积分布函数（CDF）
hist_cdf = hist.cumsum()
hist_cdf_normalized = hist_cdf / hist_cdf.max()

# 找到累积分布的5%和95%位置作为阈值
cdf_m = np.ma.masked_less_equal(hist_cdf, 0) # 忽略累积为0的值
cdf_m_normalized = cdf_m / cdf_m.max()
low_thresh_index = np.where(cdf_m_normalized > 0.03)[0][0]
high_thresh_index = np.where(cdf_m_normalized < 0.97)[0][-1]

# 应用灰度拉伸
img_stretched = np.zeros_like(img)
# 注意处理除0情况
if high_thresh_index - low_thresh_index > 0:
    img_stretched = (img - low_thresh_index) / (high_thresh_index - low_thresh_index) * 65535
    img_stretched[img < low_thresh_index] = 0
    img_stretched[img > high_thresh_index] = 65535
img_stretched = np.clip(img_stretched, 0, 65535).astype(np.uint16)




# 显示图像和直方图
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.imshow(img, cmap='gray')
plt.title('Original Image')

plt.subplot(1, 2, 2)


# # 将灰度拉伸后的图像转换为32位浮点数格式
# img_stretched_float32 = np.float32(img_stretched) / 65535.0
# # 应用双边滤波
# img_filtered_after_stretch = cv2.bilateralFilter(img_stretched_float32, 9, 75, 75)
# # 将过滤后的图像转换回16位整数格式（如果需要）
# img_filtered_after_stretch_uint16 = np.uint16(img_filtered_after_stretch * 65535)
# 显示过滤后的图像
# plt.imshow(img_filtered_after_stretch_uint16, cmap='gray')
# plt.title('Filtered Image After Stretch')
# plt.show()


plt.imshow(img_stretched, cmap='gray')
plt.title('Stretched Image')
plt.show()