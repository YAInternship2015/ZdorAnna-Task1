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

@property (nonatomic, strong) MSCollectionViewController *collectionViewController;
@property (nonatomic, strong) MSTableViewController *tableViewController;
@property (nonatomic, assign) BOOL isTableVC;

@end

@implementation MSContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isTableVC = YES;
    
    self.collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:
                                     MSCollectionViewControllerIdentifier];
    
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:MSTableViewControllerIdentifier];
    [self displayViewController:self.tableViewController];
    
}

- (void) displayViewController: (UIViewController *)viewController{
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

#pragma mark - Methods

- (void)changeFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController{
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:0.6
                               options:UIViewAnimationOptionLayoutSubviews
                            animations:nil
                            completion:^(BOOL finished) {
                                [fromViewController removeFromParentViewController];
                                [toViewController didMoveToParentViewController:self];
                            }];
}

- (void) changeController {
    if (self.isTableVC) {
        [self changeFromViewController:self.tableViewController toViewController:self.collectionViewController];
        self.isTableVC = NO;
    } else {
        [self changeFromViewController:self.collectionViewController toViewController:self.tableViewController];
        self.isTableVC = YES;
    }
}

@end

