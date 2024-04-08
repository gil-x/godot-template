# Godot - Simple Starting template for 2D game

## Features

- nice debug script (src/global/debug.gd)
- global vars script (src/global/vars.gd)
- splash screens scenes
- title screen with main menu
- global game state machine
- pause on 'ui_cancel' press

## Conception details

### Debug script

Use cases:

```gdscript
Debug.print("Some message")
Debug.print(["Message", some_var, value])
```

### State Machine

State Machine is located in src/global/game.gd

This states are pre-made: SPLASH_SCREENS, TITLE_SCREEN, IN_GAME, PAUSED, GAME_OVER

Use the dedicated function and values to switch to another state:

```gdscript
Game.change_state(Game.State.IN_GAME)
```

### Pause

Uses Engine.time_scale, sets/unsets a very small value.

## Before use

0. rewrite this README file
1. remove debug_test function from main.gd
2. remove global test var from vars.gd
3. remove assets/samples
4. modify splashcreens scenes or make news
5. modify title screen
6. modify main menu

## Samples credits

- Music _'Which Brand Of Mustard Shall I Buy'_ from [congusbongus](https://opengameart.org/users/congusbongus).
