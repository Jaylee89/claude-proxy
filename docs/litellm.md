# litellm

## Visit LiteLLM API

http://127.0.0.1:4000/

## setup models

https://docs.litellm.ai/docs/providers/deepseek

## Test your model in litellm proxy

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