//
//  MSContainerViewController.m
//  Minion Says
//
//  Created by anna on 8/26/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSContainerViewController.h"
//#import "MSCollectionViewController.h"
//#import "MSTableViewController.h"

@interface MSContainerViewController ()

@property (nonatomic, strong) UIViewController *collectionViewController;
@property (nonatomic, strong) UIViewController *tableViewController;
@property (nonatomic, assign) BOOL isTableVC;

@end

@implementation MSContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isTableVC = YES;
    
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MSTableViewControllerIdentifier"];
    [self displayViewController:self.tableViewController];
    
    NSLog(@"viewDidLoad");
}

#pragma mark - Methods

- (void) displayViewController: (UIViewController *)viewController{
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)changeFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController{
    
    toViewController.view.frame = [self frameForContentController];

    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:^(BOOL finished) {
                                [fromViewController removeFromParentViewController];
                                [toViewController didMoveToParentViewController:self];
                            }];
}

- (void) changeController {
    if (self.isTableVC) {
        self.collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:
                                         @"MSCollectionViewControllerIdentifier"];
        [self changeFromViewController:self.tableViewController toViewController:self.collectionViewController];
        self.isTableVC = NO;
    } else {
        self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:
                                    @"MSTableViewControllerIdentifier"];
        [self changeFromViewController:self.collectionViewController toViewController:self.tableViewController];
        self.isTableVC = YES;
    }
}

- (CGRect)frameForContentController {
    return self.view.bounds;
}

@end

