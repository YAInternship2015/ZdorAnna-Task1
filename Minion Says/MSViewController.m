//
//  ViewController.m
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSViewController.h"
#import "MSContent.h"
#import "MSContentCell.h"
#import "MSContentManager.h"

@interface MSViewController () <UITableViewDataSource>

@property (nonatomic, strong) MSContentManager* allContent;

@end

@implementation MSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allContent = [MSContentManager managerWithSetOfContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [self.allContent contentCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MSContentCell * cell = [tableView dequeueReusableCellWithIdentifier:MSContentCellIdentifier forIndexPath:indexPath];
    
    [cell setContent:[self.allContent contentAtIndex:indexPath.row]];
    
    return cell;
}



@end
