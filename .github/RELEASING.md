# Releasing

Two workflows, both run from the Actions tab:

| Workflow | GitHub release | Play Console | App Store Connect |
| --- | --- | --- | --- |
| `release_beta` | prerelease, published immediately | `internal` track, live | TestFlight |
| `release_stable` | draft, you publish it | `production` track as a **draft**, you press Publish | TestFlight, you submit for review |

Nothing reaches an end user without a manual step on the stable path.

## Versions and tags

Stable releases are tagged `vX.Y.Z`. Betas are tagged `vX.Y.Z-beta.N`, where the
version name holds still and only the counter climbs, so betas iterate on the
release they are heading towards instead of eating version numbers:

```
v2.5.0            stable
v2.5.1            stable
v2.6.0-beta.1
v2.6.0-beta.2
v2.6.0-beta.3
v2.6.0            stable, promoting the series above
```

The build number (`+N` in `pubspec.yaml`) always increments, because Play and
App Store Connect both reject a build that reuses one, but it stays out of the
tag. A beta keeps the plain version name in `pubspec.yaml` — the stores see
`2.6.0` with a climbing build number, and the `-beta.N` marker lives on the tag
and the GitHub release.

`N` is derived from the tags already on the repo, so the counter is right no
matter who dispatched the previous beta.

## What a run does

```
prepare_release  bump pubspec.yaml, work out the tag, generate changelog +
                 downloads table, commit "chore: version X.Y.Z+N", push the tag
     |
build_mobile     Android: split APKs + AAB  -> optional Play upload
                 iOS:     signed IPA        -> optional TestFlight upload
     |
create_release   GitHub release from the notes, with the APKs attached
```

The release is cut from whichever branch you dispatch the workflow on — the
version commit and tag are pushed back to that same branch.

## Inputs

- **bump_type** — what happens to the version *name*; the build number
  increments regardless.

  | | `none` | `minor` / `major` / `patch` |
  | --- | --- | --- |
  | `release_beta` | another beta for the current version (`-beta.2`, `-beta.3`, …) | start a beta series for the next version (`-beta.1`) |
  | `release_stable` | promote the version the betas were built against | release straight from stable, no betas |

  Both default to `none`, which is the common case: betas iterate, then stable
  promotes. If that would land on a tag that already exists the run fails up
  front, before anything is built.
- **build_ios** — turn off to skip the macOS runner entirely.
- **publish_play** — upload the AAB. Independent of the iOS flag.
- **publish_appstore** — upload the IPA to TestFlight. Independent of the Play flag.

With both publish flags off you still get a full GitHub release with signed
APKs, which is the useful default until the store credentials below exist.

## Secrets

### Android — required, you already have the keystore

| Secret | How to produce it |
| --- | --- |
| `KEY_JKS` | `base64 -w0 android/upload-keystore-placement-iitr.jks` |
| `ALIAS` | `keyAlias` from your local `android/key.properties` |
| `ANDROID_KEY_PASSWORD` | `keyPassword` from the same file |
| `ANDROID_STORE_PASSWORD` | `storePassword` from the same file |

A release build fails fast if `KEY_JKS` is missing.

> Passwords containing a backslash need it doubled, because `key.properties` is
> read as a Java properties file.

### Play Console — only needed for `publish_play`

| Secret | How to produce it |
| --- | --- |
| `PLAY_SERVICE_ACCOUNT_JSON` | Full JSON key of a Google Cloud service account that has been invited to the Play Console with the **Release manager** role for `com.channeli.img.placementonline`. Paste the file contents, not base64. |

The very first APK/AAB for an app has to be uploaded through the Play Console
web UI. The API can only add builds to an app that already exists.

### iOS — only needed for `publish_appstore`

| Secret | How to produce it |
| --- | --- |
| `IOS_CERTIFICATE_P12` | `base64 -i AppleDistribution.p12` — an Apple Distribution certificate exported from Keychain Access |
| `IOS_CERTIFICATE_PASSWORD` | The password set when exporting that `.p12` |
| `IOS_PROVISIONING_PROFILE` | `base64 -i profile.mobileprovision` — an **App Store** profile for `com.channeli.img.placementonline` |
| `APP_STORE_CONNECT_API_KEY` | `base64 -i AuthKey_XXXXX.p8` from App Store Connect → Users and Access → Integrations |
| `APP_STORE_CONNECT_API_KEY_ID` | The key ID, e.g. `2X9R4HXF34` |
| `APP_STORE_CONNECT_API_KEY_ISSUER_ID` | The issuer ID shown on the same page |
| `FASTLANE_TEAM_ID` | Optional. Defaults to the `DEVELOPMENT_TEAM` already in `Runner.xcodeproj` (`AT4J799SCP`). |

If these are absent the iOS job still runs and compiles the app unsigned, which
catches build breakage without needing an Apple account. Requesting
`publish_appstore` without them fails the job with an explicit message rather
than silently skipping.

Use `-w0` on Linux (`base64 -w0 file`) and `-i` on macOS (`base64 -i file`) so
the output is a single line with no wrapping.

## Local equivalents

```bash
bash scripts/bump_version.sh patch                  # edits pubspec.yaml in place
bash scripts/compute_tag.sh 2.6.0 true              # -> v2.6.0-beta.<next>
bash scripts/gen_changelog.sh IMGIITRoorkee/placement-flutter false notes.md
bash scripts/gen_downloads_table.sh v2.6.0-beta.1 IMGIITRoorkee/placement-flutter v2.6.0-beta.1 false
```

`scripts/compute_tag.sh` reads `git tag` for the beta counter, so it needs the
tags fetched — the workflow checks out with `fetch-depth: 0`.

`scripts/gen_changelog.sh` reads the previous release date from the GitHub API,
falling back to the last tag and then to the last 50 commits.
