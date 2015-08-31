//
//  MSMainViewController.m
//  Minion Says
//
//  Created by anna on 8/27/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSMainViewController.h"
#import "MSContainerViewController.h"

@interface MSMainViewController ()

@property (nonatomic, weak) MSContainerViewController *containerViewController;

@end

@implementation MSMainViewController

#pragma mark - Actions

- (IBAction)actionViewChanged:(id)sender {
    [self.containerViewController changeViewController];
}

@end
