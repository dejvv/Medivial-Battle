//
//  main.m
//  Igra
//
//  Created by David Zagorsek on 10/10/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Retronator.Xni.Framework.h"

int main(int argc, char *argv[]) {
    [GameHost load];
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, @"GameHost", @"Igra");
    [pool release];
    return retVal;
}
