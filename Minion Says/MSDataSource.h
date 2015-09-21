//
//  MSContentManager.h
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MSContent;

@interface MSDataSource : NSObject

- (instancetype)initWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (MSContent *)contentAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)contentCount;
- (void)saveModelWithImageName:(NSString *)imageName text:(NSString *)text;
- (void)deleteModelAtIndexPath:(NSIndexPath *)indexPath;


@end
