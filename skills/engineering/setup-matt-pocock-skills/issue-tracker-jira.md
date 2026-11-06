# Issue tracker: Jira

Issues and PRDs for this repo live in a Jira project. Use the Atlassian Rovo MCP tools (the Jira-related tools available in your session) for all operations.

- **Project key**: `<PROJECT_KEY>`
- **PRD issue type**: `<EPIC_TYPE>`
- **Slice issue type**: `<STORY_TYPE>`

The values above were filled in during `/setup-matt-pocock-skills`. To change them, edit this file directly.

## Conventions

- **Create a Story** (vertical slice from `/to-issues`): create a `<STORY_TYPE>` in project `<PROJECT_KEY>`. If the work belongs under a parent Epic (e.g. a PRD), set the Epic Link field so the slice rolls up under that `<EPIC_TYPE>`. Pass the slice body as the description.
- **Create an Epic** (PRD from `/to-prd`): create an `<EPIC_TYPE>` in project `<PROJECT_KEY>`. Use the PRD title as the summary; pass the PRD body as the description. The returned issue key (e.g. `<PROJECT_KEY>-123`) is what subsequent `/to-issues` slices link to via the Epic Link field.
- **Fetch an issue**: call the Rovo MCP Jira-fetch tool with the issue key. Always pass the full key including the project prefix (`<PROJECT_KEY>-###`).
- **List issues**: run a JQL search via the Rovo MCP. Filter by label (`labels = "ready-for-agent"`), by status, by assignee, or by parent Epic (`"Epic Link" = <PROJECT_KEY>-123`).
- **Comment on an issue**: use the Rovo MCP comment tool with the issue key and the comment body.
- **Apply / remove labels**: edit the issue's `labels` field via the Rovo MCP edit tool — pass the desired final list of labels, since edits typically replace rather than merge. The five canonical triage roles (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`) are stored here. See `docs/agents/triage-labels.md` for the canonical mapping.
- **Close / wontfix**: transition the issue to Done (or whatever your workflow calls the closed state) via the Rovo MCP transition tool. Ask Jira for the available transitions for the issue first (workflows differ between projects) and pick the one whose name matches "Done" (or "Won't Do" / similar for wontfix). If no obvious match exists, ask the user which transition to apply.

The workflow Status field is otherwise left untouched — labels carry triage state, so this convention works on any Jira workflow regardless of the configured statuses or resolutions.

## When a skill says "publish to the issue tracker"

Create a Jira issue in project `<PROJECT_KEY>`. For a vertical slice from `/to-issues`, use issue type `<STORY_TYPE>` and set the Epic Link to the parent PRD's Epic if one exists. For a PRD from `/to-prd`, use issue type `<EPIC_TYPE>`.

## When a skill says "fetch the relevant ticket"

Call the Rovo MCP Jira-fetch tool with the issue key (e.g. `<PROJECT_KEY>-123`). The full ticket — description, fields, and comments — comes back.
