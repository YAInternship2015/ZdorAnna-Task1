//
//  MSContent.h
//  Minion Says
//
//  Created by anna on 9/21/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MSContent : NSManagedObject

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *imageName;

@end
