//
//  Level.h
//  Igra
//
//  Created by David Zagorsek on 12/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Express.Scene.h"

#import "Namespace.Igra.classes.h"

@interface Level : GameComponent {
    SimpleScene *scene;
    Rectangle *bounds;
    
    // count for how many fireballs are there on scene, either 0 or 1
    int fireballCount;
    
    // add hero and enemy to the level
    Hero *hero;
    Enemy *enemy;
    
    // also add buttons
    Button *buttonLeft; // naj gre hero levo
    Button *buttonRight; // naj gre hero desno
    Button *buttonFire; // shoot fireball
    Button *buttonJump; // jump
    Button *buttonAttack; // attack with sword button
    
    // sword
    ItemSword *heroSword;
    ItemSword *enemySword;
}

@property (nonatomic, readonly) id<IScene> scene;
@property (nonatomic, readonly) Hero *hero;
@property (nonatomic, readonly) Enemy *enemy;
@property (nonatomic, readonly) Rectangle *bounds;

@property (nonatomic, readonly) int fireballCount;

- (Button*) getButtonLeft;
- (Button*) getButtonRight;
- (Button*) getButtonFire;
- (Button*) getButtonJump;
- (Button*) getButtonAttack;
- (void) resetLevel;
- (void) addFireball: (NSString*) item;
- (void) reinitializeObjects; // happens on reset levels, it resets parameters of hero and enemy

@end
