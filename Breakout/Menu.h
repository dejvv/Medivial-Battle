//
//  Menu.h
//  MedivialBattle
//
//  Created by David Zagorsek on 26/01/2019.
//

#import <Foundation/Foundation.h>

#import "Artificial.Mirage.h"

#import "Express.Scene.h"

#import "Namespace.Igra.classes.h"

#import "GameState.h"

@interface Menu : GameState {
    SimpleScene *scene;
    GuiRenderer *renderer;
    
    SpriteFont *fivexfive;
    Texture2D *buttonBackground;
    
    ButtonHud *back;
}

@end
