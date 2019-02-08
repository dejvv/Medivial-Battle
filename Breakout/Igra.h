//
//  Igra.h
//  Igra
//
//  Created by David Zagorsek on 10/10/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Namespace.Igra.classes.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Audio.h"

@interface Igra : Game {
    GraphicsDeviceManager *graphics;
    
    // Game state
    NSMutableArray *stateStack;
}

- (void) pushState:(GameState*)gameState;
- (void) popState;

@end
