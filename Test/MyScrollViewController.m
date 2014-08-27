//
//  MyScrollViewController.m
//  Test
//
//  Created by Bobby Ren on 8/19/14.
//  Copyright (c) 2014 BobbyRen. All rights reserved.
//

#import "MyScrollViewController.h"
#import "TutorialView.h"

@interface MyScrollViewController ()

@end

@implementation MyScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{

    NSLog(@"tutorial view loaded");
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height);

    for (int i = 0 ; i < 2 ; i++) {

        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;

        UIView *subview = [[TutorialView alloc] initWithFrame:frame andPage:i];
        [subview setNeedsUpdateConstraints];
        [subview layoutIfNeeded];

        [self.scrollView addSubview:subview];
        
    }

    [self.view layoutSubviews];
}

-(void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];


}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
