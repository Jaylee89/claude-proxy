# Claude

## Claude installation

```
curl -fsSL https://claude.ai/install.sh | bash -s latest
```

## 3rd part API

https://www.morphllm.com/use-different-llm-claude-code


### init dependencies

```
uv sync
```

### Claude code

```
export CLAUDE_CODE_MAX_TOKENS=8192
export ANTHROPIC_BASE_URL="http://localhost:4000"
export ANTHROPIC_AUTH_TOKEN="sk-1234"
export ANTHROPIC_MODEL="deepseek-coder"
alias claude-dp='ANTHROPIC_MODEL=deepseek-coder claude'
```