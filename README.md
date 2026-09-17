# Urban Manual — Cursor Agent Plugin

Wraps the **user** Urban Manual MCP for Cursor.

- MCP: `https://api.urbanmanual.co/mcp`
- Not included: `https://api.urbanmanual.co/mcp/admin`
- Deprecated (do not use): `https://www.urbanmanual.co/api/mcp`

## Install (Cursor IDE)

1. Copy this folder somewhere durable, or clone the repo.
2. In Cursor: add it as a local plugin / open the folder and enable the plugin from the Plugin UI (Grok Bot cannot load `~/.cursor/plugins/local` — prove there if needed, use Cursor IDE for the real install).
3. Connect Urban Manual when prompted (OAuth) for saved trips. Search and `plan_trip` work without sign-in.

## Smoke

```bash
./scripts/smoke.sh
```

Expects HTTP 200 from discovery and a successful JSON-RPC `initialize` against `api.urbanmanual.co/mcp` only.

## Scope

User/consumer tools only (search, plan, saved trips, calendar, notebook). No admin catalog or event-admin tools.
