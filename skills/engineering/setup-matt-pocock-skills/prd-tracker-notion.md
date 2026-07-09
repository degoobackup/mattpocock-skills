# PRD tracker: Notion

PRDs live as pages in a Notion **Tasks** database. Use the Notion MCP tools for all operations. (Issues route to your separate issue tracker — see `issue-tracker-*.md`.)

- **Tasks data source ID**: `<DATA_SOURCE_ID>`

The data source ID above was filled in during `/setup-matt-pocock-skills`. To change it, edit this file directly.

## Conventions

- **Create a PRD**: `notion-create-page` with `parent: { data_source_id: "<DATA_SOURCE_ID>" }`. Set `Task name` (title) and any of `Status`, `Priority`, `Effort level`, `Type`, `Deadline`, `Responsible`, `Project`, `Sprint`, `Parent`. Pass the body as `children` blocks (paragraphs, headings, bulleted lists, code, etc.).
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

Create a Notion page in the Tasks data source (see ID at the top of this file).

## When a skill says "fetch the relevant PRD"

Run `notion-fetch` with the page URL or UUID. If you only have an `IB-####` ID, query the Tasks data source filtered on the `ID` property to resolve it first.
