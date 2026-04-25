# litellm

## Visit LiteLLM API

http://127.0.0.1:4000/

## Commands

```
litellm-proxy models list
```

## setup models

https://docs.litellm.ai/docs/providers/deepseek

### Test your model in litellm proxy

```
curl -X POST http://localhost:4000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk-1234" \
  -d '{
    "model": "deepseek-coder",
    "messages": [{"role": "user", "content": "hello"}],
    "max_tokens": 8192 
  }'
```

### Not work for kimi2.5
https://platform.moonshot.ai/docs/guide/kimi-k2-5-quickstart#multimodal-tool-capability-example

```
curl -X POST http://localhost:4000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk-1234" \
  -d '{
    "model": "kimi2.5",
    "messages": [{"role": "user", "content": "hello"}],
    "max_tokens": 8192 
  }'
```