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
#warning не лучшее на имя переменной. Лучше уже isTableViewControllerVisible
@property (nonatomic, assign) BOOL isTableVC;

@end

@implementation MSContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isTableVC = YES;
    
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:MSTableViewControllerIdentifier];
    [self displayViewController:self.tableViewController];
}

#pragma mark - Methods

#warning - (void)displayViewController:(UIViewController *)viewController {
- (void) displayViewController: (UIViewController *)viewController{
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)changeFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController{
    
    toViewController.view.frame = [self frameForContentController];

    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
#warning цифры вроде длительности анимаций, высота, ширина, отступы и т.д. не должны появляться в коде. Надо объявлять локальные константы, либо прямо в начале метода, либо в классе. И этим контантам надо давать понятные названия. А Вашем случае нужно что-то вроде
//    static const NSTimeInterval kControllersSwitchingAnimationDuration = 0.3;
    
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

#warning лишний пробел в имени
- (void) changeController {
    if (self.isTableVC) {
        self.collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:
                                         MSCollectionViewControllerIdentifier];
        [self changeFromViewController:self.tableViewController toViewController:self.collectionViewController];
        self.isTableVC = NO;
    } else {
        self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:
                                    MSTableViewControllerIdentifier];
        [self changeFromViewController:self.collectionViewController toViewController:self.tableViewController];
        self.isTableVC = YES;
    }
}

- (CGRect)frameForContentController {
    return self.view.bounds;
}

@end

