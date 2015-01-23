//
//  OHGameOverScene.m
//  Horse Attack iPad
//
//  Created by Soren Peterson on 9/16/14.
//  Copyright (c) 2014 otterhive. All rights reserved.
//

#import "OHGameOverScene.h"
#import "OHTitleScene.h"
#import <AVFoundation/AVFoundation.h>

@interface OHGameOverScene ()

@property (nonatomic) AVAudioPlayer *backgroundMusic;

@end

@implementation OHGameOverScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"game_over"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"GameOverBackground" withExtension:@"m4a"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundMusic.numberOfLoops = -1;
        [self.backgroundMusic prepareToPlay];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    [self.backgroundMusic play];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.backgroundMusic stop];
    
    OHTitleScene *titleScene = [OHTitleScene sceneWithSize:self.frame.size];
    [self.view presentScene:titleScene];
}

@end
