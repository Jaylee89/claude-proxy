# https://platform.claude.com/docs/zh-CN/agents-and-tools/agent-skills/best-practices
# 如下是事例参考


---
name: pdf-processing
description: 从 PDF 文件中提取文本和表格、填充表单、合并文档。在处理 PDF 文件或用户提及 PDF、表单或文档提取时使用。
---

# PDF 处理

## 快速开始

使用 pdfplumber 提取文本：
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```

## 高级功能

**表单填充**：参阅 [FORMS.md](FORMS.md) 获取完整指南
**API 参考**：参阅 [REFERENCE.md](REFERENCE.md) 获取所有方法
**示例**：参阅 [EXAMPLES.md](EXAMPLES.md) 获取常见模式
