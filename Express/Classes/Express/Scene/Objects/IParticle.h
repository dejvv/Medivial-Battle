//
//  IParticle.h
//  Express
//
//  Created by Matej Jan on 2.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IMovable.h"
#import "IMass.h"
#import "IParticleCollider.h"

@protocol IParticle <IMovable, IMass, IParticleCollider>

@end
