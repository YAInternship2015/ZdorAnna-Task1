//
//  MSContentManager.m
//  Minion Says
//
//  Created by anna on 8/13/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSContentManager.h"
#import "MSContent.h"

@interface MSContentManager ()

@property (nonatomic, strong) NSMutableArray* contentArray;

@end

@implementation MSContentManager

+ (MSContentManager *) managerWithSetOfContent{
    NSArray * contentImages = [NSArray arrayWithObjects:@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg",
                              @"5.jpg", @"6.jpg", @"7.jpg", @"8.jpg", @"9.jpg", @"10.jpg", nil];
    
    NSArray * contentText = [NSArray arrayWithObjects:@"Poopaya!", @"Gelato", @"Tulaliloo ti amo!", @"BEE DO BEE DO BEE DO!",
                             @"Butt", @"Bello!", @"Bananonina!", @"Po ka", @"Tatata bala tu!", @"Me want banana!", nil];
    
    NSMutableArray * tempArray = [NSMutableArray array];
    
    for (int i = 0; i < [contentImages count]; i++) {
        
        MSContent * newContent = [[MSContent alloc] initWithImage:[UIImage imageNamed:[contentImages objectAtIndex:i]]
                                                          andText:[contentText objectAtIndex:i]];
        [tempArray addObject:newContent];
    }
    
    MSContentManager* allContent = [[MSContentManager alloc] init];
    allContent.contentArray = tempArray;
    
    return allContent;
}

- (MSContent *) contentAtIndex: (NSInteger) index{
    if (index < 0 || index >= [self.contentArray count]) {
        return nil;
    }
    return [self.contentArray objectAtIndex:index];
}

- (NSInteger) contentCount{
    return [self.contentArray count];
}

@end
