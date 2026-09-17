---
name: urban-manual
description: >-
  Use when searching Urban Manual places, planning trips, or reading/updating a
  signed-in user's saved trips via the Urban Manual MCP. User/consumer surface
  only — never call admin endpoints or admin tools.
---

# Urban Manual (user MCP)

This plugin connects to **`https://api.urbanmanual.co/mcp`** only.

## Hard rules

- **Never** call `https://api.urbanmanual.co/mcp/admin` or `https://www.urbanmanual.co/api/mcp` (old route).
- **Never** use tools named `admin_*`, or place-catalog mutations meant for editors (`add_place` / `update_place` / `delete_place` if they ever appear). This plugin is for travelers, not ops.
- Prefer tools returned by this server. Do not invent places that search/fetch did not return.
- For mutating account actions that take `user_confirmed`: call once with `false` (or omit) to preview, show the preview, get explicit approval, then repeat with `user_confirmed=true`. Changed args need a new preview.
- `idempotency_key` is tracing only — it does not dedupe writes. After a timeout, read current state before retrying a write.

## Auth

- Public reads and conversation-scoped planning work without an account.
- Saved trips and account mutations need OAuth (`read:destinations`, `trips:read`, `trips:write`). If a tool returns 401, ask the user to Connect / sign in — never ask for tokens or passwords in chat.

## Typical flows

1. **Find places:** `search` or `search_places` → `fetch` / `destination_detail` for detail.
2. **Plan without saving:** `plan_trip` (conversation-scoped; does not create a trip row).
3. **Weather:** `get_weather` when weather changes the plan.
4. **Signed-in trips:** `whoami` → `trip_list` / `trip_detail` → mutate only after confirmation preview.
5. **Discover account actions:** `manual_core_tools` then `manual_core_execute` for catalogued account ops.

## Out of scope

Admin event research, bulk place edits, Muse/Fern event-admin workflows, and anything on `/mcp/admin`.
