//
//  MSContentFactory.m
//  Minion Says
//
//  Created by anna on 8/31/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSContentFactory.h"

@implementation MSContentFactory

+ (MSContent *)contentWithImageName:(NSString *)imageName text:(NSString *)text{
    MSContent *newContent = [[MSContent alloc] initWithImage:[UIImage imageNamed:imageName] text:text];
    return newContent;
}

@end
