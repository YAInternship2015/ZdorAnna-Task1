//
//  MSCollectionViewCell.h
//  Minion Says
//
//  Created by anna on 8/27/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const MSCollectionCellIdentifier;
@class MSContent;

@interface MSCollectionViewCell : UICollectionViewCell

- (void)setContent:(MSContent *)content;

@end

