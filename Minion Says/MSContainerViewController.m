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
    
    self.collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:
                                     MSCollectionViewControllerIdentifier];
    
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:MSTableViewControllerIdentifier];
    
}

@end
