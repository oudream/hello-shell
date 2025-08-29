#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
生成四个相机参数演示动图（无需VTK）：
- vtk_parallel_scale.gif         （ParallelScale 正交缩放）
- vtk_parallel_projection.gif    （ParallelProjection 透视↔正交对比）
- vtk_clip.gif                   （Clip 近/远裁剪面）
- vtk_focal_point.gif            （FocalPoint 固定机位，移动对焦点）

依赖：numpy, matplotlib, imageio
用法：python gen_vtk_camera_gifs.py --out ./out --size 320 --fps 20
"""

import argparse
from pathlib import Path
import numpy as np

# 强制使用稳定的无界面后端，避免 tostring_rgb 等兼容性问题
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection
import imageio.v2 as imageio


# ---------------- 基础数学与投影 ----------------

def normalize(v):
    v = np.asarray(v, dtype=float)
    n = np.linalg.norm(v)
    return v if n == 0 else v / n

def camera_axes(C, F, Up):
    """返回世界->相机旋转矩阵 R（列为 right/up/forward）"""
    n = normalize(np.array(F) - np.array(C))  # forward
    r = normalize(np.cross(n, Up))            # right
    v = normalize(np.cross(r, n))             # true up
    return np.stack([r, v, n], axis=1)

def world_to_camera(P, C, R):
    return (P - C) @ R

def persp_project(Pc, vfov_deg=45.0):
    """透视投影（简化），返回2D点与z深度"""
    z = Pc[..., 2]
    x = Pc[..., 0]
    y = Pc[..., 1]
    f = 1.0 / np.tan(np.deg2rad(vfov_deg) / 2.0)
    z = np.where(np.abs(z) < 1e-6, np.sign(z) * 1e-6, z)
    return np.stack([f * x / z, f * y / z], axis=-1), z

def ortho_project(Pc, parallel_scale=1.0):
    """正交投影，parallel_scale 越大画面越小"""
    s = 1.0 / max(parallel_scale, 1e-6)
    return Pc[..., :2] * s, Pc[..., 2]

def cube_edges(size=1.0):
    s = size
    vs = np.array([[-s,-s,-s],[ s,-s,-s],[ s, s,-s],[-s, s,-s],
                   [-s,-s, s],[ s,-s, s],[ s, s, s],[-s, s, s]], dtype=float)
    es = [(0,1),(1,2),(2,3),(3,0),
          (4,5),(5,6),(6,7),(7,4),
          (0,4),(1,5),(2,6),(3,7)]
    return vs, es

def project_edges(V, E, C, F, Up, *, mode='persp', vfov=45.0, parallel_scale=1.0):
    R  = camera_axes(C, F, Up)
    Vc = world_to_camera(V, np.array(C), R)
    if mode == 'persp':
        P2, _ = persp_project(Vc, vfov_deg=vfov)
    else:
        P2, _ = ortho_project(Vc, parallel_scale=parallel_scale)
    return [(P2[i], P2[j], Vc[i,2], Vc[j,2]) for i,j in E]

def apply_clipping(segs, near_z=0.1, far_z=10.0):
    """简化裁剪：整条边完全在(near, far)之外则丢弃"""
    return [(p,q) for p,q,zi,zj in segs if max(zi, zj) >= near_z and min(zi, zj) <= far_z]

def draw_frame(ax, segs2d, title="", lim=2.0):
    ax.clear()
    if segs2d:
        lines = [np.vstack([p, q]) for p, q in segs2d]
        ax.add_collection(LineCollection(lines))
    ax.set_xlim(-lim, lim)
    ax.set_ylim(-lim, lim)
    ax.set_aspect('equal', 'box')
    ax.axis('off')
    ax.set_title(title, fontsize=10)

def fig_to_rgb(fig):
    """通用读取帧（兼容各种后端）：buffer_rgba → drop alpha"""
    fig.canvas.draw()
    w, h = fig.canvas.get_width_height()
    buf = np.frombuffer(fig.canvas.buffer_rgba(), dtype=np.uint8)
    arr = buf.reshape(h, w, 4)[..., :3].copy()
    return arr


# ---------------- 四个动画 ----------------

def anim_parallel_scale(out_path, size_px=320, fps=20):
    V, E = cube_edges(1.0)
    C, F, Up = np.array([3,3,3]), np.array([0,0,0]), np.array([0,0,1])
    ts = list(np.linspace(0,1,36)) + list(np.linspace(1,0,36))
    frames = []
    for t in ts:
        scale = 0.6 + 3.0 * t
        segs  = project_edges(V,E,C,F,Up,mode='ortho',parallel_scale=scale)
        segs2d= apply_clipping(segs, 0.01, 100.0)
        fig, ax = plt.subplots(figsize=(size_px/100, size_px/100), dpi=100)
        draw_frame(ax, segs2d, f"ParallelScale = {scale:.2f}", lim=2.0)
        frames.append(fig_to_rgb(fig)); plt.close(fig)
    imageio.mimsave(out_path, frames, duration=1.0/fps)

def anim_parallel_projection(out_path, size_px=320, fps=20):
    V, E = cube_edges(1.0)
    C, F, Up = np.array([3,3,3]), np.array([0,0,0]), np.array([0,0,1])
    frames = []
    for t in np.linspace(0,1,60):
        # 透视
        segs_p  = project_edges(V,E,C,F,Up,mode='persp',vfov=45.0)
        segs2d_p= apply_clipping(segs_p, 0.1, 100.0)
        fig1, ax1 = plt.subplots(figsize=(size_px/100, size_px/100), dpi=100)
        draw_frame(ax1, segs2d_p, "Perspective (ViewAngle)", lim=2.0)
        frame_p = fig_to_rgb(fig1); plt.close(fig1)
        # 正交
        segs_o  = project_edges(V,E,C,F,Up,mode='ortho',parallel_scale=1.4)
        segs2d_o= apply_clipping(segs_o, 0.01, 100.0)
        fig2, ax2 = plt.subplots(figsize=(size_px/100, size_px/100), dpi=100)
        draw_frame(ax2, segs2d_o, "ParallelProjection (Orthographic)", lim=2.0)
        frame_o = fig_to_rgb(fig2); plt.close(fig2)
        # 平滑过渡（只是视觉演示）
        frames.append(((1-t)*frame_p.astype(float) + t*frame_o.astype(float)).astype(np.uint8))
    imageio.mimsave(out_path, frames, duration=1.0/fps)

def anim_clip(out_path, size_px=320, fps=20):
    V, E = cube_edges(1.0)
    C, F, Up = np.array([3,3,3]), np.array([0,0,0]), np.array([0,0,1])
    frames = []
    # Near 前推
    for near in np.linspace(0.1, 2.5, 36):
        segs   = project_edges(V,E,C,F,Up,mode='persp',vfov=45.0)
        segs2d = apply_clipping(segs, near, 100.0)
        fig, ax = plt.subplots(figsize=(size_px/100, size_px/100), dpi=100)
        draw_frame(ax, segs2d, f"Clip: Near={near:.2f}, Far=∞", lim=2.0)
        frames.append(fig_to_rgb(fig)); plt.close(fig)
    # Far 拉近
    for far in np.linspace(100.0, 2.5, 36):
        segs   = project_edges(V,E,C,F,Up,mode='persp',vfov=45.0)
        segs2d = apply_clipping(segs, 0.1, far)
        fig, ax = plt.subplots(figsize=(size_px/100, size_px/100), dpi=100)
        draw_frame(ax, segs2d, f"Clip: Near=0.10, Far={far:.2f}", lim=2.0)
        frames.append(fig_to_rgb(fig)); plt.close(fig)
    imageio.mimsave(out_path, frames, duration=1.0/fps)

def anim_focal_point(out_path, size_px=320, fps=20):
    V, E = cube_edges(1.0)
    C, Up = np.array([3,3,3]), np.array([0,0,1])
    frames = []
    for t in np.linspace(-1.0, 1.0, 60):
        F = np.array([t, 0.0, 0.0])  # 沿X轴移动对焦点
        segs   = project_edges(V,E,C,F,Up,mode='persp',vfov=45.0)
        segs2d = apply_clipping(segs, 0.1, 100.0)
        fig, ax = plt.subplots(figsize=(size_px/100, size_px/100), dpi=100)
        draw_frame(ax, segs2d, f"FocalPoint=({F[0]:.2f},0,0)", lim=2.0)
        frames.append(fig_to_rgb(fig)); plt.close(fig)
    imageio.mimsave(out_path, frames, duration=1.0/fps)


# ---------------- 入口 ----------------

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--out",  type=str, default=".",   help="输出目录（默认当前目录）")
    ap.add_argument("--size", type=int, default=320,   help="GIF 边长像素，默认320")
    ap.add_argument("--fps",  type=int, default=20,    help="帧率（越大越快），默认20")
    args = ap.parse_args()

    out_dir = Path(args.out)
    out_dir.mkdir(parents=True, exist_ok=True)

    print(f"[+] 输出目录: {out_dir.resolve()}")
    anim_parallel_scale(out_dir / "vtk_parallel_scale.gif",          size_px=args.size, fps=args.fps)
    anim_parallel_projection(out_dir / "vtk_parallel_projection.gif", size_px=args.size, fps=args.fps)
    anim_clip(out_dir / "vtk_clip.gif",                               size_px=args.size, fps=args.fps)
    anim_focal_point(out_dir / "vtk_focal_point.gif",                 size_px=args.size, fps=args.fps)
    print("[✓] 生成完成：")
    print("   - vtk_parallel_scale.gif")
    print("   - vtk_parallel_projection.gif")
    print("   - vtk_clip.gif")
    print("   - vtk_focal_point.gif")


#
# pip install numpy matplotlib imageio
# python gen_vtk_camera_gifs.py --out ./out --size 320 --fps 20
# # --out  输出目录（默认当前目录）
# # --size GIF 边长像素（默认 320）
# # --fps  帧率，越大越快（默认 20）
if __name__ == "__main__":
    main()
