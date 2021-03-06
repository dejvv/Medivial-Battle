//
//  Gameplay.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import "Gameplay.h"

#import "Namespace.Igra.h"

@implementation Gameplay

- (id) initWithGame:(Game *)theGame {
    self = [super initWithGame:theGame];
    if (self != nil) {
        level = [[Level alloc] initWithGame:self.game];
        gameHud = [[GameHud alloc ] initWithGame:self.game];
        playerHuman = [[HumanPlayer alloc] initWithGame:self.game Hero:level.hero Level:level];
        playerEnemy = [[EnemyPlayer alloc] initWithGame:self.game Enemy:level.enemy Level:level];
        physics = [[Physics alloc] initWithGame:self.game level:level];
        renderer = [[Renderer alloc] initWithGame:self.game gameplay:self];
        guiRenderer = [[GuiRenderer alloc] initWithGame:self.game scene:gameHud.scene gameplay:self];
        //debugRenderer = [[DebugRenderer alloc] initWithGame:self.game scene:level.scene];
        
        playerEnemyReflex = [[ReflexEnemy alloc] initWithGame:self.game Enemy:level.enemy Level:level];
        
        guiRenderer.drawOrder = 1; // najprej nariši objekte igre, on top of that pa gui
//        gameHud.updateOrder = 5;
//        gameHud.scene.updateOrder = 6;
        
        playerHuman.updateOrder = 0; // Game should process player input first
//        playerEnemy.updateOrder = 1; // Game should process player input first
        playerEnemyReflex.updateOrder = 1;
        physics.updateOrder = 2; // Then physics should be calculated, it updates the world
        level.updateOrder = 3; // Level updates scene, updateOrder of scene is 3
        level.scene.updateOrder = 4; // scene should be updated third
        self.updateOrder = 5; // Gameplay rules are updated and applaid last
        
//        [self.game.components addComponent:level];
//        [self.game.components addComponent:gameHud];
//        [self.game.components addComponent:playerHuman];
//        [self.game.components addComponent:playerEnemy];
//        [self.game.components addComponent:physics];
//        [self.game.components addComponent:renderer];
//        [self.game.components addComponent:guiRenderer];
//
//        [self.game.components addComponent:debugRenderer];
        NSLog(@"[gameplay] alloced");
    }
    return self;
}

- (void) initialize {
    NSLog(@"[gameplay] in initialize");
    [super initialize];
    NSLog(@"[gameplay] super initialized");
    
    
//    debugRenderer.colliderColor = [Color black];
//    debugRenderer.movementColor = [Color blue];
//    debugRenderer.itemColor = [Color red];
    //debugRenderer.transformMatrix = renderer.camera;

    //[playerHuman setCamera:renderer.camera];

//    [self reset];
//
    
    
}

- (void) activate {
    stopGameplay = 0.0;
    gameplayShouldFinish = NO;
    timePlaying = 0.0;
    [self.game.components addComponent:level];
    [self.game.components addComponent:gameHud];
    [self.game.components addComponent:playerHuman];
//    [self.game.components addComponent:playerEnemy];
    [self.game.components addComponent:playerEnemyReflex];
    [self.game.components addComponent:physics];
    [self.game.components addComponent:renderer];
    [self.game.components addComponent:guiRenderer];
    //[self.game.components addComponent:debugRenderer];
    NSLog(@"[gameplay] activated on %@", self);
//    NSLog(@"[gameplay] renderer.camera %@", renderer.camera);
    debugRenderer.transformMatrix = renderer.camera;
//
    [playerHuman setCamera:renderer.camera];

    [self reset];
}

- (void) deactivate {
    NSLog(@"[gameplay] deactivated on %@", self);
    [self.game.components removeComponent:level];
    [self.game.components removeComponent:gameHud];
    [self.game.components removeComponent:playerHuman];
//    [self.game.components removeComponent:playerEnemy];
    [self.game.components removeComponent:playerEnemyReflex];
    [self.game.components removeComponent:physics];
    [self.game.components removeComponent:renderer];
    [self.game.components removeComponent:guiRenderer];
    //[self.game.components removeComponent:debugRenderer];
}

- (void) reset {
    difficultyLevel = 0;
    [level resetLevel];
    [gameHud resetGui];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
//    NSLog(@"gameplay: updateWithGameTime");
    if (!level.hero.isAlive && !gameplayShouldFinish) {
//        NSLog(@"[gameplay updateWithGameTime] herota ni več");
        //[self reset];
        [level reinitializeObjects];
        [gameHud.finishMessage.label setText:@"Defeated!"];
        [gameHud.finishMessage.label setScale:[Vector2 vectorWithX:4 y:4]];
        stopGameplay = gameTime.totalGameTime + 5.0;
        gameplayShouldFinish = YES;
    } else if (!level.enemy.isAlive && !gameplayShouldFinish){
        [level reinitializeObjects];
        [gameHud.finishMessage.label setText:@"You won!"];
        [gameHud.finishMessage.label setScale:[Vector2 vectorWithX:4 y:4]];
        stopGameplay = gameTime.totalGameTime + 5.0;
        gameplayShouldFinish = YES;
        [GameProgress saveProgress:self.score time:(int)timePlaying/60];
    }
    
    if (stopGameplay > 0.0 && stopGameplay - gameTime.totalGameTime < 0.0){
        [igra popState];
    }
    
    if (gameplayShouldFinish)
        return;
    
    if (playerHuman.getShootFireball) {
        //if (level.fireballCount == 0) {
        //NSLog(@"gameplay: player fireball shoot!");
        [SoundEngine play:SoundEffectTypeFireBallShot];
        //
        [level addFireball:@"hero"];
        //}
    }
//    if (playerEnemy.getShootFireball) {
    if (playerEnemyReflex.getShootFireball) {
        //if (level.fireballCount == 0) {
        //NSLog(@"gameplay: enemy fireball shoot!");
        [SoundEngine play:SoundEffectTypeFireBallShot];
        [level addFireball:@"enemy"];
        //}
    }
    
    Matrix *inverseView = [Matrix invert:guiRenderer.camera];
    for (id item in gameHud.scene) {
        ButtonHud *button = [item isKindOfClass:[ButtonHud class]] ? item : nil;
        
        if (button) {
            [button updateWithInverseView:inverseView];
        }
    }
    
    gameHud.healthBarButtonHud.label.text = [NSString stringWithFormat:@"%.1f", level.hero.getHealth];
    [gameHud.healthBarButtonHud.backgroundImage setSourceRectangle:[[Rectangle alloc] initWithX: 0 y: [self calculateSourceRectangle:level.hero.getHealth max:[Constants getInstance].defaultValueHealth] width:128 height:16]];
    [gameHud.healthBarButtonHud.backgroundImage setScale:[Vector2 vectorWithX:2 y:2]];
    
    gameHud.energyBarButtonHud.label.text = [NSString stringWithFormat:@"%.1f", level.hero.getEnergy];
    [gameHud.energyBarButtonHud.backgroundImage setSourceRectangle:[[Rectangle alloc] initWithX: 0 y: [self calculateSourceRectangle:level.hero.getEnergy max:[Constants getInstance].defaultValueEnergy] width:128 height:16]];
    [gameHud.energyBarButtonHud.backgroundImage setScale:[Vector2 vectorWithX:2 y:2]];
    
    // for enemy
    gameHud.enemyHealthBarButtonHud.label.text = [NSString stringWithFormat:@"%.1f", level.enemy.getHealth];
    [gameHud.enemyHealthBarButtonHud.backgroundImage setSourceRectangle:[[Rectangle alloc] initWithX: 0 y: [self calculateSourceRectangle:level.enemy.getHealth max:[Constants getInstance].defaultValueHealth] width:128 height:16]];
    [gameHud.enemyHealthBarButtonHud.backgroundImage setScale:[Vector2 vectorWithX:2 y:2]];
    
    gameHud.enemeyEnergyBarButtonHud.label.text = [NSString stringWithFormat:@"%.1f", level.enemy.getEnergy];
    [gameHud.enemeyEnergyBarButtonHud.backgroundImage setSourceRectangle:[[Rectangle alloc] initWithX: 0 y: [self calculateSourceRectangle:level.enemy.getEnergy max:[Constants getInstance].defaultValueEnergy] width:128 height:16]];
    [gameHud.enemeyEnergyBarButtonHud.backgroundImage setScale:[Vector2 vectorWithX:2 y:2]];
    
    timePlaying += 1.0;
    
    self.score = [self calculateScoreOfPlayer:gameTime];
    NSString *scoreString = [NSString stringWithFormat:@"Score: %d", (int) self.score];
    [gameHud.playerScore setText:scoreString];
    
    if ((int) timePlaying % 60 == 0){
        NSString *timeString = [NSString stringWithFormat:@"Time: %d", (int) timePlaying/60];
        [gameHud.time setText: timeString];
    }
//    NSLog(@"player score: %.2f and string: ", self.score);
}

- (int) calculateSourceRectangle: (int) number max: (int) maxNumber {
    int array[21];
    for (int i = 20; i >= 0; i--)
        array[i] = 16 * (20 - i);
    int korak = maxNumber / 20; // health_bar in energy_bar imata 0-20 (torej 21) možnih slik
    int x = number / korak; // poračunaj katero sliko po vrsti moraš returnat
    return array[x];
}

- (float) calculateScoreOfPlayer:(GameTime *)time {
//    NSLog(@"hits received hero: %d", level.hero.numberOfHitsReceived);
//    NSLog(@"hits received enemy: %d", level.enemy.numberOfHitsReceived);
//    NSLog(@"total game time: %.2f, %.2f", timePlaying/60, time.totalGameTime);
    return MAX( MAX(level.enemy.numberOfHitsReceived*10 * 0.7 - level.hero.numberOfHitsReceived*10 * 0.3, 1) * 1000, 1) * 1/(timePlaying/60);
}

- (void) dealloc
{
    [self.game.components removeComponent:level];
    [self.game.components removeComponent:gameHud];
    [self.game.components removeComponent:playerHuman];
//    [self.game.components removeComponent:playerEnemy];
    [self.game.components removeComponent:playerEnemyReflex];
    [self.game.components removeComponent:physics];
    [self.game.components removeComponent:renderer];
    [self.game.components removeComponent:guiRenderer];
    [self.game.components removeComponent:debugRenderer];
    
    [level release];
    [gameHud release];
    [playerHuman release];
    [playerEnemy release];
    [physics release];
    [renderer release];
    [guiRenderer release];
    [debugRenderer release];
    
    [playerEnemyReflex release];
    
    [super dealloc];
}

@synthesize level, score;

@end
