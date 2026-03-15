#!/bin/bash

# 激活虚拟环境
if [ -d ".venv" ]; then
    source .venv/bin/activate
    echo "✅ 虚拟环境已激活"
else
    echo "❌ 未找到虚拟环境 .venv 目录"
    exit 1
fi

# 检查 litellm 是否已安装
if ! command -v litellm &> /dev/null; then
    echo "❌ litellm 未安装，请先安装: pip install litellm"
    exit 1
fi

# 检查配置文件是否存在
if [ ! -f "litellm_config.yaml" ]; then
    echo "❌ 未找到 litellm_config.yaml 配置文件"
    exit 1
fi

# 检查端口 4000 是否被占用
echo "🔍 检查端口 4000 是否可用..."
if lsof -ti:4000 > /dev/null 2>&1; then
    echo "❌ 错误：端口 4000 已被占用！"
    echo "📋 占用端口的进程信息："
    lsof -i:4000
    echo ""
    echo "💡 解决方案："
    echo "   1. 停止占用端口的进程"
    echo "   2. 使用其他端口运行 litellm"
    echo "   3. 或者运行 ./stop-litellm.sh 停止现有的 litellm 服务"
    exit 1
else
    echo "✅ 端口 4000 可用"
fi

echo "🚀 启动 litellm 代理服务 (端口: 4000)..."

# 创建日志文件
LOG_FILE="litellm.log"
rm -f "$LOG_FILE"
echo "📝 日志将输出到: $LOG_FILE"
echo "=== litellm 代理服务启动于 $(date) ===" >> "$LOG_FILE"

# 在后台运行 litellm 代理服务，并将输出重定向到日志文件
litellm --config litellm_config.yaml --debug --port 4000 >> "$LOG_FILE" 2>&1 &

# 获取进程ID
LITELLM_PID=$!

# 等待几秒确保服务启动
sleep 7

# 检查服务是否正在运行
if ps -p $LITELLM_PID > /dev/null; then
    echo "✅ litellm 代理服务已启动 (PID: $LITELLM_PID)"
    echo "📡 服务运行在: http://localhost:4000"
    echo "📝 停止服务命令: kill $LITELLM_PID"
    echo "📄 查看日志命令: tail -f $LOG_FILE"
    
    # 将进程ID保存到文件，方便后续管理
    echo $LITELLM_PID > .litellm_pid
    echo "📄 进程ID已保存到 .litellm_pid 文件"
    
    # 显示最后几行日志
    echo ""
    echo "📋 最近日志输出:"
    tail -10 "$LOG_FILE"
else
    echo "❌ litellm 服务启动失败"
    echo "📄 查看错误日志: cat $LOG_FILE"
    exit 1
fi
