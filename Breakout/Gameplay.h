//
//  Gameplay.h
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import <Foundation/Foundation.h>
#import "Express.Graphics.h"
#import "Namespace.Igra.classes.h"

@interface Gameplay : GameComponent {
    Level *level; // level, ima sceno na kateri so objekti
    GameHud *gameHud; // scena na kateri je UI, torej gumbi, menuji
    HumanPlayer *playerHuman; // igralec
    EnemyPlayer *playerEnemy; // ai
    Physics *physics; // fizika
    Renderer *renderer; // renderer, se sprehodi po level.scene in izriše objekte
    GuiRenderer *guiRenderer; // renderer za UI, izriše gumbe, menuje in vse ostalo
    DebugRenderer *debugRenderer; // za debugirat, da vidim kje so objekti
    
    int difficultyLevel; // težavnost 
}

@property (nonatomic, readonly) Level *level;

- (void) reset;

// metoda naračuna kakšne koordinate po y osi za health in energy bar moram uporabiti, da bo se prikazal pravilen source rectangle
- (int) calculateSourceRectangle: (int) number max: (int) maxNumber;

@end
