//
//  MSContentManager.h
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MSContent;

@interface MSContentManager : NSObject

+ (MSContentManager *)managerWithSetOfContent;
- (MSContent *)contentAtIndex:(NSInteger)index;
- (NSInteger)contentCount;

@end
