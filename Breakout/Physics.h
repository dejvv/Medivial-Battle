//
//  Physics.h
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import <Foundation/Foundation.h>

#import "Namespace.Igra.classes.h"

@interface Physics : GameComponent {
    Level *level;
}

- (id) initWithGame:(Game*)theGame level:(Level*)theLevel;

@end

