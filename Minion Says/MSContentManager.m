//
//  MSContentManager.m
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSContentManager.h"
#import "MSContent.h"
#import "NSFileManager+MSFilePath.h"

@interface MSContentManager ()

@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSString *path1;


@end

@implementation MSContentManager

#pragma mark - MSContentManager methods

- (MSContentManager *)managerWithSetOfContent{
    NSArray* contentArray = [[NSArray alloc] initWithContentsOfFile:[self plistPath]];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary* modelDictionary in contentArray) {
        MSContent *newContent = [[MSContent alloc] initWithImage:[UIImage imageNamed:[modelDictionary valueForKey:@"image"]]
                                                            text:[modelDictionary valueForKey:@"text"]];
        [tempArray addObject:newContent];
    }
    MSContentManager *allContent = [[MSContentManager alloc] init];
    allContent.contentArray = tempArray;
    
    return allContent;
}

- (MSContent *)contentAtIndex:(NSInteger)index{
    if (index < 0 || index >= [self.contentArray count]) {
        return nil;
    }
    return [self.contentArray objectAtIndex:index];
}

- (NSInteger)contentCount{
    return [self.contentArray count];
}

- (void)saveModel:(MSContent *)newModel{
    NSDictionary *newModelDictionary = [NSDictionary dictionaryWithObjectsAndKeys:newModel.text, @"text", nil];
    NSMutableArray *modelsArray = [NSMutableArray arrayWithContentsOfFile:[self plistPath]];
    
    [modelsArray addObject:newModelDictionary];
    
    [modelsArray writeToFile:[self plistPath] atomically:YES];
}

#pragma mapk - Methods

- (NSString *)plistPath{
    NSString *plistPath = [NSFileManager filePath:@"Content" type:@"plist"];
    return plistPath;
}


@end
