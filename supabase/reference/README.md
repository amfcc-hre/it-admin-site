# Audited application reference

This directory records the inspected source for maintenance review. It is not a standalone restore package.

- `application-functions.sql`: 254 live application functions across `public`, `private`, `it_admin_private` and `it_documents_private`, captured on 3 October 2026. This captures function bodies, not tables, grants, trigger bindings, scheduled jobs, secrets or migration ordering.
- `admin-record-catalog.json`: the reviewed 52 area catalogue. The deployed catalogue had 51 areas at audit time. The extra enrolment corrections area requires the approved review SQL before interface release.
- `jira-outbox-worker.ts`: source snapshot of the live version 2 Jira outbox worker. Deploying this file requires its runtime configuration and approved secrets.
- `amfcc-ops-recovery.ts`: source snapshot of the live version 1 recovery proxy. It serves public Operations files from a pinned repository commit. It does not restore databases or replace normal authentication. Its runtime changes are deliberately separate from the main website source.

The proposed enrolment function replacements are in `../review/it_enrolment_corrections.sql`. The reference dump represents the pre-release live definitions. To restore the platform, use an approved complete database backup, storage backup, repository revisions and the separately secured runtime settings.
