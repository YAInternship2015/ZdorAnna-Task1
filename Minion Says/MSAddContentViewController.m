//
//  MSAddContentViewController.m
//  Minion Says
//
//  Created by anna on 8/31/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSAddContentViewController.h"
#import "MSContentValidator.h"

@interface MSAddContentViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addTextField;
@property (nonatomic, strong)  MSContentValidator *validator;

@end


@implementation MSAddContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.validator = [[MSContentValidator alloc] init];
}

#pragma mark - Methods

- (void) validateInputText{
    NSError *error = nil;
    
    BOOL validationResult = [self.validator isValidContentText:self.addTextField.text error:&error];
    if (!validationResult) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:error.localizedDescription
                                                            message:error.localizedFailureReason
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - Actions

- (IBAction)actionSaveText:(id)sender {
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self validateInputText];
        return NO;
}

@end
