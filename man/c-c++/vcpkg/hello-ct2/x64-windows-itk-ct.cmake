# ===== vcpkg triplet: x64-windows-itk-ct (工业CT)
set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)     # 需要静态可改为 static
set(VCPKG_LIBRARY_LINKAGE dynamic) # 需要静态可改为 static

# ---- 基本策略
set(ITK_BUILD_DEFAULT_MODULES OFF)        # 只开我们列出的
set(BUILD_SHARED_LIBS ON)                  # or OFF
set(ITK_DYNAMIC_LOADING ON)

# ---- Core / Registration 基础
set(Module_ITKCommon ON)
set(Module_ITKImageFunction ON)
set(Module_ITKImageFilterBase ON)
set(Module_ITKFiniteDifference ON)
set(Module_ITKFFT ON)
set(Module_ITKTransform ON)
set(Module_ITKTransformFactory ON)
set(Module_ITKMetricsv4 ON)
set(Module_ITKOptimizersv4 ON)
set(Module_ITKRegistrationCommon ON)
# 与 VTK 桥接（强烈建议）
set(Module_ITKVtkGlue ON)

# ---- IO（工业常用：原始体 / 切片 / NRRD / NIfTI / MetaIO）
set(Module_ITKIOImageBase ON)
set(Module_ITKIOMeta ON)     # *.mhd/*.raw
set(Module_ITKIONRRD ON)     # *.nrrd/*.nhdr
set(Module_ITKIONIFTI ON)    # *.nii（如需）
set(Module_ITKIOPNG ON)
set(Module_ITKIOTIFF ON)
set(Module_ITKIOTransformBase ON)

# ---- 图像处理 / 滤波增强
set(Module_ITKSmoothing ON)                       # 高斯/各类平滑
set(Module_AnisotropicDiffusionLBR ON)            # 各向异性扩散(可选)
set(Module_AdaptiveDenoising ON)                  # 自适应去噪(可选)
set(Module_TotalVariation ON)                     # TV 去噪(可选)
set(Module_PhaseSymmetry OFF)                     # 需要纹理/相位特征时再开
set(Module_ParabolicMorphology ON)                # 形态学(抛物线核)
set(Module_ITKBinaryMathematicalMorphology ON)    # 二值形态学
set(Module_TextureFeatures OFF)                   # 需要纹理统计时再开

# ---- 分割 / 配准算法
set(Module_ITKThresholding ON)
set(Module_ITKConnectedComponents ON)
set(Module_ITKLabelMap ON)
set(Module_ITKRegionGrowing ON)
set(Module_ITKWatersheds ON)
set(Module_ITKLevelSets ON)
set(Module_VariationalRegistration OFF)           # 需要高阶可开
set(Module_GrowCut OFF)                           # 交互式，按需
set(Module_TwoProjectionRegistration OFF)         # 特殊场景按需

# ---- 统计 / 分析
set(Module_ITKStatistics ON)
set(Module_PrincipalComponentsAnalysis ON)        # PCA
set(Module_SplitComponents ON)                    # 组件拆分
set(Module_Strain OFF)                            # 需要应变分析时再开
set(Module_Thickness3D OFF)                       # 需要厚度量测时再开

# ---- 几何 / 网格 / 点云
set(Module_MeshToPolyData ON)                     # Mesh ↔ VTK PolyData
set(Module_SubdivisionQuadEdgeMeshFilter ON)      # 网格细分(可选)
set(Module_MeshNoise OFF)                         # 网格降噪按需
set(Module_Cuberille OFF)                         # 表面重建按需
set(Module_Cleaver OFF)

# ---- RTK（工业/医疗CT重建核心）
set(Module_RTK ON)

# ---- 明确关闭的医疗专用/不常用
set(Module_BioCell OFF)
set(Module_BoneEnhancement OFF)
set(Module_BoneMorphometry OFF)
set(Module_LesionSizingToolkit OFF)
set(Module_SkullStrip OFF)
set(Module_Ultrasound OFF)
set(Module_IOOpenSlide OFF)       # 病理WSI
set(Module_MGHIO OFF)             # FreeSurfer
set(Module_SCIFIO OFF)            # SciJava生态
set(Module_Montage OFF)           # 显微拼接，按需
set(Module_TubeTK OFF)            # 血管/管状结构
set(Module_PerformanceBenchmarking OFF)
set(Module_WebAssemblyInterface OFF)
set(Module_VkFFTBackend OFF)      # 需要 Vulkan FFT 再开

# ---- CUDA (可选：需要 GPU 再改为 ON，并确保 CUDA 工具链)
set(Module_CudaCommon OFF)
