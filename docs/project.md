# Project Analysis: Claude Proxy

## Overview

This is a **Claude Code CLI proxy setup** that uses **LiteLLM** to provide a unified API interface for multiple AI models. The project acts as a gateway/proxy server that routes Claude Code requests through a unified API endpoint.

## Key Components

### 1. **LiteLLM Proxy Server**
- Runs on port 4000
- Acts as a unified API gateway for multiple AI models
- Provides OpenAI-compatible API endpoints
- Configuration via `litellm_config.yaml`

### 2. **Supported AI Models**
- **Claude Sonnet 4.5** (via OpenRouter)
- **GPT-4o** (via OpenAI)
- **Qwen3 Coder** (via OpenRouter)
- **DeepSeek Coder** (via DeepSeek API)

### 3. **Claude Code Integration**
- Environment variables configured to route Claude Code through the proxy:
  - `ANTHROPIC_BASE_URL="http://localhost:4000"`
  - `ANTHROPIC_AUTH_TOKEN="sk-1234"`
  - `ANTHROPIC_MODEL="deepseek-coder"`
- Custom alias: `claude-dp` for DeepSeek Coder model

### 4. **Technical Stack**
- **Python 3.11+** with UV package manager
- **FastAPI** web framework
- **LiteLLM** library for unified LLM API
- **Shell scripts** for service management:
  - `litellm-proxy.sh` - Start the proxy server
  - `stop-litellm.sh` - Stop the proxy server

## Project Structure

```
.
├── pyproject.toml           # Python project configuration
├── litellm_config.yaml      # Model configuration
├── litellm-proxy.sh         # Startup script
├── stop-litellm.sh          # Shutdown script
├── README.md                # Project documentation
├── litellm.md               # LiteLLM-specific notes
├── Issues.md                # Troubleshooting guide
├── UV_USAGE_GUIDE.md        # UV package manager guide
├── .gitignore              # Git ignore rules
├── .python-version         # Python version specification
└── docs/                   # Documentation directory
```

## Functionality

### Primary Purpose
- Provide a single API endpoint (`http://localhost:4000`) for multiple AI models
- Allow Claude Code to use different LLM backends through a unified interface
- Enable easy switching between different AI models

### Key Features
1. **Multi-model support** - Single API for Claude, GPT-4o, Qwen, DeepSeek
2. **Environment-based configuration** - Easy model switching via env vars
3. **Automated service management** - Scripts for starting/stopping the proxy
4. **Logging** - Detailed logs in `litellm.log`
5. **Process management** - PID tracking in `.litellm_pid`

## Usage Flow

1. **Start proxy**: `./litellm-proxy.sh`
2. **Configure Claude Code**: Set environment variables
3. **Use Claude Code**: `claude` or `claude-dp` (for DeepSeek Coder)
4. **Requests flow**: Claude Code → Proxy (port 4000) → Selected AI model API

## Dependencies

Core Python dependencies (from `pyproject.toml`):
- `apscheduler` >= 3.11.2
- `backoff` >= 2.2.1
- `boto3` >= 1.42.63
- `cryptography` >= 46.0.5
- `fastapi` >= 0.135.1
- `litellm` >= 1.82.0
- `orjson` >= 3.11.7
- `pydantic[email]`
- `python-dotenv` >= 1.2.2
- `python-multipart` >= 0.0.22
- `websockets` >= 16.0

## Project Name Justification

**Recommended Name: `claude-proxy`**

**Why this name fits:**
- **Descriptive**: Clearly indicates it's a proxy for Claude
- **Accurate**: The main functionality is proxying Claude Code requests
- **Concise**: Short and easy to remember
- **Technical**: Matches the actual implementation (proxy server)
- **Extensible**: Could expand to support other CLI tools beyond Claude

**Alternative names considered:**
- `ai-gateway` - More generic but less specific to Claude
- `litellm-claude-bridge` - Technical but verbose
- `multi-model-proxy` - Descriptive but generic
- `model-gateway` - Focuses on the gateway aspect

## Future Considerations

1. **Additional model support** - Could add more AI models
2. **Authentication** - Currently uses simple token "sk-1234"
3. **Configuration UI** - Web interface for model configuration
4. **Monitoring** - Dashboard for usage statistics
5. **Load balancing** - Multiple instances for high availability