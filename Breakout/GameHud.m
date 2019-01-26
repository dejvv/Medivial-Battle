//
//  GameHud.m
//  MedivialBattle
//
//  Created by David Zagorsek on 25/12/2018.
//

#import "GameHud.h"

#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.Pipeline.Processors.h"
#import "Namespace.Igra.h"


@implementation GameHud

- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        scene = [[SimpleScene alloc] initWithGame:self.game];
        [self.game.components addComponent:scene];
    }
    return self;
}

@synthesize scene, healthBarButtonHud, energyBarButtonHud, enemyHealthBarButtonHud, enemeyEnergyBarButtonHud, finishMessage;

- (void) initialize {
    FontTextureProcessor *fontProcessor = [[[FontTextureProcessor alloc] init] autorelease];
    SpriteFont *font = [[self.game.content load:@"5x5" processor:fontProcessor] autorelease];
    
    // for hero
    healthBarTexture = [self.game.content load:@"health_bar"];
    healthBarButtonHud = [[ButtonHud alloc] initWithInputArea:[[Rectangle rectangleWithX:20 y:20 width:128 height:16] retain] background:healthBarTexture font:font text:@""];
    
    energyBarTexture = [self.game.content load:@"energy_bar"];
    energyBarButtonHud = [[ButtonHud alloc] initWithInputArea:[[Rectangle rectangleWithX:20 y:60 width:128 height:16] retain] background:energyBarTexture font:font text:@""];
    
    // for enemy
    enemyHealthBarTexture = [self.game.content load:@"enemy_health_bar"];
    enemyHealthBarButtonHud = [[ButtonHud alloc] initWithInputArea:[[Rectangle rectangleWithX: 724 y:20 width:128 height:16] retain] background:enemyHealthBarTexture font:font text:@""];
    
    //enemyEnergyBarTexture = [self.game.content load:@"energy_bar"];
    enemeyEnergyBarButtonHud = [[ButtonHud alloc] initWithInputArea:[[Rectangle rectangleWithX: 724 y:60 width:128 height:16] retain] background:energyBarTexture font:font text:@""];
    
    // won/lost message
    finishMessage = [[ButtonHud alloc] initWithInputArea:[[Rectangle rectangleWithX: 280 y:180 width:100 height:100] retain] background:nil font:font text:@""];
    [finishMessage setLabelColor:[Color white]];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    //NSLog(@"[gamehud] updatewithgame time works");
    for (id item in scene) {
        id<ICustomUpdate> updatable = [item conformsToProtocol:@protocol(ICustomUpdate)] ? item : nil;
        
        if (updatable) {
            [updatable updateWithGameTime:gameTime];
        }
    }
}

- (void) resetGui {
    NSLog(@"[GameHud resetGui] called");
    // Remove everything from the scene.
    [scene clear];
    // dodaj healthbar na sceno
    //[healthBarButtonHud addedToScene:scene];
    [scene addItem:healthBarButtonHud];
    [scene addItem:energyBarButtonHud];
    [scene addItem:enemyHealthBarButtonHud];
    [scene addItem:enemeyEnergyBarButtonHud];
    [scene addItem:finishMessage];
}

- (void) dealloc {
    [healthBarButtonHud release];
    [energyBarButtonHud release];
    [healthBarTexture release];
    [energyBarTexture release];
    
    [enemyHealthBarButtonHud release];
    [enemeyEnergyBarButtonHud release];
    [enemyHealthBarTexture release];
    [enemyEnergyBarTexture release];
    
    [finishMessage release];
    [super dealloc];
}


@end

