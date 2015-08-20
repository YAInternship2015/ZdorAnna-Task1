//
//  MSContentView.m
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSContentCell.h"
#import "MSContent.h"

NSString* const MSContentCellIdentifier = @"MSContentCellIdentifier";

@interface MSContentCell()

@property (nonatomic, weak) IBOutlet UIImageView * contentImage;
@property (nonatomic, weak) IBOutlet UILabel * contentText;

@end

@implementation MSContentCell

- (void)setContent:(MSContent *)content {
#warning отступ в две табуляции вместо одной
        self.contentText.text = content.text;
        self.contentImage.image = content.image;
}

@end
