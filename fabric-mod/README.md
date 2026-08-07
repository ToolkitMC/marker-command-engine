# Marker Command Engine Fabric Mod

This directory packages the secured Marker Command Engine datapack as a Fabric mod.

## Target

- Minecraft: `1.20.1`
- Java: `17+`
- Fabric Loader: `0.19.3+`
- Fabric API: `0.92.11+1.20.1` (**required**)
- Mod Menu: `7.2.2+` (**optional**, provides the info screen)

Minecraft `1.20.1` was chosen because the datapack uses `pack_format: 15`.

## What the mod does

The mod JAR contains the datapack resources under `data/`, so Minecraft loads MCE functions/tags from the mod just like a bundled data pack. The Java bootstrap only logs startup and registers a Fabric API server lifecycle callback.


## GUI/UI dashboard

The Fabric build includes a client-side dashboard. It sends normal server commands, so the player still needs permission to run `/function` and `/data` on the server.

Open it with any of these methods:

- Server command: `/mcegui`
- Mod Menu: Mods -> Marker Command Engine -> Configure -> Open Chest GUI
- Keybind: bind **Open MCE GUI** under Controls -> Marker Command Engine
- Right-click the **MCE Control Panel** item

The dashboard is now a server-side 9x3 chest GUI. It no longer contains a `/reload` button. Chest actions and MCE utility items share a 30 second cooldown.

Chest actions include:

- Version/help/security status
- Strict mode on/off, allow next command, security reset
- Start/clear queue
- Clear schedule
- Show/clear log
- Debug toggle
- Cancel active command

New creative tab: **Marker Command Engine**. It contains:

- MCE Control Panel
- MCE Help Manual
- MCE Security Key
- MCE Queue Core
- MCE Schedule Clock
- MCE Log Reader
- MCE Cancel Core

## Mod Menu integration

When Mod Menu is installed, the `modmenu` entrypoint adds a simple information screen with useful commands:

```mcfunction
/function mce:api/util/version
/function mce:api/util/help
/function mce:api/security/status
```

The mod still works without Mod Menu installed.

## Build

Use Java 17 or newer:

```bash
cd fabric-mod
./gradlew build
```

If you do not have a Gradle wrapper, run with a local Gradle installation:

```bash
gradle build
```

Output JAR:

```text
fabric-mod/build/libs/marker-command-engine-fabric-2.3.3-chestgui+1.20.1.jar
```

## Install

Place these files in the client/server `mods/` folder:

1. `marker-command-engine-fabric-2.3.3-chestgui+1.20.1.jar`
2. Fabric API for Minecraft 1.20.1
3. Optional: Mod Menu for Minecraft 1.20.1

Then start the game/server and run:

```mcfunction
/reload
/function mce:api/util/version
```
