//
//  MSCollectionViewController.m
//  Minion Says
//
//  Created by anna on 8/26/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSCollectionViewController.h"
#import "MSContent.h"
#import "MSCollectionViewCell.h"
#import "MSContentManager.h"

NSString *const MSCollectionViewControllerIdentifier = @"MSCollectionViewControllerIdentifier";

@interface MSCollectionViewController () <UICollectionViewDataSource, MSModelsDataSourceDelegate>

@property (nonatomic, strong) MSContentManager *allContent;

@end

@implementation MSCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allContent = [[MSContentManager alloc] initWithDelegate:self];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.allContent contentCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MSCollectionCellIdentifier
                                                                           forIndexPath:indexPath];
    
    [cell setContent:[self.allContent contentAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - MSModelsDataSourceDelegate

- (void)dataWasChanged:(MSContentManager *)data{
    [self.collectionView reloadData];
}

@end
