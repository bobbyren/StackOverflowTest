//
//  TestViewController.m
//  Test
//
//  Created by Bobby Ren on 7/18/14.
//  Copyright (c) 2014 BobbyRen. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.text = @"test";
}

-(void)dealloc {
    NSLog(@"logged");
}
@end
