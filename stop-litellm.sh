#!/bin/bash

# 停止 litellm 代理服务脚本

PID_FILE=".litellm_pid"

if [ -f "$PID_FILE" ]; then
    LITELLM_PID=$(cat "$PID_FILE")
    
    if ps -p $LITELLM_PID > /dev/null; then
        echo "🛑 正在停止 litellm 代理服务 (PID: $LITELLM_PID)..."
        kill $LITELLM_PID
        
        # 等待进程停止
        sleep 2
        
        if ps -p $LITELLM_PID > /dev/null; then
            echo "⚠️  进程仍在运行，强制终止..."
            kill -9 $LITELLM_PID
            sleep 1
        fi
        
        echo "✅ litellm 代理服务已停止"
        rm -f "$PID_FILE"
    else
        echo "ℹ️  进程 $LITELLM_PID 未在运行"
        rm -f "$PID_FILE"
    fi
else
    echo "ℹ️  未找到 .litellm_pid 文件，尝试查找 litellm 进程..."
    
    # 尝试查找 litellm 进程
    LITELLM_PIDS=$(ps aux | grep "litellm --config" | grep -v grep | awk '{print $2}')
    
    if [ -z "$LITELLM_PIDS" ]; then
        echo "✅ 没有找到运行的 litellm 进程"
    else
        echo "🛑 找到 litellm 进程: $LITELLM_PIDS"
        for pid in $LITELLM_PIDS; do
            echo "正在停止进程 $pid..."
            kill $pid
        done
        sleep 2
        echo "✅ litellm 代理服务已停止"
    fi
fi