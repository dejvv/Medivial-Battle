//
//  GameProgress.h
//  MedivialBattle
//
//  Created by David Zagorsek on 28/01/2019.
//

#import <Foundation/Foundation.h>

#import "Namespace.Igra.classes.h"

@interface GameProgress : NSObject {
//    BOOL opponentUnlocked[OpponentTypes];
}

//+ (GameProgress *) loadProgress;
+ (void) deleteProgress;
+ (void) saveProgress:(int)score time:(int)theTime;
+ (NSMutableDictionary *) getProgress;

//- (BOOL) isLevelUnlocked:(LevelType)type;
//- (BOOL) isOpponentUnlocked:(OpponentType)type;

@end
