# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is "TheCoreCogito" - a Godot 4.4 game project built on the COGITO framework, a first-person immersive sim template. The game appears to be a horror/survival experience with enemies, inventory management, and environmental interactions.

## Architecture

### Core Framework (COGITO)
The project is built on COGITO v1.1.0, located in `addons/cogito/`. Key architectural components:

- **Component-based interaction system**: Uses modular components for object interactions
- **Player attribute system**: Health, stamina, visibility, sanity managed through CogitoAttribute classes
- **Scene management**: CogitoSceneManager handles scene transitions and state persistence
- **Inventory system**: Resource-based flexible inventory with UI separation from logic

### Key Classes and Systems

**Core Objects (addons/cogito/CogitoObjects/)**:
- `CogitoPlayer`: Main player controller with movement, attributes, interaction handling
- `CogitoObject`: Base class for interactive objects
- `CogitoContainer`, `CogitoButton`, `CogitoSwitch`: Specific interaction types

**Management Systems**:
- `CogitoGlobals`: Global settings and debug logging (cogito_globals.gd)
- `CogitoSceneManager`: Scene transitions and state management
- `CogitoQuestManager`: Quest system handling
- `MenuTemplateManager`: Menu and UI management

**Component Architecture**:
- Located in `addons/cogito/Components/`
- Modular interaction components (PickupComponent, CarryableComponent, etc.)
- Attribute components for player stats
- UI components for HUD elements

### Project Structure

- `scenes/`: Game-specific scenes (map.tscn, enemy.tscn, etc.)
- `addons/cogito/`: Core COGITO framework
- `addons/input_helper/`: Input handling utilities
- `addons/quick_audio/`: Audio management system
- `Models/`: 3D models and textures
- `docs/`: Documentation (uses Sphinx)

## Development Commands

This is a Godot project - no traditional build scripts. Development workflow:

1. **Open in Godot**: Import project.godot in Godot 4.4+ editor
2. **Run game**: Press F5 or use Play button in editor
3. **Debug**: Use Godot's built-in debugger and remote inspector
4. **Export**: Use Godot's export system for platform-specific builds

## Common Development Patterns

### Adding Interactive Objects
1. Extend CogitoObject or use existing subclasses
2. Add interaction components from `Components/Interactions/`
3. Configure interaction properties in inspector
4. Connect signals for custom behavior

### Player Attribute Management
- Use `player.increase_attribute()` and `player.decrease_attribute()`
- Attributes: "health", "stamina", "visibility", "sanity"
- Check `player_attributes` dictionary for availability

### Scene Transitions
- Use CogitoSceneManager.load_scene() for scene changes
- Implements save/load state persistence automatically

### Audio System
- Use `Audio.play_sound()` and `Audio.play_sound_3d()` from quick_audio addon
- Footstep system integrated into player controller

## Important Settings

**Project Configuration**:
- Max FPS: 120
- Physics: Jolt Physics engine
- Input maps: Fully customizable via in-game options

**Key Paths**:
- Main scene: `res://addons/cogito/DemoScenes/COGITO_0_MainMenu.tscn`
- Player scene: `res://addons/cogito/PackedScenes/cogito_player.tscn`
- Settings: `res://addons/cogito/CogitoSettings.tres`

## Debugging

- Enable logging via CogitoGlobals.is_logging
- Use CogitoGlobals.debug_log() for consistent debug output
- Check console for COGITO-prefixed debug messages

## Known Issues

- Project is hobbyist open source software, not 100% bug-free
- Some WIP features (systemic properties system)
- Check GitHub issues for known problems