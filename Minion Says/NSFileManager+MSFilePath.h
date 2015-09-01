//
//  NSFileManager+MSFilePath.h
//  Minion Says
//
//  Created by anna on 9/1/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (MSFilePath)

+ (NSString *)filePath:(NSString *)name type:(NSString *)type;

@end
