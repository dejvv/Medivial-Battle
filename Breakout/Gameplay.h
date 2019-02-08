//
//  Gameplay.h
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import <Foundation/Foundation.h>
#import "Express.Graphics.h"
#import "Namespace.Igra.classes.h"
#import "GameState.h"

@interface Gameplay : GameState {
    Level *level; // level, ima sceno na kateri so objekti
    GameHud *gameHud; // scena na kateri je UI, torej gumbi, menuji
    HumanPlayer *playerHuman; // igralec
    EnemyPlayer *playerEnemy; // ai
    Physics *physics; // fizika
    Renderer *renderer; // renderer, se sprehodi po level.scene in izriše objekte
    GuiRenderer *guiRenderer; // renderer za UI, izriše gumbe, menuje in vse ostalo
    DebugRenderer *debugRenderer; // za debugirat, da vidim kje so objekti
    
    // stateful agent
    ReflexEnemy *playerEnemyReflex;
    
    int difficultyLevel; // težavnost
    BOOL gameplayShouldFinish; // zastavica ko se gameplay mora končat
    
    NSTimeInterval timePlaying; // čas kako dolgo igralec igra
    NSTimeInterval stopGameplay; // konec, igra končana, gameplay se naj konča po recimo 3s
}

@property (nonatomic) float score; // playerjev score
@property (nonatomic, readonly) Level *level;

- (void) reset;

// metoda naračuna kakšne koordinate po y osi za health in energy bar moram uporabiti, da bo se prikazal pravilen source rectangle
- (int) calculateSourceRectangle: (int) number max: (int) maxNumber;
- (float) calculateScoreOfPlayer:(GameTime *)time;

@end
