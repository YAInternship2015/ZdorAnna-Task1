//
//  ViewController.m
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSTableViewController.h"
#import "MSContent.h"
#import "MSContentCell.h"
#import "MSContentManager.h"

NSString *const MSTableViewControllerIdentifier = @"MSTableViewControllerIdentifier";

@interface MSTableViewController () <UITableViewDataSource>

@property (nonatomic, strong) MSContentManager *allContent;

@end

@implementation MSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MSContentManager *cm = [[MSContentManager alloc] init];
    self.allContent = [cm managerWithSetOfContent];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [self.allContent contentCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MSContentCell *cell = [tableView dequeueReusableCellWithIdentifier:MSContentCellIdentifier forIndexPath:indexPath];
    
    [cell setContent:[self.allContent contentAtIndex:indexPath.row]];
    
    return cell;
}

@end
