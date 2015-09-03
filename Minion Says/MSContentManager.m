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

NSString *const MSDataFileContentDidChangeNotification = @"MSDataFileContentDidChangeNotification";

@interface MSContentManager ()

@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, weak) id<MSModelsDataSourceDelegate> delegate;

@end

@implementation MSContentManager

- (instancetype)initWithDelegate:(id<MSModelsDataSourceDelegate>)delegate {
    self = [self init];
    if (self) {
        
        [self plistPath];
        self.contentArray = [NSArray arrayWithArray:[self arrayWithSetOfContent]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadSetOfContent:)
                                                     name:MSDataFileContentDidChangeNotification
                                                   object:nil];
        self.delegate = delegate;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - MSContentManager methods

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
    NSDictionary *newModelDictionary = [NSDictionary dictionaryWithObjectsAndKeys:newModel.text, @"text",
                                                                                  @"newItem.jpg", @"image", nil];
    NSMutableArray *modelsArray = [NSMutableArray arrayWithContentsOfFile:[self plistPath]];
    [modelsArray addObject:newModelDictionary];
    [modelsArray writeToFile:[self plistPath] atomically:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MSDataFileContentDidChangeNotification object:self];
}

#pragma mapk - Methods

- (NSArray *)arrayWithSetOfContent{
    NSArray* contentArray = [[NSArray alloc] initWithContentsOfFile:[self plistPath]];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary* modelDictionary in contentArray) {
        MSContent *newContent = [[MSContent alloc] initWithImage:[UIImage imageNamed:[modelDictionary valueForKey:@"image"]]
                                                            text:[modelDictionary valueForKey:@"text"]];
        [tempArray addObject:newContent];
    }
    return tempArray;
}

- (NSString *)plistPath{
    NSString *plistPath = [NSFileManager filePath:@"Content" type:@"plist"];
    return plistPath;
}

#pragma mark - Notification

- (void)reloadSetOfContent:(NSNotification *)notification{
    self.contentArray = [self arrayWithSetOfContent];
    [self.delegate dataWasChanged:self];
}

@end
