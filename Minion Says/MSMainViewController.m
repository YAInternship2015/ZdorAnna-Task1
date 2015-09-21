//
//  MSMainViewController.m
//  Minion Says
//
//  Created by anna on 8/31/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSMainViewController.h"
#import "MSContainerViewController.h"

static NSString *const MSEmbedContainer = @"MSEmbedContainer";

@interface MSMainViewController ()

@property (nonatomic, strong) MSContainerViewController *containerViewController;

@end

@implementation MSMainViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:MSEmbedContainer]) {
        self.containerViewController = segue.destinationViewController;
    }
}

#pragma mark - Actions

- (IBAction)actionChangeView:(UIBarButtonItem *)sender {
    [self.containerViewController changeController];
}


@end
