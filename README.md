# Achieve

Library to easily implement achievements in a game. Every achievement is described as a combination of properties (which are counters) guided by simple update and activation rules. When all the properties related to an achievement are active, the achievement is unlocked.

Properties can also be tagged and updated/reset in batch, which is useful for implementing level related achievements, such as `"kill all enemies of level N"`. A property can be updated with a single method call and the library takes care of analyzing activation rules and checking if a new achievement was unlocked.

## Usage

```
var a :Achieve = new Achieve();

function initGame() :void {
  a.defineProperty("killedEnemies", 0, Achieve.ACTIVE_IF_GREATER_THAN, 10, "levelStuff");
  a.defineProperty("lives", 3, Achieve.ACTIVE_IF_EQUALS_TO, 3, "levelStuff");
  a.defineProperty("completedLevels", 0, Achieve.ACTIVE_IF_GREATER_THAN, 5);
  a.defineProperty("deaths", 0, Achieve.ACTIVE_IF_EQUALS_TO, 0);

  a.defineAchievement("masterKill", ["killedEnemies"]); // Kill 10+ enemies.
  a.defineAchievement("cantTouchThis", ["lives"]); // Complete a level and don't die.
  a.defineAchievement("nothingElse", ["completedLevels"]); // Beat all 5 levels.
  a.defineAchievement("hero", ["completedLevels", "deaths"]); // Beat all 5 levels, do not die during the process
}

function gameLoop() :void {
  if(enemyWasKilled()) {
    a.addValue(["killedEnemies"], 1);
  }

  if(playerJustDied()) {
    a.addValue(["lives"], -1);
    a.addValue(["deaths"], 1);
  }
}

function levelUp() :void {
  a.addValue(["completedLevels"], 1);

  a.checkAchievements();
  // Reset all properties tagged with 'levelStuff'
  a.resetProperties("levelStuff");
}
```

## Motivation

Achieve was created to illustrate [how to code unlockable achievements for your game (a simple approach)](http://gamedevelopment.tutsplus.com/tutorials/how-to-code-unlockable-achievements-for-your-game-a-simple-approach--gamedev-6012).

## Contributors

If you liked the project and want to help, you are welcome! Submit pull requests or [open a new issue](https://github.com/Dovyski/Achieve/issues) describing your idea.

## License

Achieve is licensed under the MIT license.
