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
        
        [self.components addComponent:[[[Gameplay alloc] initWithGame:self] autorelease]];
        [self.components addComponent:[[[FpsComponent alloc] initWithGame:self] autorelease]];
        [self.components addComponent:[[[TouchPanelHelper alloc] initWithGame:self] autorelease]];
        [SoundEngine initializeWithGame:self];
    }
    return self;
}

- (void) dealloc
{
    [graphics release];
    [super dealloc];
}

@end
