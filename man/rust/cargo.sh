
# https://doc.rust-lang.org/cargo/commands/index.html

# 初始化子项目：
cargo new apps/app2

# cargo的内置常用命令
cargo new      # 创建工程。
cargo bench    # 基准测试。
cargo build    # 编译工程
cargo check    # 检查当前工程，还有依赖的crate，是否有错误。这个命令还会保存当前工程的元数据(metadata)，以备将来利用。
cargo clean    # 删除生成的target。
cargo doc      # 构建当前工程的文档。
cargo fetch    # 获取依赖的crate。
cargo fix      # 自动修复编译器给出的 lint 警告。
cargo run      # 运行当前工程。
cargo test     # 执行工程的测试用例。
cargo install  # 安装cargo plugin
