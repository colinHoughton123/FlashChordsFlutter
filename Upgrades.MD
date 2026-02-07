# Upgrades

This document describes the steps to perform a release upgrade for FlashChords.

## Goals
- Bump the app binary version/build
- Update remote `version.json` so clients can check for updates
- Ensure upgrade prompts (optional/forced) behave correctly

## Step 1: Update the app binary version/build
Edit `pubspec.yaml` and update the `version:` field.

Example:
- `version: 1.0.0+1`
- `version: 1.1.0+2`

Notes:
- The value before `+` is the **version** shown to users.
- The value after `+` is the **build number** (must increase every release).

## Step 2: Update remote `version.json`
Update the file in the repo:
- `version.json`

Fields to update:
- `latest.version`
- `latest.build`
- `minimum_supported.version`
- `minimum_supported.build`
- `force_update`
- localized `messages` (if needed)

Example:
```
{
  "app": "flashchords",
  "latest": { "version": "1.1.0", "build": 2 },
  "minimum_supported": { "version": "1.0.0", "build": 1 },
  "force_update": false,
  "messages": {
    "en": { "title": "Update available", "body": "A new version of FlashChords is available." }
  }
}
```

## Step 3: Verify the in-app version label
The Configuration screen shows the binary version/build from the OS.
Check that it matches the `pubspec.yaml` value you set.

Expected format:
- `Version X.Y.Z (BUILD)`

## Step 4: Test update prompt behavior
1. Install an older build.
2. Update `version.json` to a newer version.
3. Launch the app.
4. Verify:
   - Optional update when `force_update` is false
   - Forced update when `force_update` is true

## Step 5: Release
- Upload to TestFlight / Play Console as usual
- Tag the release in git if desired

## Notes
- The in-app version label uses the binary version/build, not `version.json`.
- Always increment the build number for each release.
