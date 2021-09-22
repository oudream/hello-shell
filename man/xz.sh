
###
# https://tukaani.org/xz/
wget https://tukaani.org/xz/xz-5.2.3.tar.gz
tar xvf xz-5.2.3.tar.gz
cd xz-5.2.3
# ./configure --prefix=/usr/local/xz
./configure
make && make insall

# 压缩
xz test.txt

xz -d -k test.txt.xz


xz [OPTION]... [FILE]...

-z, --compress    # 强制压缩
-d, --decompress, --uncompress
                  # force decompression
-t, --test        # 测试压缩文件的完整性
-l, --list        # 列出有关.xz文件的信息
-k, --keep        # 保留（不要删除）输入文件
-f, --force       # 强制覆盖输出文件和（解）压缩链接
-c, --stdout, --to-stdout
                  # 写入标准输出，不要删除输入文件
-0 ... -9         # 压缩预设; 默认为6; 取压缩机*和*
                  # 使用7-9之前解压缩内存使用量考虑在内！
-e, --extreme     # 尝试通过使用更多的CPU时间来提高压缩比;
                  # 要求不影响解压缩存储器
-T, --threads=NUM # 最多使用NUM个线程; 默认值为1;  set to 0
                  # 设置为0，使用与处理器内核一样多的线程
-q, --quiet       # 抑制警告; 指定两次以抑制错误
-v, --verbose     # 冗长; 指定两次更详细
-h, --help        # 显示这个简洁的帮助并退出
-H, --long-help   # 显示更多帮助（还列出了高级选项）
-V, --version     # 显示版本号并退出