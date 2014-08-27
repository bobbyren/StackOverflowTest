//
//  TutorialView.m
//  Test
//
//  Created by Bobby Ren on 8/19/14.
//  Copyright (c) 2014 BobbyRen. All rights reserved.
//

#import "TutorialView.h"

@implementation TutorialView

- (id)initWithFrame:(CGRect)frame andPage:(int) page
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"TutorialView" owner:self options:nil] objectAtIndex:0];
        view.frame = self.frame;
        [self addSubview:view];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
