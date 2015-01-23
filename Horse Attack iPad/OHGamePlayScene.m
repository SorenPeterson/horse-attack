//
//  OHGamePlayScene.m
//  Horse Attack iPad
//
//  Created by otter on 8/14/14.
//  Copyright (c) 2014 otterhive. All rights reserved.
//

#import "OHGamePlayScene.h"
#import "OHGameOverScene.h"
#import "OHHorseNode.h"
#import <AVFoundation/AVFoundation.h>

@interface OHGamePlayScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval totalGameTime;

@property (nonatomic) NSTimeInterval timeSinceHorseAdded;
@property (nonatomic) NSTimeInterval timeSinceDifficultyUpdated;
@property (nonatomic) NSTimeInterval addHorseTimeInterval;

@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger horsesOnScreen;
@property (nonatomic) NSInteger gameWasLost;

@property (nonatomic) SKLabelNode *scoreDisplay;

@property (nonatomic) AVAudioPlayer *backgroundMusic;

@end

@implementation OHGamePlayScene

-(id)initWithSize:(CGSize)size {
    if(self = [super initWithSize:size]) {
        self.totalGameTime = 0;
        self.addHorseTimeInterval = 1.5;
        
        self.horsesOnScreen = 0;
        self.score = 0;
        self.gameWasLost = NO;
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"GamePlayBackground" withExtension:@"m4a"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundMusic.numberOfLoops = 1;
        [self.backgroundMusic prepareToPlay];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    self.scoreDisplay = [SKLabelNode labelNodeWithFontNamed:@"TimesNewRoman"];
    self.scoreDisplay.text = @"0";
    self.scoreDisplay.fontSize = 300;
    self.scoreDisplay.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-150                                                                                                                                                                                                                                                                                                      );
    [self addChild:self.scoreDisplay];
    
    [self.backgroundMusic play];
}

-(void)addHorse {
    self.horsesOnScreen += 1;
    
    OHHorseNode *horse = [OHHorseNode horseAtPosition:CGPointMake(arc4random_uniform(self.frame.size.width),
                                                                  arc4random_uniform(self.frame.size.height))];
    [self addChild:horse];
    [horse moveRandomly];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
    for (SKNode *node in nodes) {
        if([node.name isEqualToString:@"Horse"]) {
            [node removeFromParent];
            self.horsesOnScreen -= 1;
            self.score += 1;
            return;
        }
    }
    [self addHorse];
}

-(void)update:(NSTimeInterval)currentTime {
    if(self.lastUpdateTimeInterval) {
        self.timeSinceHorseAdded += currentTime - self.lastUpdateTimeInterval;
        self.timeSinceDifficultyUpdated += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
    if(self.timeSinceHorseAdded > self.addHorseTimeInterval) {
        [self addHorse];
        [self addHorse];
        [self addHorse];
        self.timeSinceHorseAdded = 0;
    }
    
    if(self.timeSinceDifficultyUpdated > 2) {
        self.addHorseTimeInterval *= 0.975;
        self.timeSinceDifficultyUpdated = 0;
    }
    
    if (self.totalGameTime > 70 && self.horsesOnScreen < self.totalGameTime - 70) {
        self.addHorseTimeInterval = 0.1;
    } else if (self.totalGameTime > 70) {
        self.addHorseTimeInterval = 1.0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if(self.horsesOnScreen > 40) {
        if (!self.gameWasLost) {
            [self.backgroundMusic stop];
            
            self.gameWasLost = YES;
            
            OHGameOverScene *gameOverScene = [OHGameOverScene sceneWithSize:self.frame.size];
            SKTransition *mytransition = [SKTransition doorsCloseHorizontalWithDuration:2.0];
            [self.view presentScene:gameOverScene transition:mytransition];
        }
    }
    
    self.scoreDisplay.text = [NSString stringWithFormat:@"%li", (long)self.score];
}

@end
