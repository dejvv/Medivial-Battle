//
//  DebugRenderer.h
//  Express
//
//  Created by Matej Jan on 9.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Graphics.h"
#import "Artificial.Spectrum.h"

#import "Express.Scene.classes.h"

@interface DebugRenderer : DrawableGameComponent {
	id<IScene> scene;
	
	PrimitiveBatch *primitiveBatch;
	
	Color *itemColor;
	Color *movementColor;
	Color *colliderColor;
	
	BlendState *blendState;
	DepthStencilState *depthStencilState;
	RasterizerState *rasterizerState;
	Effect *effect;
	Matrix *transformMatrix;
}

- (id) initWithGame:(Game*)theGame scene:(id<IScene>)theScene;

@property (nonatomic, retain) Color *itemColor;
@property (nonatomic, retain) Color *movementColor;
@property (nonatomic, retain) Color *colliderColor;

@property (nonatomic, retain) BlendState *blendState;
@property (nonatomic, retain) DepthStencilState *depthStencilState;
@property (nonatomic, retain) RasterizerState *rasterizerState;
@property (nonatomic, retain) Effect *effect;
@property (nonatomic, retain) Matrix *transformMatrix;

@end
