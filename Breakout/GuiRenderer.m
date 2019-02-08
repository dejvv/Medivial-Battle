//
//  GuiRenderer.m
//  MedivialBattle
//
//  Created by David Zagorsek on 25/12/2018.
//

#import "GuiRenderer.h"
#import "Namespace.Igra.h"

@implementation GuiRenderer

@synthesize camera;

- (id) initWithGame:(Game*)theGame scene:(id<IScene>)theScene gameplay:(Gameplay *)theGameplay
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        scene = theScene;
        gameplay = theGameplay;
    }
    return self;
}

- (void) initialize {
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
    camera = [[Matrix createScale:[Vector3 vectorWithX:scaleX y:scaleY z:1]] retain];
    NSLog(@"[GuiRenderer] scalex: %f, scaley: %f", scaleX, scaleY);
    [super initialize];
}

- (void) loadContent {
    spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
}

- (void) drawWithGameTime:(GameTime *)gameTime {
//    NSLog(@"[guiRenderer] drawWithGameTime");
    [spriteBatch beginWithSortMode:SpriteSortModeDeffered
                        BlendState:nil
                      SamplerState:[SamplerState pointClamp]
                 DepthStencilState:nil
                   RasterizerState:nil
                            Effect:nil
                   TransformMatrix:camera];
    
    for (id item in scene) {
        Label *label = [item isKindOfClass:[Label class]] ? item : nil;
        Image *image = [item isKindOfClass:[Image class]] ? item : nil;
        
        if (label) {
//            NSLog(@"[guiRenderer] drawWithGameTime - LABEL");
            [spriteBatch drawStringWithSpriteFont:label.font text:label.text to:label.position tintWithColor:label.color
                                         rotation:label.rotation origin:label.origin scale:label.scale effects:SpriteEffectsNone layerDepth:label.layerDepth];
        }
        
        if (image) {
//            NSLog(@"[guiRenderer] drawWithGameTime - IMAGE");
            [spriteBatch draw:image.texture to:image.position fromRectangle:image.sourceRectangle tintWithColor:image.color
                     rotation:image.rotation origin:image.origin scale:image.scale effects:SpriteEffectsNone layerDepth:image.layerDepth];
        }
    }
    
    [spriteBatch end];
}

- (void) unloadContent {
    [spriteBatch release];
}

@end

