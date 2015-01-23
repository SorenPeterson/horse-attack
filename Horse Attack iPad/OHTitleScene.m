//
//  OHTitleScene.m
//  Horse Attack iPad
//
//  Created by otter on 8/14/14.
//  Copyright (c) 2014 otterhive. All rights reserved.
//

#import "OHTitleScene.h"
#import "OHGamePlayScene.h"
#import <AVFoundation/AVFoundation.h>

@interface OHTitleScene ()

@property (nonatomic) AVAudioPlayer *backgroundMusic;

@end

@implementation OHTitleScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"TitleBackground" withExtension:@"m4a"];
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
    
    OHGamePlayScene *gamePlayScene = [OHGamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition doorsOpenHorizontalWithDuration:1.0];
    [self.view presentScene:gamePlayScene transition:transition];
}

@end
