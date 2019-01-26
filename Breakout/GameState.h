//
//  GameState.h
//  MedivialBattle
//
//  Created by David Zagorsek on 26/01/2019.
//

#import <Foundation/Foundation.h>

#import "Namespace.Igra.classes.h"

@interface GameState : GameComponent {
    Igra *igra;
}

- (void) activate;
- (void) deactivate;

@end

