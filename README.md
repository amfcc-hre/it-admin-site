# AMFCC IT Administration

Central system-control site for the AMFCC IT Administrator. This is the highest-permission interface in the AMFCC platform.

**Repository:** [amfcc-hre/it-admin-site](https://github.com/amfcc-hre/it-admin-site)  
**Live site:** [AMFCC IT Administration](https://amfcc-hre.github.io/it-admin-site/)

## Purpose

Use this site to manage settings that affect the complete AMFCC system. It provides every control available to School Administration, plus IT-only access management.

This repository does not contain Department Operations, Student Services or Library circulation records. Those sites use the settings and permissions managed here.

## Who can use it

| User | Access |
| --- | --- |
| IT Administrator | Full access to modes, settings, pass-email recipients, role PINs, department PINs, Library setup and audit history |
| School Administrator | Uses the separate School Administration workspace in Department Operations |
| Department staff | Uses Department Operations with the department's shared PIN |
| Library Staff | Uses the Library site with the Library Staff PIN |

The first IT Administrator PIN is initially based on the existing School Administrator PIN. Change it immediately so IT Administration has its own PIN.

Names entered in the audit field identify who made a change. They are not individual login accounts.

## Main capabilities

- View overall access readiness and the current operating mode.
- Choose School Term Mode or Holiday Mode.
- Turn Conference Mode on or off as an additional overlay.
- Change every system-role PIN.
- Change every department PIN.
- Enable Library Staff access by setting its first PIN.
- Change paper-pass pilot settings, pilot dates, kiosk result duration and the school time zone.
- Configure School Administration and Student Leadership recipients for gate-pass email.
- Turn automatic pass email on or off after the mail service is ready.
- Review the audit history for settings and PIN changes.
- Open the Library system from the setup section.

PIN values are never displayed in the interface or written to the audit history.

## Gate-pass email

Gate-pass messages use `it@amfcc.ac.zw` as the fixed sender. The system can notify:

- every School Administration address entered in IT Administration;
- every Student Leadership address entered in IT Administration; and
- the email address entered by the student on the pass request.

Messages are prepared for submissions and for Approved, Rejected, Cancelled, Departure recorded, Return recorded and Expired status changes.

Automatic email starts disabled. Before switching it on:

1. Verify `amfcc.ac.zw` in Resend and wait until its status is **Verified**.
2. Add the Resend key to Supabase Edge Function secrets with the exact name `RESEND_API_KEY`.
3. Enter at least one real School Administration and one real Student Leadership recipient.
4. Use **Check setup** and confirm the mail key and automatic worker are ready.
5. Enable automatic email and test one controlled pass submission and status change.

The protected mail worker checks the private outbox every minute when email is enabled, so delivery does not depend on a student's browser remaining open. See `PASS_EMAIL_SETUP.md` in the complete system package for the full DNS, secret, recipient and test procedure.

Recipient lists and student notification addresses are stored in private database tables. The browser cannot select recipients for an individual message. The mail API key must never be added to this repository.

## Operating modes

The system always has one base calendar mode. Conference Mode is optional and can be added to either base mode.

| Setting | Effect |
| --- | --- |
| School Term Mode | Uses standard meal deadlines, gate-pass rules and the regular manual-work timetable |
| Holiday Mode | Uses Morning and Afternoon manual-work slots and the holiday gate-pass rules |
| Conference Mode off | The selected base mode operates normally |
| Conference Mode on | Meal check-ins have no deadline, manual-work sessions are unavailable and active tasks are treated as Emergency tasks |

Conference Mode does not replace School Term or Holiday Mode. It adds conference rules to the selected base mode.

## Security model

- The browser contains a Supabase publishable key only. A publishable key is intended for browser applications.
- Never add a Supabase secret key or legacy `service_role` key to this repository.
- Four-digit PINs are verified in the database and stored as hashes, not plaintext.
- A successful login creates a temporary database-backed session token.
- The browser stores the current session only in `sessionStorage`, so it is cleared when the browser session ends.
- Repeated incorrect PIN attempts can temporarily lock an access role.
- Settings and PIN changes require the operator's name for the audit record.
- Pass-email recipient changes also require the operator's name and record recipient counts, not the addresses, in the audit history.

## Repository files

| File | Purpose |
| --- | --- |
| `index.html` | IT Administration interface |
| `it-admin.js` | Login, modes, settings, PIN management and audit behaviour |
| `it-admin.css` | Main site styling |
| `it-admin-fixes.css` | Login and navigation corrections |
| `shared_config.js` | Supabase project URL and publishable key |
| `shared_supabase.js` | Shared Supabase browser-client setup |
| `PASS_EMAIL_SETUP.md` | Complete sender-domain, secret, recipient and test procedure |
| `README.md` | Repository and operating instructions |

## Deployment with GitHub Pages

1. Open the existing public repository `it-admin-site` under the `amfcc-hre` account.
2. Upload every file from this folder to the repository root.
3. Keep the filenames and folder structure unchanged.
4. Open **Settings > Pages** in GitHub.
5. Select **Deploy from a branch**.
6. Select the `main` branch and the `/ (root)` folder.
7. Wait for GitHub Pages to publish the site.
8. Open the live-site link above and complete the first-use checklist.

Do not run the database migration files when updating only this repository. The shared Supabase database has already been configured.

## First-use checklist

1. Open the site with the initial IT Administrator PIN.
2. Enter the name of the person making the change.
3. Change the IT Administrator PIN immediately.
4. Set the first Library Staff PIN.
5. Confirm that every required system role shows **PIN ready**.
6. Confirm that each operational department has the intended shared PIN.
7. Confirm the School Term or Holiday base mode.
8. Confirm Conference Mode separately.
9. Review the school time zone. It should normally remain `Africa/Harare`.
10. Open **Pass email**, enter the approved recipient addresses and leave automatic email off until the domain and API key are ready.
11. Sign out, sign back in with the new IT Administrator PIN and confirm access.

## Updating the site

Upload the complete repository folder when replacing a version. Partial uploads can leave old JavaScript or styling in place.

After an update:

1. Open the site in a private browser window.
2. Confirm that the login screen disappears after successful sign-in.
3. Open each section and confirm the page does not jump back to the top.
4. Change a non-critical setting only if a live write test is required, then return it to the correct value.
5. Check that the change appears in the audit history.

## Related repositories

- [AMFCC Department Operations](https://github.com/amfcc-hre/department-operations): HOD, department, Student Leadership, Management and School Administration workspaces.
- [AMFCC Student Services](https://github.com/amfcc-hre/amfcc_student_services): student meal check-in and personal gate passes.
- [AMFCC Library](https://github.com/amfcc-hre/library-site): ISBN lookup, catalogue, circulation and loan reporting.
