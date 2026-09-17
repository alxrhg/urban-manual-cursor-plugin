# Urban Manual

Cursor plugin for [Urban Manual](https://www.urbanmanual.co) — curated places, trip planning, and saved trips.

## What it does

Connects to Urban Manual’s **user** MCP so agents can:

- Search curated destinations, neighborhoods, hotels, restaurants, and more
- Plan conversation-scoped trips without creating an account
- Manage saved trips and places when you sign in (OAuth)

## MCP

- Endpoint: `https://api.urbanmanual.co/mcp`
- Scope: traveler / consumer only
- Not included: admin MCP (`/mcp/admin`) or catalog-editor tools

## Install

Install from the Cursor Marketplace, or add this repository as a local plugin in Cursor.

For saved trips, connect Urban Manual when prompted. Search and trip planning work without signing in.

## Usage

Ask Cursor things like:

- “Find design hotels in Tokyo”
- “Plan a weekend in Lisbon focused on food and architecture”
- “What’s the weather in Kyoto next weekend?”

## Smoke test

```bash
./scripts/smoke.sh
```

## License

MIT
