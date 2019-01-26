//
//  ICircle.h
//  Express
//
//  Created by Matej Jan on 10.1.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IParticle.h"
#import "IRotatable.h"

@protocol ICircle <IParticle, IRotatable, IAngularMass>

@end
