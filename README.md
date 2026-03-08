# Claude Proxy

## Claude installation

```
curl -fsSL https://claude.ai/install.sh | bash -s latest
```

## 3rd part API Config Guide

https://www.morphllm.com/use-different-llm-claude-code


### litellm docs

https://docs.litellm.ai/

### Install litellm

```
# Install LiteLLM
pip3 install litellm
```

### Claude Code startup with deepseek-coder

Config in `.claude/settings.json`


**Use `claude-ds` to startup claude code with deepseek-coder model**

```
alias claude-ds='ANTHROPIC_MODEL=deepseek-coder claude'
```