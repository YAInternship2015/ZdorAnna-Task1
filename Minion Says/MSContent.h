//
//  MSContent.h
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSContent : NSObject

#warning замечание по форматированию (актуально по всему приложению):
//@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, strong, readonly) UIImage * image;
@property (nonatomic, strong, readonly) NSString * text;
#warning замечание по форматированию. Также слово "and" не используется в именах методов
//- (id)initWithImage:(UIImage *)image text: (NSString *)text;
- (id) initWithImage: (UIImage *)image
             andText: (NSString *)text;

@end
