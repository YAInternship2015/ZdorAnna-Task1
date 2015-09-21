//
//  ViewController.h
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MSDataSource;

extern NSString *const MSTableViewControllerIdentifier;

@interface MSTableViewController : UITableViewController 

@property (nonatomic, strong) MSDataSource *dataSource;

@end

