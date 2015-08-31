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

@interface MSCollectionViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) MSContentManager *allContent;

@end

@implementation MSCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allContent = [MSContentManager managerWithSetOfContent];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.allContent contentCount];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MSCollectionViewCellIdentifier
                                                                           forIndexPath:indexPath];
    
    [cell setContent:[self.allContent contentAtIndex:indexPath.row]];
    
    return cell;
}

@end
