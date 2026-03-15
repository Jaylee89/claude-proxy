# Open Claw

## Setup in docker

1. Clone repo
```
git clone https://github.com/openclaw/openclaw.git
git checkout v2026.3.12
cd openclaw
```
2. Update `docker-compose.yml`

```
services:
  openclaw-cli:
    environment:
      ...
      OPENCLAW_GATEWAY_URL: ws://openclaw-gateway:18789
```

3. Build openclaw image
```
./docker-setup.sh
```

Note: 
1. If get error, then have to check your env issue
1. The `v2026.3.13` lost some codes, it did not work. If get complier issue, please checkout another version (such as: `v2026.3.12`).

4. You will get the `openclaw -> openclaw-openclaw-gateway-1`, then entry into it
5. Run `openclaw onboard` to setup it once

## Docs

- https://zhuanlan.zhihu.com/p/2011779626700149313
  - http://127.0.0.1:18789/chat?session=agent%3Amain%3Amain
  - http://127.0.0.1:18789/healthz


## Commands

在主机上启动网关
openclaw gateway run

获取带令牌的仪表盘 URL
openclaw dashboard --no-open