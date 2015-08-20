//
//  MSContent.h
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSContent : NSObject

@property (nonatomic, strong, readonly) UIImage * image;
@property (nonatomic, strong, readonly) NSString * text;

- (id) initWithImage: (UIImage *)image
             andText: (NSString *)text;

@end
