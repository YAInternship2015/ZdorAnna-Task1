//
//  NSFileManager+MSFilePath.m
//  Minion Says
//
//  Created by anna on 9/1/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "NSFileManager+MSFilePath.h"

@implementation NSFileManager (MSFilePath)

+ (NSString *)filePath:(NSString *)name type:(NSString *)type{
    
    NSFileManager *fileManger = [self defaultManager];
    NSError *error;
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *doumentDirectoryPath = [pathsArray objectAtIndex:0];
    NSString *destinationPath = [doumentDirectoryPath stringByAppendingPathComponent:
                                 [NSString stringWithFormat:@"%@.%@", name, type]];
    
    if (![fileManger fileExistsAtPath:destinationPath]){
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
        [fileManger copyItemAtPath:sourcePath toPath:destinationPath error:&error];
    }
    return destinationPath;
}

@end
