//
//  GameHud.h
//  MedivialBattle
//
//  Created by David Zagorsek on 25/12/2018.
//


#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.Content.h"
#import "Artificial.Mirage.h"
#import "Express.Scene.h"
#import "Namespace.Igra.classes.h"

@interface GameHud : GameComponent {
    SimpleScene *scene; // scena
    Texture2D *healthBarTexture; // tekstura za healthbar
    Texture2D *energyBarTexture; // tekstura za energybar
    
    Texture2D *enemyHealthBarTexture; // tekstura za healthbar od enemya
    Texture2D *enemyEnergyBarTexture; // tekstura za energybar od enemya
    
    Label *playerDamage[2]; // damage, ki smo ga naredili
    Color *playerColor[2]; // kakšne barve naj bo damage
    float playerOpacity[2]; // ko bo opacity 0, se damage ne bo videl
}

@property (nonatomic, readonly) id<IScene> scene;
@property (nonatomic, retain) ButtonHud *healthBarButtonHud; // health bar button
@property (nonatomic, retain) ButtonHud *energyBarButtonHud; // energy bar button

@property (nonatomic, retain) ButtonHud *enemyHealthBarButtonHud; // health bar button od enemya
@property (nonatomic, retain) ButtonHud *enemeyEnergyBarButtonHud; // energy bar button od enemya

@property (nonatomic, retain) ButtonHud *finishMessage; // you either won(enemy died) or lost (you died) and that message is displayed then

@property (nonatomic, retain) Label *playerScore; // score of player
@property (nonatomic, retain) Label *time; // display total gameTime in seconds

- (void) resetGui; // doda gui na novo na sceno

@end
