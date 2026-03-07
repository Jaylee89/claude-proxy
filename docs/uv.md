# UV 使用指南

[uv](https://docs.astral.sh/uv/) 是一个快速的 Python 包管理器和解析器，用 Rust 编写。它旨在替代 pip、pip-tools、virtualenv、pipenv、poetry 等工具，提供更快的性能和更好的用户体验。

## 目录
- [安装 uv](#安装-uv)
- [项目初始化](#项目初始化)
- [依赖管理](#依赖管理)
- [虚拟环境管理](#虚拟环境管理)
- [运行项目](#运行项目)
- [开发工作流](#开发工作流)
- [高级功能](#高级功能)
- [常见问题](#常见问题)

## 安装 uv

### macOS / Linux
```bash
# 使用 curl 安装
curl -LsSf https://astral.sh/uv/install.sh | sh

# 或者使用 Homebrew (macOS)
brew install uv
```

### Windows
```bash
# 使用 PowerShell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### 验证安装
```bash
uv --version
# 输出示例: uv 0.8.13
```

## 项目初始化

### 1. 创建新项目
```bash
# 创建一个新的 Python 项目
uv init my-project
cd my-project
```

### 2. 初始化现有项目
如果你已经有一个项目目录：
```bash
# 在现有目录中初始化
uv init
```

这会创建 `pyproject.toml` 文件，这是现代 Python 项目的标准配置文件。

## 依赖管理

### 添加依赖
```bash
# 添加生产依赖
uv add requests
uv add numpy==1.24.0
uv add "pandas>=2.0.0"

# 添加开发依赖
uv add --dev pytest
uv add --dev black
uv add --dev mypy

# 添加多个依赖
uv add fastapi uvicorn sqlalchemy
```

### 查看依赖
```bash
# 查看已安装的包
uv pip list

# 查看依赖树
uv tree

# 查看过时的包
uv pip list --outdated
```

### 更新依赖
```bash
# 更新所有依赖到最新版本
uv pip list --outdated | awk 'NR>2 {print $1}' | xargs -n1 uv add --upgrade

# 更新特定包
uv add --upgrade requests
```

### 移除依赖
```bash
# 移除依赖
uv remove requests

# 移除开发依赖
uv remove --dev pytest
```

### 同步依赖
```bash
# 根据 pyproject.toml 安装所有依赖
uv sync

# 包括开发依赖
uv sync --dev

# 重新创建环境（清除后重新安装）
uv sync --clean
```

## 虚拟环境管理

### 创建虚拟环境
```bash
# 创建虚拟环境（默认在 .venv 目录）
uv venv

# 指定 Python 版本
uv venv --python 3.11

# 指定环境目录
uv venv myenv
```

### 激活虚拟环境
```bash
# macOS / Linux
source .venv/bin/activate

# Windows
.venv\Scripts\activate
```

### 停用虚拟环境
```bash
deactivate
```

### 列出虚拟环境
```bash
# 查看 uv 管理的环境
uv venv list
```

### 删除虚拟环境
```bash
# 删除当前项目的虚拟环境
rm -rf .venv

# 或者使用 uv 命令删除特定环境
uv venv remove myenv
```

## 运行项目

### 1. 安装依赖并运行
```bash
# 确保所有依赖已安装
uv sync

# 激活虚拟环境
source .venv/bin/activate

# 运行 Python 脚本
python main.py

# 运行模块
python -m mymodule
```

### 2. 使用 uv run（无需激活环境）
```bash
# 直接运行，uv 会自动处理环境
uv run python main.py

# 运行命令
uv run pytest
uv run black .
```

### 3. 运行特定 Python 版本
```bash
# 使用特定 Python 版本运行
uv run --python 3.11 python main.py
```

## 开发工作流

### 典型开发流程
```bash
# 1. 克隆项目
git clone <repository>
cd project

# 2. 创建虚拟环境
uv venv

# 3. 安装依赖
uv sync --dev

# 4. 激活环境
source .venv/bin/activate

# 5. 开发代码...

# 6. 运行测试
uv run pytest

# 7. 格式化代码
uv run black .

# 8. 添加新依赖
uv add new-package

# 9. 更新 pyproject.toml 后同步
uv sync
```

### 锁文件管理
```bash
# 生成锁文件（确保可重复安装）
uv lock

# 根据锁文件安装
uv sync --locked
```

## 高级功能

### 1. 项目发布
```bash
# 构建项目
uv build

# 发布到 PyPI
uv publish
```

### 2. 依赖解析
```bash
# 查看依赖冲突
uv pip check

# 解析依赖图
uv pip graph
```

### 3. 缓存管理
```bash
# 查看缓存信息
uv cache dir
uv cache info

# 清理缓存
uv cache clean
```

### 4. 配置管理
uv 的配置可以通过以下方式设置：

1. **环境变量**：`UV_` 前缀的环境变量
2. **配置文件**：`uv.toml` 或 `pyproject.toml` 的 `[tool.uv]` 部分
3. **命令行参数**

示例配置 (`pyproject.toml`):
```toml
[tool.uv]
python = "3.11"
virtualenv = ".venv"

[tool.uv.sources]
# 自定义包源
pypi = { url = "https://pypi.org/simple/" }

[tool.uv.dev-dependencies]
test = ["pytest", "pytest-cov"]
lint = ["black", "ruff", "mypy"]
```

## 常见问题

### Q1: uv 和 pip 有什么区别？
- **速度**: uv 比 pip 快 10-100 倍
- **功能**: uv 整合了 pip、virtualenv、pip-tools 等功能
- **用户体验**: 更简洁的命令和更好的错误信息
- **可靠性**: 更好的依赖解析和冲突处理

### Q2: 如何从 requirements.txt 迁移到 uv？
```bash
# 1. 如果有 requirements.txt
uv pip install -r requirements.txt

# 2. 将依赖添加到 pyproject.toml
uv add $(cat requirements.txt | xargs)

# 3. 删除 requirements.txt
rm requirements.txt
```

### Q3: 如何与团队共享项目？
只需要共享 `pyproject.toml` 文件。团队成员可以：
```bash
# 克隆项目后
uv sync
```

### Q4: 如何生成 requirements.txt（如果需要）？
```bash
# 生成 requirements.txt
uv pip freeze > requirements.txt

# 生成 requirements-dev.txt
uv pip freeze --dev > requirements-dev.txt
```

### Q5: uv 支持哪些 Python 版本？
uv 支持 Python 3.8 及以上版本。

### Q6: 如何解决依赖冲突？
```bash
# 查看冲突
uv pip check

# 尝试重新解析
uv sync --reinstall

# 或者手动指定版本
uv add "package==specific.version"
```

## 命令速查表

| 命令 | 描述 | 等价传统命令 |
|------|------|-------------|
| `uv init` | 初始化项目 | `pip init` + 手动创建文件 |
| `uv add <pkg>` | 添加依赖 | `pip install <pkg>` + 更新 requirements.txt |
| `uv remove <pkg>` | 移除依赖 | `pip uninstall <pkg>` |
| `uv sync` | 同步依赖 | `pip install -r requirements.txt` |
| `uv venv` | 创建虚拟环境 | `python -m venv .venv` |
| `uv run <cmd>` | 在环境中运行命令 | `source .venv/bin/activate && <cmd>` |
| `uv pip list` | 列出已安装包 | `pip list` |
| `uv lock` | 生成锁文件 | `pip-tools compile` |

## 性能对比

| 操作 | pip 时间 | uv 时间 | 加速比 |
|------|----------|---------|--------|
| 创建虚拟环境 | 2-3秒 | 0.1-0.2秒 | 15-30x |
| 安装 requests | 2-3秒 | 0.2-0.3秒 | 10x |
| 安装 numpy+pandas | 30-60秒 | 3-5秒 | 10-12x |
| 依赖解析 | 5-10秒 | 0.1-0.3秒 | 30-50x |

## 最佳实践

1. **始终使用虚拟环境**: 每个项目使用独立的虚拟环境
2. **使用 pyproject.toml**: 替代 requirements.txt，功能更强大
3. **定期更新依赖**: 使用 `uv pip list --outdated` 检查更新
4. **使用锁文件**: 在生产环境中使用 `uv sync --locked` 确保一致性
5. **分离开发依赖**: 使用 `--dev` 标记开发专用包
6. **利用缓存**: uv 有智能缓存，重复安装很快

## 更多资源

- [官方文档](https://docs.astral.sh/uv/)
- [GitHub 仓库](https://github.com/astral-sh/uv)
- [基准测试](https://docs.astral.sh/uv/benchmarks/)
- [迁移指南](https://docs.astral.sh/uv/guides/migration/)

---

*最后更新: 2026年3月7日*