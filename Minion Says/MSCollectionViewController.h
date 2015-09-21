//
//  MSCollectionViewController.h
//  Minion Says
//
//  Created by anna on 8/26/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MSDataSource;

extern NSString *const MSCollectionViewControllerIdentifier;

@interface MSCollectionViewController : UICollectionViewController

@property (nonatomic, strong) MSDataSource *dataSource;

@end
