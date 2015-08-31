//
//  MSCollectionViewCell.m
//  Minion Says
//
//  Created by anna on 8/27/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSCollectionViewCell.h"
#import "MSContent.h"

NSString* const MSCollectionCellIdentifier = @"MSCollectionCellIdentifier";

@interface MSCollectionViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *contentImage;

@end

@implementation MSCollectionViewCell

- (void)setContent:(MSContent *)content {
    self.contentImage.image = content.image;
}

@end


