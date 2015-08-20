//
//  MSContentView.h
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const MSContentCellIdentifier;;

@class MSContent;

@interface MSContentCell : UITableViewCell

- (void)setContent:(MSContent *)content;

@end
