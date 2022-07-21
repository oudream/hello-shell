import PIL.Image as Image
import os


def change_png_color(path):
    if not path.endswith('png'):
        return

    img = Image.open(path)
    img = img.convert('RGBA')
    L, H = img.size

    for i in range(L):
        for k in range(H):
            r = (img.getpixel((i, k)))[0]
            g = (img.getpixel((i, k)))[1]
            if r < 150 or g < 150:
                alpha = (img.getpixel((i, k)))[3]
                if alpha > 0:
                    img.putpixel((i, k), (51, 204, 51, alpha))
            else:
                alpha = (img.getpixel((i, k)))[3]
                if alpha > 0:
                    img.putpixel((i, k), (255, 255, 255, alpha))
    img.save(path)
    # img.show()


baseDir = '/opt/odan/hello-shell/tools/photo/build'
for root, dirs, files in os.walk(baseDir):
    for f in files:
        change_png_color(os.path.join(root, f))


