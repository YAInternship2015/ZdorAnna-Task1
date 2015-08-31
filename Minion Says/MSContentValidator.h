//
//  MSContentValidator.h
//  Minion Says
//
//  Created by anna on 8/31/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSContentValidator : NSObject

- (BOOL)isValidContentText:(NSString *)text error:(NSError **)error;

@end
