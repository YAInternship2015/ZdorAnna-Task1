//
//  MSContainerViewController.m
//  Minion Says
//
//  Created by anna on 8/26/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSContainerViewController.h"
#import "MSCollectionViewController.h"
#import "MSTableViewController.h"

@interface MSContainerViewController ()

@property (nonatomic, strong) UIViewController *collectionViewController;
@property (nonatomic, strong) UIViewController *tableViewController;
@property (nonatomic, assign) BOOL isTableViewControllerVisible;

@end

@implementation MSContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isTableViewControllerVisible = YES;
    
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:MSTableViewControllerIdentifier];
    [self displayViewController:self.tableViewController];
}

#pragma mark - Methods

- (void) displayViewController:(UIViewController *)viewController {
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)changeFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController{
    
    toViewController.view.frame = [self frameForContentController];

    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    static const NSTimeInterval kControllersSwitchingAnimationDuration = 0.3;
    
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:kControllersSwitchingAnimationDuration
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:^(BOOL finished) {
                                [fromViewController removeFromParentViewController];
                                [toViewController didMoveToParentViewController:self];
                            }];
}

- (void)changeController {
    if (self.isTableViewControllerVisible) {
        self.collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:
                                         MSCollectionViewControllerIdentifier];
        [self changeFromViewController:self.tableViewController toViewController:self.collectionViewController];
        self.isTableViewControllerVisible = NO;
    } else {
        self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:
                                    MSTableViewControllerIdentifier];
        [self changeFromViewController:self.collectionViewController toViewController:self.tableViewController];
        self.isTableViewControllerVisible = YES;
    }
}

- (CGRect)frameForContentController {
    return self.view.bounds;
}

@end

