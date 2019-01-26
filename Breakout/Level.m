//
//  Level.m
//  Igra
//
//  Created by David Zagorsek on 12/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import "Level.h"
#import "Namespace.Igra.h"

@implementation Level

- (id) initWithGame:(Game *)theGame {
    self = [super initWithGame:theGame];
    if (self != nil) {
        scene = [[SimpleScene alloc] initWithGame:theGame];
        
        [self.game.components addComponent:scene];
        
        // Add delegates that send message to listeners when something is added or removed to scene
        [scene.itemAdded subscribeDelegate:[Delegate delegateWithTarget:self Method:@selector(itemAddedToScene:eventArgs:)]];
        [scene.itemRemoved subscribeDelegate:[Delegate delegateWithTarget:self Method:@selector(itemRemovedFromScene:eventArgs:)]];
        
        hero = [[Hero alloc] init];
        enemy = [[Enemy alloc] init];
        heroSword = [[ItemSword alloc] initWithCharacter:hero]; // weapon ve, da pripada herotu
        [hero setMyWeapon:heroSword]; // dodaj herotu weapon
        enemySword = [[ItemSword alloc] initWithCharacter:enemy]; // enako za enemy weapon
        [enemy setMyWeapon:enemySword];
    }
    return self;
}

- (void) initialize {
    float aspectRatio = (float)self.game.gameWindow.clientBounds.width / (float)self.game.gameWindow.clientBounds.height;
    bounds = [[Rectangle alloc] initWithX:0 y:0 width:1000 height:1000/aspectRatio];
    NSLog(@" aspect: %f bounds: [%d, %d] bounds.x: %d, bounds.y: %d", aspectRatio, bounds.width, bounds.height, bounds.x, bounds.y);
    NSLog(@" gameWindow: %f %f", (float)self.game.gameWindow.clientBounds.width, (float)self.game.gameWindow.clientBounds.height);
    
    // set Y coordinate of bottom
    [Constants setGroundY:bounds.height-[Constants getInstance].groundHeight];
    
    hero.position.x = bounds.width / 2;
    hero.position.y = [Constants getInstance].groundY;
    NSLog(@"[level.initialize] hero.pos: %f, %f", hero.position.x, hero.position.y);
    //hero.velocity.x = 50;
    //hero.velocity.y = 0;
    
    enemy.position.x = bounds.width / 4;
    enemy.position.y = [Constants getInstance].groundY;
    NSLog(@"[level.initialize] enemy.pos: %f, %f", enemy.position.x, enemy.position.y);
    //enemy.velocity.x = -250;
    //enemy.velocity.y = -550;
}

- (void) resetLevel {
     NSLog(@"[level resetLeve] called");
    // Remove everything from the scene.
    [scene clear];
    
     //Add level limits.
    [scene addItem:[[[LevelLimit alloc] initWithLimit:
                     [AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionPositiveX distance:bounds.x] isDeadly:NO] autorelease]];
    [scene addItem:[[[LevelLimit alloc] initWithLimit:
                     [AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionNegativeX distance:-bounds.width] isDeadly:NO] autorelease]];
    [scene addItem:[[[LevelLimit alloc] initWithLimit:
                     [AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionPositiveY distance:bounds.y] isDeadly:NO] autorelease]];
    [scene addItem:[[[LevelLimit alloc] initWithLimit:
                     [AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionNegativeY distance:-bounds.height+[Constants getInstance].groundHeight] isDeadly:NO] autorelease]];

    // Add hero and enemy
    [scene addItem:hero];
    [scene addItem:enemy];
    [scene addItem:heroSword];
    [scene addItem:enemySword];
    
    // Add buttons
    buttonLeft = [[Button alloc] initWithRectangle: [[Rectangle rectangleWithX:bounds.width / 12 y: (bounds.height - bounds.height / 6) width:64 height:64] retain] directionOfButton:@"left"];

    
    buttonRight = [[Button alloc] initWithRectangle: [[Rectangle rectangleWithX:bounds.width / 12 + 128 y: (bounds.height - bounds.height / 6) width:64 height:64] retain] directionOfButton:@"right"];
    
    buttonJump = [[Button alloc] initWithRectangle: [[Rectangle rectangleWithX:(bounds.width - bounds.width / 12 - 64) y: (bounds.height - bounds.height / 6) width:64 height:64] retain] directionOfButton:@"jump"];
    
    buttonFire = [[Button alloc] initWithRectangle: [[Rectangle rectangleWithX:(bounds.width - bounds.width / 12 - 64) y: (bounds.height - bounds.height / 6 - 128) width:64 height:64] retain] directionOfButton:@"fire"];
    
    buttonAttack = [[Button alloc] initWithRectangle: [[Rectangle rectangleWithX:(bounds.width - bounds.width / 12 - 172) y: (bounds.height - bounds.height / 6) width:64 height:64] retain] directionOfButton:@"attack"];
    
    [scene addItem:buttonLeft];
    [scene addItem:buttonRight];
    [scene addItem:buttonFire];
    [scene addItem:buttonJump];
    [scene addItem:buttonAttack];
    //NSLog(@"scene: %@",scene);
}

- (void) addFireball:(NSString*)item {
    FireBall *fireball = [[[FireBall alloc] init] autorelease];
    if ([item isEqual:@"hero"]){
        fireball.position.x = hero.position.x + ([hero.getOrientation isEqual:@"left"] ? - hero.width / 2 - fireball.radius : hero.width/2 + fireball.radius);
        fireball.position.y = hero.position.y;
        fireball.velocity.x = [hero.getOrientation isEqual:@"left"] ? -[Constants getInstance].defaultFireBallSpeed : [Constants getInstance].defaultFireBallSpeed;
        fireball.velocity.y = 0;
        [fireball setFiredBy:@"hero"];
    } else if ([item isEqual:@"enemy"]) {
        fireball.position.x = enemy.position.x + ([enemy.getOrientation isEqual:@"left"] ? -enemy.width/2 - fireball.radius/2 : enemy.width/2 + fireball.radius/2);
        fireball.position.y = enemy.position.y;
        fireball.velocity.x = [enemy.getOrientation isEqual:@"left"] ? -[Constants getInstance].defaultFireBallSpeed : [Constants getInstance].defaultFireBallSpeed;
        fireball.velocity.y = 0;
        [fireball setFiredBy:@"enemy"];
    }
    NSLog(@"[addFireball] fireball.pos.x: %f, hero.pos.x: %f", fireball.position.x, hero.position.x);
    [scene addItem:fireball];
}

- (void) reinitializeObjects {
    [hero reset];
    [enemy reset];
    [scene addItem:hero];
    NSLog(@"[level reinitializeObjects] done!");
}

- (void) itemAddedToScene:(id)sender eventArgs:(SceneEventArgs*)e {
    if ([e.item isKindOfClass:[FireBall class]]) {
        fireballCount++;
    }
}

- (void) itemRemovedFromScene:(id)sender eventArgs:(SceneEventArgs*)e {
    if ([e.item isKindOfClass:[FireBall class]]) {
        fireballCount--;
    }
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    //NSLog(@"level: updateWithGameTime");
    // Update all items with custom update.
    for (id item in scene) {
        id<ICustomUpdate> updatable = [item conformsToProtocol:@protocol(ICustomUpdate)] ? item : nil;
        
        if (updatable) {
            [updatable updateWithGameTime:gameTime];
        }
    }
}

- (Button*) getButtonLeft {
    return buttonLeft;
}

- (Button*) getButtonRight {
    return buttonRight;
}

- (Button*) getButtonFire {
    return buttonFire;
}

- (Button*) getButtonJump {
    return buttonJump;
}

- (Button*) getButtonAttack {
    return buttonAttack;
}

@synthesize scene, hero, enemy, bounds, fireballCount;

- (void) dealloc
{
    [hero release];
    [enemy release];
    [scene release];
    [bounds release];
    [buttonRight release];
    [buttonLeft release];
    [buttonFire release];
    [buttonJump release];
    [buttonAttack release];
    [heroSword release];
    [enemySword release];
    [super dealloc];
}

@end

