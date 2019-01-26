//
//  GuiRenderer.h
//  MedivialBattle
//
//  Created by David Zagorsek on 25/12/2018.
//

#import "Express.Scene.h"
#import "Namespace.Igra.classes.h"
#import "Artificial.Mirage.h"

@interface GuiRenderer : DrawableGameComponent {
    SpriteBatch *spriteBatch;
    Gameplay *gameplay;
    Matrix *camera;
    id<IScene> scene;
}

@property (nonatomic, readonly) Matrix *camera;

- (id) initWithGame:(Game*)theGame scene:(id<IScene>)theScene gameplay:(Gameplay *)theGameplay;

@end
