#!/usr/bin/env bash
set -euo pipefail
BASE="${UM_MCP_URL:-https://api.urbanmanual.co/mcp}"
case "$BASE" in
  */mcp/admin*|www.urbanmanual.co/api/mcp*)
    echo "Refusing non-user MCP URL: $BASE" >&2
    exit 1
    ;;
esac
echo "GET $BASE"
code=$(curl -sS -o /tmp/um-smoke-get.json -w '%{http_code}' "$BASE")
test "$code" = "200"
python3 - <<'PY'
import json
d=json.load(open("/tmp/um-smoke-get.json"))
name=(d.get("mcp") or {}).get("name")
assert name, d
print("server:", name, (d.get("mcp") or {}).get("version"))
tools=(d.get("endpoints") or {}).get("tools") or []
admin=[t["name"] for t in tools if str(t.get("name","")).startswith("admin_")]
assert not admin, f"unexpected admin tools on user MCP: {admin}"
print("tools:", len(tools), "(no admin_*)")
PY
echo "POST initialize"
code=$(curl -sS -o /tmp/um-smoke-init.json -w '%{http_code}' \
  -H 'Content-Type: application/json' -H 'Accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"urban-manual-plugin-smoke","version":"0.1.0"}}}' \
  "$BASE")
test "$code" = "200"
python3 - <<'PY'
import json
raw=open("/tmp/um-smoke-init.json").read()
if raw.lstrip().startswith("event:") or "\ndata:" in raw[:80]:
  for line in raw.splitlines():
    if line.startswith("data:"):
      raw=line[5:].strip(); break
d=json.loads(raw)
info=(d.get("result") or {}).get("serverInfo") or {}
print("initialize:", info.get("name"), info.get("version"))
assert info.get("name"), d
PY
echo "OK"
