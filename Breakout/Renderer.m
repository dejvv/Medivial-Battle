//
//  Renderer.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import "Renderer.h"
#import "Namespace.Igra.h"

@implementation Renderer

- (id) initWithGame:(Game *)theGame gameplay:(Gameplay *)theGameplay{
    self = [super initWithGame:theGame];
    if (self != nil){
        gameplay = theGameplay;
    }
    return self;
}

- (void) initialize {
//    float scaleX = (float)self.game.gameWindow.clientBounds.width / (float)gameplay.level.bounds.width;
//    float scaleY = (float)self.game.gameWindow.clientBounds.height / (float)gameplay.level.bounds.height;
//    camera = [[Matrix createScale:[Vector3 vectorWithX:scaleX y:scaleY z:1]] retain];
    
    float scaleX = 1;
    float scaleY = 1;
    if (gameplay == nil) {
        float aspectRatio = (float)self.game.gameWindow.clientBounds.width / (float)self.game.gameWindow.clientBounds.height;
        Rectangle *bounds = [[Rectangle alloc] initWithX:0 y:0 width:1000 height:1000/aspectRatio];
        scaleX = (float)self.game.gameWindow.clientBounds.width / bounds.width;
        scaleY = (float)self.game.gameWindow.clientBounds.height / bounds.height;
    } else {
        scaleX = (float)self.game.gameWindow.clientBounds.width / (float)gameplay.level.bounds.width;
        scaleY = (float)self.game.gameWindow.clientBounds.height / (float)gameplay.level.bounds.height;
    }
    
    NSLog(@"[renderer] scalex: %f, scaley: %f", scaleX, scaleY);
    camera = [[Matrix createScale:[Vector3 vectorWithX:scaleX y:scaleY z:1]] retain];
    
    [super initialize];
}

- (void) loadContent {
    lastStateSprite = SpriteEffectsNone; // how should be hero sprite rotated
    
    spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
    background = [self.game.content load:@"background_village"];
    teksture = [self.game.content load:@"atlas"];
    fireball_texture = [self.game.content load:@"fireball"];
    teksture_ui = [self.game.content load:@"atlas_ui"];
    sword_tekstura = [self.game.content load:@"sword"];
    //health_energy = [self.game.content load:@"health_energy"];
    
    playerSprite = [[Sprite alloc] init];
    playerSprite.texture = teksture;
    playerSprite.sourceRectangle = [[Rectangle alloc] initWithX: 0 y:0 width:72 height:72];
    playerSprite.origin = [Vector2 vectorWithX:playerSprite.sourceRectangle.width / 2 y:playerSprite.sourceRectangle.height / 2];
    
    enemySprite = [[Sprite alloc] init];
    enemySprite.texture = teksture;
    enemySprite.sourceRectangle = [[Rectangle alloc] initWithX: 360 y: 576 width:72 height:72];
    enemySprite.origin = [Vector2 vectorWithX:enemySprite.sourceRectangle.width / 2 y:enemySprite.sourceRectangle.height / 2];
    
    fireballSprite = [[Sprite alloc] init];
    fireballSprite.texture = fireball_texture;
    fireballSprite.sourceRectangle = [[Rectangle alloc] initWithX: 0 y:0 width:32 height:32];
    fireballSprite.origin = [Vector2 vectorWithX:fireballSprite.sourceRectangle.width / 2 y:fireballSprite.sourceRectangle.height / 2];
    
//    potionSprite = [[Sprite alloc] init];
//    potionSprite.texture = teksture;
//    potionSprite.sourceRectangle = [[Rectangle alloc] initWithX: 432 y: 432 width:72 height:72];
//    potionSprite.origin = [Vector2 vectorWithX:potionSprite.sourceRectangle.width / 2 y:potionSprite.sourceRectangle.height / 2];
    
//    menuSprite = [[Sprite alloc] init];
//    menuSprite.texture = teksture;
//    menuSprite.sourceRectangle = [[Rectangle alloc] initWithX: 64 y: 788 width:16 height:16];
//    menuSprite.origin = [Vector2 vectorWithX:menuSprite.sourceRectangle.width / 2 y:menuSprite.sourceRectangle.height / 2];
    
    backgroundSprite = [[Sprite alloc] init];
    backgroundSprite.texture = background;
    backgroundSprite.sourceRectangle = [[Rectangle alloc] initWithX: 0 y: 0 width:512 height:256];
    backgroundSprite.origin = [Vector2 vectorWithX:backgroundSprite.sourceRectangle.width / 2 y:backgroundSprite.sourceRectangle.height / 2];
    
//    buttonSprite = [[Sprite alloc] init];
//    buttonSprite.texture = teksture;
//    buttonSprite.sourceRectangle = [[Rectangle alloc] initWithX: 16 y: 788 width:16 height:16];
//    buttonSprite.origin = [Vector2 vectorWithX:buttonSprite.sourceRectangle.width / 2 y:buttonSprite.sourceRectangle.height / 2];
    
    buttonSprite = [[Sprite alloc] init];
    buttonSprite.texture = teksture_ui;
    buttonSprite.sourceRectangle = [[Rectangle alloc] initWithX: 0 y: 32 width:32 height:32];
    buttonSprite.origin = [Vector2 vectorWithX:buttonSprite.sourceRectangle.width / 2 y:buttonSprite.sourceRectangle.height / 2];
    
    buttonFireBallSprite = [[Sprite alloc] init];
    buttonFireBallSprite.texture = teksture_ui;
    buttonFireBallSprite.sourceRectangle = [[Rectangle alloc] initWithX: 32 y: 0 width:32 height:32];
    buttonFireBallSprite.origin = [Vector2 vectorWithX:buttonFireBallSprite.sourceRectangle.width / 2 y:buttonFireBallSprite.sourceRectangle.height / 2];
    
    buttonSwordAttackSprite = [[Sprite alloc] init];
    buttonSwordAttackSprite.texture = teksture_ui;
    buttonSwordAttackSprite.sourceRectangle = [[Rectangle alloc] initWithX: 0 y: 0 width:32 height:32];
    buttonSwordAttackSprite.origin = [Vector2 vectorWithX:buttonSwordAttackSprite.sourceRectangle.width / 2 y:buttonSwordAttackSprite.sourceRectangle.height / 2];
    
    swordSprite = [[Sprite alloc] init];
    swordSprite.texture = sword_tekstura;
    swordSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:32 height:32];
    swordSprite.origin = [Vector2 vectorWithX:swordSprite.sourceRectangle.width/2 y:swordSprite.sourceRectangle.height];

    // animated hero moving
    playerMovementAnimatedSprite = [[AnimatedSprite alloc] initWithDuration:0.5];
    playerMovementAnimatedSprite.looping = YES;
    for (int i = 0; i < 9; i++) {
        if (i == 1)
            continue;
        int row = i % 9;
        NSLog(@"hero moving: %d row: %d", i, row);
        Sprite *sprite = [[[Sprite alloc] init] autorelease];
        sprite.texture = teksture;
        sprite.sourceRectangle = [Rectangle rectangleWithX:row * 72 y:0 width:72 height:72];
        sprite.origin = [Vector2 vectorWithX:sprite.sourceRectangle.width / 2 y:sprite.sourceRectangle.height / 2];
        
        AnimatedSpriteFrame *frame = [AnimatedSpriteFrame frameWithSprite:sprite start:playerMovementAnimatedSprite.duration *
                                      ((i > 0) ? (i*1.0 - 1.0) / 8: (float)i / 8)];
        [playerMovementAnimatedSprite addFrame:frame];
    }
    playerMovementAnimatedSprite.looping = YES;
    
    // animated enemy moving
    enemyMovementAnimatedSprite = [[AnimatedSprite alloc] initWithDuration:0.5];
    enemyMovementAnimatedSprite.looping = YES;
    int y_sprite = 576;
    for (int i = 5; i < 13; i++) {
        if (i == 10)
            y_sprite += 72; // jump into next line
        int row = i % 10;
        NSLog(@"enemy moving: %d row: %d", i, row);
        Sprite *sprite = [[[Sprite alloc] init] autorelease];
        sprite.texture = teksture;
        sprite.sourceRectangle = [Rectangle rectangleWithX:row * 72 y:y_sprite width:72 height:72];
        sprite.origin = [Vector2 vectorWithX:sprite.sourceRectangle.width / 2 y:sprite.sourceRectangle.height / 2];

        AnimatedSpriteFrame *frame = [AnimatedSpriteFrame frameWithSprite:sprite start:enemyMovementAnimatedSprite.duration *
                                      ((i > 0) ? (i*1.0 - 5.0) / 8: (float)i / 8)];
        
        [enemyMovementAnimatedSprite addFrame:frame];
    }
    enemyMovementAnimatedSprite.looping = YES;
    
    
    // sword attack hero
    playerSwordAttackAnimatedSprite = [[AnimatedSprite alloc] initWithDuration:[Constants getInstance].swordAttackDuration];
    playerSwordAttackAnimatedSprite.looping = YES;
    for (int i = 0; i < 3; i++) {
        int row = 0;
        int column = 0;
        if (i == 0){
            row = 9;
            column = 6;
        } else if (i == 1){
            row = 0;
            column = 7;
        } else {
            //continue;
            row = 1;
            column = 7;
        }
        NSLog(@"sword attack i: %d row: %d", i, row);
        Sprite *sprite = [[[Sprite alloc] init] autorelease];
        sprite.texture = teksture;
        sprite.sourceRectangle = [Rectangle rectangleWithX:row * 72 y:column * 72 width:72 height:72];
        sprite.origin = [Vector2 vectorWithX:sprite.sourceRectangle.width / 2 y:sprite.sourceRectangle.height / 2];
        
        AnimatedSpriteFrame *frame = [AnimatedSpriteFrame frameWithSprite:sprite start:playerSwordAttackAnimatedSprite.duration * (float)i / 3];
        
        //
        // duration * (0 / 3) = 0   1.slika
        // duration * (1 / 3) = 1/3 2.slika
        // duration * (2 / 3) = 2/3 3.slika
        [playerSwordAttackAnimatedSprite addFrame:frame];
        //648x432 je prvi sprit
    }
    playerSwordAttackAnimatedSprite.looping = YES;
    
    // sword attack enemy
    enemySwordAttackAnimatedSprite = [[AnimatedSprite alloc] initWithDuration:[Constants getInstance].swordAttackDuration];
    enemySwordAttackAnimatedSprite.looping = YES;
    for (int i = 3; i < 6; i++) {
        NSLog(@"enemy sword attack i: %d", i);
        Sprite *sprite = [[[Sprite alloc] init] autorelease];
        sprite.texture = teksture;
        sprite.sourceRectangle = [Rectangle rectangleWithX:i * 72 y:648 width:72 height:72];
        sprite.origin = [Vector2 vectorWithX:sprite.sourceRectangle.width / 2 y:sprite.sourceRectangle.height / 2];
        
        AnimatedSpriteFrame *frame = [AnimatedSpriteFrame frameWithSprite:sprite start:enemySwordAttackAnimatedSprite.duration * (((float)i - 3.0) / 3)];
        [enemySwordAttackAnimatedSprite addFrame:frame];
    }
    enemySwordAttackAnimatedSprite.looping = YES;
    
}

- (void) drawWithGameTime:(GameTime *)gameTime {
    [self.graphicsDevice clearWithColor:[Color beige]];
    [spriteBatch beginWithSortMode:SpriteSortModeBackToFront BlendState:[BlendState alphaBlend] SamplerState:[SamplerState pointClamp]
                 DepthStencilState:nil RasterizerState:nil Effect:nil TransformMatrix:camera];
    
    // background
     [spriteBatch draw:backgroundSprite.texture toRectangle:[[Rectangle alloc] initWithX:0 y:0 width: gameplay.level.bounds.width height:gameplay.level.bounds.height] fromRectangle:nil  tintWithColor:[Color white] rotation:0 origin:[Vector2 vectorWithX:gameplay.level.bounds.width / 2 y: gameplay.level.bounds.height / 2] effects:SpriteEffectsNone layerDepth: 0];
    
    for (id item in gameplay.level.scene) {
        id <Position> itemWithPosition = [item conformsToProtocol:@protocol(IPosition)] ? item : nil;
        
        if (itemWithPosition == nil)
            continue;
        // hero
        if ([item isKindOfClass:[Hero class]]) {
            // not animated hero
            Hero *hero = item;
//            //NSLog(@"rendere: hero pos: %f %f",hero.position.x, hero.position.y);
            Rectangle *heroPos = [Rectangle rectangleWithX:hero.position.x
                                                         y:hero.position.y
                                                     width:playerSprite.sourceRectangle.width
                                                    height:playerSprite.sourceRectangle.height];
            if (hero.isMoving){
                // animate hero whilte its moving
                Sprite *sprite = [playerMovementAnimatedSprite spriteAtTime:gameTime.totalGameTime];
                
                [spriteBatch draw:sprite.texture to:[Vector2 vectorWithX:heroPos.x y: heroPos.y] fromRectangle:sprite.sourceRectangle tintWithColor:[Color white]
                         rotation:0 origin: sprite.origin scaleUniform:3 effects:lastStateSprite layerDepth:0];
            } else if (hero.getSwordAttack) {
                // hero attacking with sword
                Sprite *sprite = [playerSwordAttackAnimatedSprite spriteAtTime:gameTime.totalGameTime];

                [spriteBatch draw:sprite.texture to:[Vector2 vectorWithX:heroPos.x y: heroPos.y] fromRectangle:sprite.sourceRectangle tintWithColor:[Color white]
                         rotation:0 origin: sprite.origin scaleUniform:3 effects:lastStateSprite layerDepth:0];
                
            } else {
                // hero standing still
                [spriteBatch draw:playerSprite.texture to:[Vector2 vectorWithX:heroPos.x y: heroPos.y] fromRectangle:playerSprite.sourceRectangle tintWithColor:[Color white] rotation:0 origin:playerSprite.origin scaleUniform:3 effects:lastStateSprite layerDepth:0 ];
            }
            
        }
        
        // enemy
        if ([item isKindOfClass:[Enemy class]]) {
            Enemy *enemy = item;
            Rectangle *enemyPos = [Rectangle rectangleWithX:enemy.position.x
                                                         y:enemy.position.y
                                                     width:enemySprite.sourceRectangle.width
                                                    height:enemySprite.sourceRectangle.height];
            
            
            if (enemy.isMoving){
                // animate enemy while its moving
                Sprite *sprite = [enemyMovementAnimatedSprite spriteAtTime:gameTime.totalGameTime];
                
                [spriteBatch draw:sprite.texture to:[Vector2 vectorWithX:enemyPos.x y: enemyPos.y] fromRectangle:sprite.sourceRectangle tintWithColor:[Color white]
                         rotation:0 origin: sprite.origin scaleUniform:3 effects:[enemy.getOrientation isEqual:@"left"] ? SpriteEffectsFlipHorizontally : SpriteEffectsNone layerDepth:0];
            } else if (enemy.getSwordAttack) {
                // hero attacking with sword
                Sprite *sprite = [enemySwordAttackAnimatedSprite spriteAtTime:gameTime.totalGameTime];
                
                [spriteBatch draw:sprite.texture to:[Vector2 vectorWithX:enemyPos.x y: enemyPos.y] fromRectangle:sprite.sourceRectangle tintWithColor:[Color white]
                         rotation:0 origin: sprite.origin scaleUniform:3 effects:[enemy.getOrientation isEqual:@"left"] ? SpriteEffectsFlipHorizontally : SpriteEffectsNone layerDepth:0];
                
            } else {
                // enemy standing still
                [spriteBatch draw:enemySprite.texture to:[Vector2 vectorWithX:enemyPos.x y: enemyPos.y] fromRectangle:enemySprite.sourceRectangle tintWithColor:[Color white] rotation:0 origin:enemySprite.origin scaleUniform:3 effects:[enemy.getOrientation isEqual:@"left"] ? SpriteEffectsFlipHorizontally : SpriteEffectsNone layerDepth:0 ];
            }
            
            
//            [spriteBatch draw:playerSprite.texture to:[Vector2 vectorWithX:enemyPos.x y: enemyPos.y] fromRectangle:enemySprite.sourceRectangle tintWithColor:[Color white] rotation:0 origin:enemySprite.origin scaleUniform:3 effects:[enemy.getOrientation isEqual:@"left"] ? SpriteEffectsFlipHorizontally : SpriteEffectsNone layerDepth:0 ];
        }
        
        // buttons
        if ([item isKindOfClass:[Button class]]) {
            Button *button = item;
            Rectangle *buttonPos = [Rectangle rectangleWithX:button.position.x + button.getArea.width / 2 + 16
                                                           y:button.position.y + button.getArea.height / 2 + 8
                                                       width:button.getArea.width
                                                      height:button.getArea.height];
            //NSLog(@"direction: %@", button.getDirection);
            if (!([button.getDirection isEqual: @"fire"] || [button.getDirection isEqual:@"attack"])){
            
//                [spriteBatch draw:buttonSprite.texture toRectangle:buttonPos fromRectangle:buttonSprite.sourceRectangle tintWithColor:button.isPressed ? [Color red] : [Color gray] rotation:0 origin:buttonSprite.origin effects:[button.getDirection isEqual: @"left"] ? SpriteEffectsFlipHorizontally : SpriteEffectsNone layerDepth:0 ];
                
                //if ([button.getDirection isEqual: @"left"]) {
                
                [spriteBatch draw:buttonSprite.texture to:[Vector2 vectorWithX:buttonPos.x y:buttonPos.y] fromRectangle:buttonSprite.sourceRectangle tintWithColor:button.isPressed ? [Color red] : [Color gray] rotation: [button.getDirection isEqual: @"jump"] ? -M_PI / 2 : 0 origin:buttonSprite.origin scaleUniform:2 effects:[button.getDirection isEqual: @"left"] ? SpriteEffectsFlipHorizontally : SpriteEffectsNone layerDepth:0];
                
//                    if(button.isPressed){
//                        NSLog(@"button drew on position: %d, %d", buttonPos.x, buttonPos.y);
//                        NSLog(@"button pos is: %f, %f", button.position.x, button.position.y);
//                    }
                //}
            
                // calculate spriteEffect for hero
                if (![button.getDirection isEqual:@"jump"])
                    lastStateSprite = button.isPressed ? ([button.getDirection isEqual: @"left"] ? SpriteEffectsFlipHorizontally : SpriteEffectsNone) :  lastStateSprite;
            } else {
                if ([button.getDirection isEqual:@"fire"]){
                    [spriteBatch draw:buttonFireBallSprite.texture to:[Vector2 vectorWithX:buttonPos.x y: buttonPos.y] fromRectangle:buttonFireBallSprite.sourceRectangle tintWithColor:button.isPressed ? [Color red] : [Color gray] rotation:-M_PI / 2 origin:buttonFireBallSprite.origin scaleUniform:2 effects:SpriteEffectsNone layerDepth:0 ];
                } else if ([button.getDirection isEqual:@"attack"]) {
                    [spriteBatch draw:buttonSwordAttackSprite.texture to:[Vector2 vectorWithX:buttonPos.x y: buttonPos.y] fromRectangle:buttonSwordAttackSprite.sourceRectangle tintWithColor:button.isPressed ? [Color red] : [Color gray] rotation:0 origin:buttonSwordAttackSprite.origin scaleUniform:2 effects:SpriteEffectsNone layerDepth:0 ];
                } else {
                    NSLog(@"hehe");
                }
            }
            
        }
        
        // fireball
        if ([item isKindOfClass:[FireBall class]]){
            FireBall *fireball = item;
            //NSLog(@"rendere: fireball pos: %f %f",fireball.position.x, fireball.position.y);
            
            Rectangle *fireballPos = [Rectangle rectangleWithX:fireball.position.x
                                                          y:fireball.position.y
                                                      width:fireballSprite.sourceRectangle.width
                                                     height:fireballSprite.sourceRectangle.height];
            [spriteBatch draw:fireballSprite.texture to:[Vector2 vectorWithX:fireballPos.x y: fireballPos.y] fromRectangle:fireballSprite.sourceRectangle tintWithColor:[Color white] rotation:0 origin:fireballSprite.origin scaleUniform:2 effects:lastStateSprite layerDepth:0 ];
        }
        
//        if ([item isKindOfClass:[ItemSword class]]) {
//            ItemSword *sword = item;
//            //NSLog(@"rendere: fireball pos: %f %f",fireball.position.x, fireball.position.y);
//            
//            Rectangle *swordPos = [Rectangle rectangleWithX:sword.position.x
//                                                             y:sword.position.y
//                                                         width:swordSprite.sourceRectangle.width
//                                                        height:swordSprite.sourceRectangle.height];
//            [spriteBatch draw:swordSprite.texture to:[Vector2 vectorWithX:swordPos.x y: swordPos.y] fromRectangle:swordSprite.sourceRectangle tintWithColor:[Color white] rotation:M_PI /4 + sword.rotationAngle origin:swordSprite.origin scaleUniform:1 effects:SpriteEffectsNone layerDepth:0 ];
//        }
        
    }
    
    [spriteBatch end];
}

- (void) unloadContent {
    [teksture release];
    [background release];
    [health_energy release];
    [teksture_ui release];
    [fireball_texture release];
    
    // Rotation of sprite
    [spriteBatch release];
    [enemySprite release];
    [playerSprite release];
    [potionSprite release];
    [menuSprite release];
    [buttonSprite release];
    [buttonFireBallSprite release];
    [buttonSwordAttackSprite release];
    [backgroundSprite release];

}

@synthesize camera;

- (void) dealloc
{
    [camera release];
    [super dealloc];
}

@end
