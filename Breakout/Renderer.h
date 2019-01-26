//
//  Renderer.h
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Express.Graphics.h"

#import "Namespace.Igra.classes.h"

@interface Renderer : DrawableGameComponent {
    SpriteBatch *spriteBatch;
    Gameplay *gameplay;
    Matrix *camera;
    
    // Teksture
    Texture2D *teksture;
    Texture2D *background;
    Texture2D *health_energy;
    Texture2D *fireball_texture;
    Texture2D *teksture_ui;
    Texture2D *sword_tekstura;
    
    // Spriti
    Sprite *playerSprite;
    Sprite *enemySprite;
    Sprite *potionSprite;
    Sprite *menuSprite;
    Sprite *backgroundSprite;
    Sprite *buttonSprite;
    Sprite *buttonFireBallSprite;
    Sprite *buttonSwordAttackSprite;
    Sprite *fireballSprite;
    Sprite *swordSprite;
    
    // player movement and sword attack
    AnimatedSprite *playerMovementAnimatedSprite;
    AnimatedSprite *playerSwordAttackAnimatedSprite;
    
    // enemy movement and sword attack
    AnimatedSprite *enemyMovementAnimatedSprite;
    AnimatedSprite *enemySwordAttackAnimatedSprite;
    
    // Rotation of sprite
    SpriteEffects lastStateSprite;
}

- (id) initWithGame:(Game*)theGame gameplay:(Gameplay*)theGameplay;
@property (nonatomic, readonly) Matrix *camera;

@end
