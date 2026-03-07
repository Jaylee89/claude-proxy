# 微信公众号发布Skill安装指南

## 安装状态

✅ **Skill已成功安装**：`baoyu-post-to-wechat` skill 已安装到 `.agents/skills/baoyu-post-to-wechat/`

## 安装步骤回顾

1. **安装baoyu-skills包**：
   ```bash
   npx skills add jimliu/baoyu-skills --yes
   ```

2. **安装Bun运行时**：
   ```bash
   # 自动安装Bun
   curl -fsSL https://bun.sh/install | bash

   # 添加到PATH（如果未自动添加）
   export PATH="$HOME/.bun/bin:$PATH"

   # 验证安装
   bun --version

   # 或者使用npx自动管理（备用方案）
   npx -y bun --version
   ```

3. **创建配置文件**：
   ```bash
   mkdir -p .baoyu-skills/baoyu-post-to-wechat
   ```

4. **配置EXTEND.md**：
   ```markdown
   default_theme: default
   default_color: blue
   default_publish_method: browser
   default_author: 测试作者
   need_open_comment: 1
   only_fans_can_comment: 0
   ```

## 环境检查

运行环境检查脚本确认所有依赖已就绪：

```bash
cd .agents/skills/baoyu-post-to-wechat

# 如果Bun已在PATH中
bun scripts/check-permissions.ts

# 或者使用npx（备用方案）
npx -y bun scripts/check-permissions.ts
```

预期输出：
```
✅ Chrome: /Applications/Google Chrome.app/Contents/MacOS/Google Chrome
✅ Profile isolation: Skill profile: /Users/jayleeli/Library/Application Support/baoyu-skills/chrome-profile
✅ Bun runtime: v1.3.10
✅ Accessibility (System Events): Frontmost app: Electron
✅ Clipboard copy (image): Can copy image to clipboard via Swift/AppKit
✅ Paste keystroke (osascript): System Events can send keystrokes
⚠️  API credentials: Not found. Required for API publishing method.
```

## 使用方法

### 1. 文章发布（文章模式）

#### 浏览器方法（无需API凭证）：
```bash
# 发布Markdown文章
/baoyu-post-to-wechat 文章 --markdown test-wechat-article.md

# 指定主题
/baoyu-post-to-wechat 文章 --markdown article.md --theme grace

# 禁用底部引用
/baoyu-post-to-wechat 文章 --markdown article.md --no-cite
```

#### API方法（需要API凭证）：
```bash
# 需要先配置API凭证
/baoyu-post-to-wechat 文章 --markdown article.md --method api
```

### 2. 图文发布（贴图模式）

```bash
# 发布图文内容
/baoyu-post-to-wechat 贴图 --title "标题" --content "内容" --image img1.png

# 使用Markdown文件
/baoyu-post-to-wechat 贴图 --markdown article.md --images ./photos/
```

## 配置API凭证（可选）

如果需要使用API方法，需要配置微信公众号API凭证：

1. 访问 https://mp.weixin.qq.com
2. 进入：开发 → 基本配置
3. 复制AppID和AppSecret

创建 `.baoyu-skills/.env` 文件：
```bash
WECHAT_APP_ID=your_app_id
WECHAT_APP_SECRET=your_app_secret
```

## 测试文件

已创建测试文件 `test-wechat-article.md`，包含：
- 完整的Frontmatter（标题、作者、摘要）
- Markdown格式测试
- 代码块示例
- 引用和链接

## 故障排除

### 常见问题

1. **Chrome未安装**：
   ```bash
   # 安装Chrome或设置环境变量
   export WECHAT_BROWSER_CHROME_PATH=/path/to/chrome
   ```

2. **权限问题**（macOS）：
   - 系统设置 → 隐私与安全性 → 辅助功能 → 启用终端应用

3. **Bun运行时问题**：
   ```bash
   # 使用npx自动管理
   npx -y bun scripts/check-permissions.ts
   ```

4. **首次运行需要登录**：
   - 首次使用浏览器方法会打开Chrome
   - 需要扫码登录微信公众号后台
   - 登录状态会保存

### 日志查看

```bash
# 查看skill执行日志
tail -f .agents/skills/baoyu-post-to-wechat/logs/*.log
```

## 文件结构

```
.agents/skills/baoyu-post-to-wechat/
├── SKILL.md                    # 技能主文档
├── references/                 # 参考文档
│   ├── article-posting.md     # 文章发布指南
│   ├── image-text-posting.md  # 图文发布指南
│   └── config/                # 配置指南
├── scripts/                   # 执行脚本
│   ├── wechat-api.ts         # API发布脚本
│   ├── wechat-article.ts     # 浏览器文章发布
│   ├── wechat-browser.ts     # 图文发布
│   ├── md-to-wechat.ts       # Markdown转换
│   └── check-permissions.ts  # 环境检查
└── ...

.baoyu-skills/
├── baoyu-post-to-wechat/
│   └── EXTEND.md             # 用户配置
└── .env                      # API凭证（可选）
```

## 下一步

1. **测试发布**：运行 `/baoyu-post-to-wechat 文章 --markdown test-wechat-article.md`
2. **配置个性化**：修改EXTEND.md中的默认设置
3. **学习高级功能**：阅读 `references/` 目录中的文档
4. **集成到工作流**：将skill集成到内容发布流程中

## 注意事项

1. **安全警告**：skill有高风险评级，使用时需谨慎
2. **首次登录**：浏览器方法首次使用需要手动登录
3. **图片处理**：远程图片会自动下载，本地图片需要正确路径
4. **发布限制**：遵守微信公众号发布规则和频率限制