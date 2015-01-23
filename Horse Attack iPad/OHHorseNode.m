//
//  OHHorseNode.m
//  Horse Attack iPad
//
//  Created by otter on 8/14/14.
//  Copyright (c) 2014 otterhive. All rights reserved.
//

#import "OHHorseNode.h"

@implementation OHHorseNode

+(instancetype)horseAtPosition:(CGPoint)position {
    OHHorseNode *horse = [OHHorseNode spriteNodeWithImageNamed:@"horse_1"];
    horse.position = position;
    horse.name = @"Horse";
    
    NSArray *horseAnimationTextures = @[[SKTexture textureWithImageNamed:@"horse_1"],
                          [SKTexture textureWithImageNamed:@"horse_2"],
                          [SKTexture textureWithImageNamed:@"horse_3"],
                          [SKTexture textureWithImageNamed:@"horse_4"],
                          [SKTexture textureWithImageNamed:@"horse_5"],
                          [SKTexture textureWithImageNamed:@"horse_6"]];
    SKAction *horseAnimation = [SKAction animateWithTextures:horseAnimationTextures timePerFrame:0.1];
    SKAction *horseAnimationRepeat = [SKAction repeatActionForever:horseAnimation];
    [horse runAction:horseAnimationRepeat];
    
    return horse;
}

-(void)moveRandomly {
    CGPoint destination = CGPointMake(arc4random_uniform(self.parent.frame.size.width), arc4random_uniform(self.parent.frame.size.height));
    double distance = sqrt(pow((destination.x - self.position.x), 2.0) + pow((destination.y - self.position.y), 2.0));
    float moveDuration = 0.005 * distance;
    SKAction *moveToRandomPosition = [SKAction moveTo:destination duration:moveDuration];
    [self runAction:moveToRandomPosition completion:^(void){[self moveRandomly];}];
}

@end
