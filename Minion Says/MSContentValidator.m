//
//  MSContentValidator.m
//  Minion Says
//
//  Created by anna on 8/31/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSContentValidator.h"

 static const NSInteger MSContentTextMinLength = 3;
 static const NSInteger MSContentTextValidationLengthError = 3;
 static NSString *const MSContentDomain = @"MSContentDomain";

@implementation MSContentValidator

- (BOOL)isValidContentText:(NSString *)text error:(NSError **)error{
    if (text.length < MSContentTextMinLength) {
        if (error) {
            NSString *description = NSLocalizedString(@"Input Validation Failed", @"Input Validation Failed");
            NSString *reason = NSLocalizedString(@"Number of characters is less than three", @"Number of characters is less than three");
            
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey : description,
                                       NSLocalizedFailureReasonErrorKey : reason
                                       };
            *error = [NSError errorWithDomain:MSContentDomain
                                         code:MSContentTextValidationLengthError
                                     userInfo:userInfo];

        }
        return NO;
    }
    return YES;
}

@end
