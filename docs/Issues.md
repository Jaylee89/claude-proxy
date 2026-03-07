
Q1:
  ⎿  API Error: 400 {"error":{"message":"litellm.BadRequestError: DeepseekException - {\"error\":{\"message\":\"Invalid max_tokens 
     value, the valid range of max_tokens is [1,                                                                                     
     8192]\",\"type\":\"invalid_request_error\",\"param\":null,\"code\":\"invalid_request_error\"}}. Received Model                  
     Group=deepseek-coder\nAvailable Model Group Fallbacks=None","type":null,"param":null,"code":"400"}}

A1:
set 8192 in `.claude/settings.json`
```
"CLAUDE_CODE_MAX_OUTPUT_TOKENS": "8192"
```