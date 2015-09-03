//
//  MSContentManager.h
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSContent;
@protocol MSModelsDataSourceDelegate;

extern NSString *const MSDataFileContentDidChangeNotification;

@interface MSContentManager : NSObject

- (instancetype)initWithDelegate:(id<MSModelsDataSourceDelegate>)delegate;
- (MSContent *)contentAtIndex:(NSInteger)index;
- (NSInteger)contentCount;
- (void)saveModel:(MSContent *)newModel;

@end


@protocol MSModelsDataSourceDelegate <NSObject>

- (void)dataWasChanged:(MSContentManager *)data;

@end