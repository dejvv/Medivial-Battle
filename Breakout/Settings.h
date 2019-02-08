//
//  Settings.h
//  MedivialBattle
//
//  Created by David Zagorsek on 26/01/2019.
//

#import <Foundation/Foundation.h>

#import "Menu.h"

@interface Settings : Menu {
    Label *title;
    NSMutableDictionary* scores;
}

- (void) loadScores;
- (Label*) createLabelText: (NSString*) text coord_x: (int)x coord_y: (int)y;

@end
