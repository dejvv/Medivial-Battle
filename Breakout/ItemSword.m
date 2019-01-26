//
//  ItemSword.m
//  MedivialBattle
//
//  Created by David Zagorsek on 12/12/2018.
//

#import "ItemSword.h"
#import "Namespace.Igra.h"

@implementation ItemSword

- (id) initWithCharacter:(Character *)theCharacter {
    self = [super self];
    if (self != nil) {
        character = theCharacter;
        damagePower = 10;
        position = [[Vector2 alloc] initWithVector2:character.position];
        //height = 64;
        //width = 16;
        matrixStruct = MatrixMake(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
       // rotation = [[Matrix createRotationX:0.7853982] retain];
        rotation = [[Matrix alloc] initWithMatrixStruct:&matrixStruct];
        velocity = [[Vector2 alloc] init];
        radius = 64;
        mass = 0.0001;
        
//        v1 = [[Vector2 alloc] initWithX:position.x y:position.y] ;
//        v2 = [[Vector2 alloc] initWithX:position.x + width y:position.y] ;
//        v3 = [[Vector2 alloc] initWithX:position.x y:position.y + height];
//        v4 = [[Vector2 alloc] initWithX:position.x + width y:position.y + height] ;
        detectCollision = NO; // ne računaj kolizije na začetku
        energyPenalty = 2.0; // na začetku je penalty 1, kar pomeni da se upošteva samo cena iz [Constants].costEnergySwordAttack
    }
    return self;
}

@synthesize angularVelocity;
@synthesize rotationAngle;
//@synthesize velocity;
@synthesize position;
@synthesize scene;
//@synthesize height;
//@synthesize width;
@synthesize detectCollision;
@synthesize energyPenalty;
@synthesize velocity;
@synthesize radius;
@synthesize mass;


- (bool) collidingWithItem:(id)item {
    if ( !detectCollision )
        return NO;
    
    if ( [item isEqual:character] ){
        //NSLog(@"ola hero");
        return NO;
    }
    
    return [item isKindOfClass:[Character class]];
    
}

- (void) collidedWithItem:(id)item {
    if (![item isKindOfClass:[Character class]])
        return;
    
}

- (int) getDamagePower {
    return damagePower;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
//    if (rotationAngle >= 6.28318531)
//        rotationAngle = 0;
//    angularVelocity = 10.0;
    [self.position setX:character.position.x + ([character.getOrientation isEqual:@"left"] ? -character.width / 2 : character.width / 2)];
    [self.position setY:character.position.y];
    //NSLog(@"[itemsword] position: [%f, %f], %f ", self.position.x, self.position.y, rotationAngle);
//    NSLog(@"[itemsword] char pos: [%f, %f]", character.position.x, character.position.y);
    //NSLog(@"[itemsword] angularVelocity and rotationAngle: [%f, %f]", self.angularVelocity, self.rotationAngle);
    
    
//    Vector2 v1 = new Vector2(x,y);
//    Vector2 v2 = new Vector2(x+width,y);
//    Vector2 v3 = new Vector2(x,y+height);
//    Vector2 v4 = new Vector2(x+width,y+height);
    //    v = Vector2.Transform(v, Matrix.CreateRotationZ(MathHelper.ToRadians(30)));//rotates 30 degrees
//    NSLog(@"before");
//    NSLog(@"[itemsword] V1:position: [%f, %f] ", v1.x, v1.y);
//    NSLog(@"[itemsword] V2:position: [%f, %f] ", v2.x, v2.y);
//    NSLog(@"[itemsword] V3:position: [%f, %f] ", v3.x, v3.y);
//    NSLog(@"[itemsword] V4:position: [%f, %f] ", v4.x, v4.y);
//    
//    v1 = [v1 transformWith:[Matrix createRotationZ:rotationAngle]];
//    v2 = [v2 transformWith:[Matrix createRotationZ:rotationAngle]];
//    v3 = [v3 transformWith:[Matrix createRotationZ:rotationAngle]];
//    v4 = [v4 transformWith:[Matrix createRotationZ:rotationAngle]];
    
//    NSLog(@"after");
//
//    NSLog(@"[itemsword] V1:position: [%f, %f] ", v1.x, v1.y);
//    NSLog(@"[itemsword] V2:position: [%f, %f] ", v2.x, v2.y);
//    NSLog(@"[itemsword] V3:position: [%f, %f] ", v3.x, v3.y);
//    NSLog(@"[itemsword] V4:position: [%f, %f] ", v4.x, v4.y);
    
    
    //Vector2 *direction = [[[Vector2 unitX] transformWith:[Matrix createRotationZ:rotationAngle]] multiplyBy:5];
    //NSLog(@"direction: [%f, %f]", direction.x, direction.y);
   
    //[Vector2 add:di to:direction];
    //[position add:direction];
    
    
    
}



- (void) dealloc {
    [v1 release];
    [v2 release];
    [v3 release];
    [v4 release];
    [character release];
    [scene release];
    [velocity release];
    [position release];
    [super dealloc];
}

@end
