//
//  MSContentFactory.h
//  Minion Says
//
//  Created by anna on 8/31/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSContent.h"

@interface MSContentFactory : NSObject

+ (MSContent *)contentWithImage:(NSString *)imageName text:(NSString *)text;

@end
