//
//  SceneAction.h
//  Express
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	SceneOperationAdd,
	SceneOperationRemove
} SceneOperation;

@interface SceneAction : NSObject
{
	SceneOperation operation;
	id item;
}

@property (nonatomic) SceneOperation operation;
@property (nonatomic, retain) id item;

+ (SceneAction*) actionWithOperation:(SceneOperation)theOperation item:(id)theItem;

@end
