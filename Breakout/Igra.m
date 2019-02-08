//
//  Igra.m
//  Igra
//
//  Created by David Zagorsek on 10/10/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import "Igra.h"
#import "Namespace.Igra.h"
#import "Artificial.Control.h"

// implementacija razreda Igra, ki je definiran v definicijski datoteki Igra.h
@implementation Igra
- (id) init
{
    self = [super init];
    if (self != nil) {
        graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
        graphics.preferredBackBufferWidth = self.gameWindow.clientBounds.width;
        graphics.preferredBackBufferHeight = self.gameWindow.clientBounds.height;
        graphics.isFullScreen = YES;
        
//        [self.components addComponent:[[[Gameplay alloc] initWithGame:self] autorelease]];
        [self.components addComponent:[[[FpsComponent alloc] initWithGame:self] autorelease]];
        [self.components addComponent:[[[TouchPanelHelper alloc] initWithGame:self] autorelease]];
        [SoundEngine initializeWithGame:self];
        stateStack = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) initialize {
    
    // Start in main menu.
    MainMenu *mainMenu = [[[MainMenu alloc] initWithGame:self] autorelease];
    [self pushState:mainMenu];
    
    
    //Debug start in gameplay
//         Gameplay *gameplay = [[[Gameplay alloc] initSinglePlayerWithGame:self
//     levelClass:[HockeyLevel class]
//     aiClass:[Iceman class]] autorelease];
//     [self pushState:gameplay];
//    Gameplay *gameplay = [[[Gameplay alloc] initWithGame:self] autorelease];
//    [self pushState:gameplay];
    
    
    // Initialize all components.
    [super initialize];
}

- (void) pushState:(GameState *)gameState {
    NSLog(@"[Igra pushState] push %@", gameState);
    GameState *currentActiveState = [stateStack lastObject];
    [currentActiveState deactivate];
    [self.components removeComponent:currentActiveState];
    
    [stateStack addObject:gameState];
    [self.components addComponent:gameState];
    [gameState activate];
}

- (void) popState {
    
    GameState *currentActiveState = [stateStack lastObject];
    NSLog(@"[Igra popState] pop %@", currentActiveState);
    [stateStack removeLastObject];
    [currentActiveState deactivate];
    [self.components removeComponent:currentActiveState];
    
    currentActiveState = [stateStack lastObject];
    [self.components addComponent:currentActiveState];
    [currentActiveState activate];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
}

- (void) drawWithGameTime:(GameTime *)gameTime {
    [self.graphicsDevice clearWithColor:[Color black]];
    [super drawWithGameTime:gameTime];
}

- (void) dealloc
{
    [graphics release];
    [stateStack release];
    [super dealloc];
}

@end
