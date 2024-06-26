# Godot - Simple Starting template for 2D game

## Features

- nice debug script (src/global/debug.gd)
- global vars script (src/global/vars.gd)
- splash screens scenes
- title screen with main menu
- global game state machine
- pause on 'ui_cancel' press
- options menu
- change global music & SFX volume
- audio player global scene
- key binding recipe

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

### Key binding

Names displayed with _as_text()_ are good only with real qwerty keyboard because this function refers to physical key positions.

### Pause

Uses Engine.time_scale, sets/unsets a very small value.

### Sound Volume

- there is 2 audio busses: Music & SFX
- you have to assign each AudioStreamPlayer to one of this busses

## Before use

0. rewrite this README file
1. remove debug_test function from main.gd
2. remove global test var from vars.gd
3. remove assets/samples
4. modify splashcreens scenes or make news
5. modify title screen
6. modify main menu
7. remove or rewrite properly _key_binding_ and _test_controls_ scenes

## Samples credits

- Music _'Which Brand Of Mustard Shall I Buy'_ by [congusbongus](https://opengameart.org/users/congusbongus)
- Music _'techno-geek'_ by [mrpoly](https://opengameart.org/content/techno-geek)
- SFX from Kenney
