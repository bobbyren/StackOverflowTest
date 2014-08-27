//
//  MyTableViewController.m
//  Test
//
//  Created by Bobby Ren on 7/18/14.
//  Copyright (c) 2014 BobbyRen. All rights reserved.
//

#import "MyTableViewController.h"
#import "TestViewController.h"

@implementation MyTableViewController

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    TestViewController *controller = [[TestViewController alloc] init];
    controller.view.frame = CGRectMake(0, 0, 320, 40);
    [cell.contentView addSubview:controller.view];

    return cell;
}
@end
