//
//  PrimitiveBatch.h
//  Artificial I
//
//  Created by Matej Jan on 9.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Graphics.h"

@interface PrimitiveBatch : GraphicsResource {
	BlendState *blendState;
	DepthStencilState *depthStencilState;
	RasterizerState *rasterizerState;
	Effect *effect;
	Matrix *transformMatrix;
	
	BasicEffect *basicEffect;
	
	BOOL beginCalled;
	float pointSize;
	
	VertexPositionColorArray *vertexArray;
}

- (void) begin;

- (void) beginWithBlendState:(BlendState*)theBlendState;

- (void) beginWithBlendState:(BlendState*)theBlendState 
		 DepthStencilState:(DepthStencilState*)theDepthStencilState 
		   RasterizerState:(RasterizerState*)theRasterizerState;

- (void) beginWithBlendState:(BlendState*)theBlendState 
		 DepthStencilState:(DepthStencilState*)theDepthStencilState 
		   RasterizerState:(RasterizerState*)theRasterizerState 
					Effect:(Effect*)theEffect;

- (void) beginWithBlendState:(BlendState*)theBlendState 
		 DepthStencilState:(DepthStencilState*)theDepthStencilState 
		   RasterizerState:(RasterizerState*)theRasterizerState 
					Effect:(Effect*)theEffect 
		   TransformMatrix:(Matrix*)theTransformMatrix;

// 2D

- (void) drawPointAt:(Vector2*)position color:(Color*)color;
- (void) drawPointAt:(Vector2*)position color:(Color*)color layerDepth:(float)layerDepth;

- (void) drawLineFrom:(Vector2*)start to:(Vector2*)end color:(Color*)color;
- (void) drawLineFrom:(Vector2*)start to:(Vector2*)end color:(Color*)color layerDepth:(float)layerDepth;

- (void) drawCircleAt:(Vector2*)center radius:(float)radius divisions:(int)divisions color:(Color*)color; 
- (void) drawCircleAt:(Vector2*)center radius:(float)radius divisions:(int)divisions color:(Color*)color layerDepth:(float)layerDepth; 

- (void) drawRectangleAt:(Vector2*)center width:(float)width height:(float)height color:(Color*)color; 
- (void) drawRectangleAt:(Vector2*)center width:(float)width height:(float)height color:(Color*)color layerDepth:(float)layerDepth; 

- (void) drawRectangle:(Rectangle*)rectangle color:(Color*)color; 
- (void) drawRectangle:(Rectangle*)rectangle color:(Color*)color layerDepth:(float)layerDepth; 

// 3D

- (void) draw3DLineFrom:(Vector3*)start to:(Vector3*)end color:(Color*)color;


- (void) end;


@end
