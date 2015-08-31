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
#import "MSMainViewController.h"

@interface MSContainerViewController ()

@property (nonatomic, strong) MSCollectionViewController *collectionViewController;
@property (nonatomic, strong) MSTableViewController *tableViewController;
@property (nonatomic, assign) BOOL isCollectionView;

@end

@implementation MSContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isCollectionView = NO;
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableControllerID"];
    self.collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionControllerID"];
    
    [self displayViewController:self.tableViewController];
}

#pragma mark - Methods

-(void)displayViewController:(UIViewController* )newViewController{
    [self addChildViewController:newViewController];
    [self.view addSubview:newViewController.view];
    [newViewController didMoveToParentViewController:self];
}


- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:0.25
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
    }];
}

- (void)changeViewController{
    if (!self.isCollectionView) {
        [self swapFromViewController:self.tableViewController toViewController:self.collectionViewController];
        self.isCollectionView = YES;
    } else {
        [self swapFromViewController:self.collectionViewController toViewController:self.tableViewController];
        self.isCollectionView = NO;
    }
}

@end

