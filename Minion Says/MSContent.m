//
//  MSContent.m
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSContent.h"

@implementation MSContent

- (id) initWithImage:(UIImage *)image
             andText:(NSString *)text{
    self = [super init];
    if (self)
    {
        _image = image;
        _text = text;
    }
    return self;
}

@end
