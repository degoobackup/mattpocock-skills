# PRD tracker: Notion

PRDs live as pages in the Notion **Tasks** database. Use the Notion MCP tools for all operations. (Issues route to GitHub — see `issue-tracker-github.md`.)

- **Tasks data source ID**: `2082aea9-118b-81b5-9256-000b593d6803`

## Conventions

- **Create a PRD**: `notion-create-page` with `parent: { data_source_id: "2082aea9-118b-81b5-9256-000b593d6803" }`. Set `Task name` (title) and any of `Status`, `Priority`, `Effort level`, `Type`, `Deadline`, `Responsible`, `Project`, `Sprint`, `Parent`. Pass the body as `children` blocks (paragraphs, headings, bulleted lists, code, etc.).
- **Read a PRD**: `notion-fetch` with the page URL or UUID — returns properties and full block content. Use `notion-get-page-blocks` if you only need the body or need to paginate through long content.
- **List PRDs**: `notion-query-database` against the Tasks data source ID with appropriate `filter` (e.g. by `Status`, `Priority`, `Project`, `Sprint`, `Responsible`) and `sorts`. Page size maxes at 100; paginate via `start_cursor`.
- **Comment on a PRD**: `notion-create-comment` with the page ID as the parent.
- **Update a PRD** (status, priority, deadline, assignee, etc.): `notion-update-page` with the property changes.
- **Close a PRD**: `notion-update-page` setting `Status` to `Done` (or `Cancelled` if abandoning). Add a comment via `notion-create-comment` if context is useful.

Task IDs in Notion auto-increment with the `IB` prefix (e.g. `IB-1234`).

## Schema reference (Tasks data source)

- **Task name** — title
- **Status** — status: `Not started`, `Suspended`, `In progress`, `In review`, `Release ready`, `Done`, `Cancelled`
- **Priority** — select: `Low`, `Medium`, `High`
- **Effort level** — select: `Small`, `Medium`, `Large`
- **Type** — multi-select: `Conversion`, `Brand`, `Retention`, `Engagement`, `Revenue`, `PR`, `Support`
- **Deadline** — date
- **Responsible** — people
- **Project** — relation → Projects
- **Sprint** — relation → Sprints
- **Parent** / **Sub tasks** — relation → Tasks (self-referential)
- **PR** — relation → GitHub PRs
- **A/B test** — relation → A/B tests
- **Figma** — relation → Figma Files
- **Files** — files

## When a skill says "publish a PRD"

Create a Notion page in the Tasks data source (`2082aea9-118b-81b5-9256-000b593d6803`).

## When a skill says "fetch the relevant PRD"

Run `notion-fetch` with the page URL or UUID. If you only have an `IB-####` ID, query the Tasks data source filtered on the `ID` property to resolve it first.
