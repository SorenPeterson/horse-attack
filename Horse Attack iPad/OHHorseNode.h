//
//  OHHorseNode.h
//  Horse Attack iPad
//
//  Created by otter on 8/14/14.
//  Copyright (c) 2014 otterhive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface OHHorseNode : SKSpriteNode

+(instancetype)horseAtPosition:(CGPoint)position;

-(void)moveRandomly;

@end
