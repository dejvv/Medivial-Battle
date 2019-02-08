//
//  GameProgress.m
//  MedivialBattle
//
//  Created by David Zagorsek on 28/01/2019.
//

#import "GameProgress.h"

#import "Namespace.Igra.h"

@implementation GameProgress

- (id) init
{
    self = [super init];
    if (self != nil) {
        // Unlock first opponent and level type.
//        opponentUnlocked[OpponentTypeIceman] = YES;
//        levelUnlocked[LevelTypeHockey] = YES;
    }
    return self;
}

//+ (GameProgress *) loadProgress {
//    // Load game progress from file.
//    GameProgress *progress = nil;
//    
//    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *archivePath = [rootPath stringByAppendingPathComponent:[Constants getInstance].progressFilePath];
//    progress = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
//    
//    // If there is no progress file, create a fresh instance.
//    if (!progress) {
//        progress = [[[GameProgress alloc] init] autorelease];
//    }
//    
//    NSLog(@"Progress retain count: %d", [progress retainCount]);
//    
//    return progress;
//}

+ (NSMutableDictionary *) getProgress {
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *archivePath = [rootPath stringByAppendingPathComponent:[Constants getInstance].progressFilePath];
    NSMutableDictionary *loadedScores = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    
    return loadedScores;
}

+ (void) deleteProgress {
    // Delete game progress file.
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *archivePath = [rootPath stringByAppendingPathComponent:[Constants getInstance].progressFilePath];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:archivePath error:&error];
}

+ (void) saveProgress:(int)score time:(int)theTime {
    NSString *scoreString = [NSString stringWithFormat:@"%d", (int) score];
    NSString *timeString = [NSString stringWithFormat:@"%d", (int) theTime];
    
    // naredi array ki hrani score in time
    NSArray *results = [NSArray arrayWithObjects: scoreString, timeString, nil];
    // slovar, ključ: unique, vrednost: array
    NSMutableDictionary *scores = [[[NSMutableDictionary alloc] init] autorelease];
    
    // nastavim unique ID - timestamp in ga dam v string
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    // NSTimeInterval is defined as double
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    NSString *uniqueKey = [NSString stringWithFormat:@"%d", (int) timeStampObj];
    
    // najprej dodaj obstoječi progress
    NSMutableDictionary* existingProgress = [self getProgress];
    for(id key in existingProgress){
        NSLog(@"[saveProgress] OBSTOJEČI: key=%@ value=%@", key, [existingProgress objectForKey:key]);
        [scores setObject:[existingProgress objectForKey:key] forKey:key];
    }
    
    NSLog(@"GameProgress [saveProgress] uniqueKey: %@!", uniqueKey);
    // dodaj trenutni score
    [scores setObject:results forKey:uniqueKey];
    
    // Save game progress to file.
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *archivePath = [rootPath stringByAppendingPathComponent:[Constants getInstance].progressFilePath];
    [NSKeyedArchiver archiveRootObject:scores toFile:archivePath]; // shrani
    
    NSLog(@"GameProgress [saveProgress] saved!");
}

@end
