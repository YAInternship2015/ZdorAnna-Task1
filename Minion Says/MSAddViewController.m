//
//  MSAddViewController.m
//  Minion Says
//
//  Created by anna on 8/31/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSAddViewController.h"
#import "MSContentValidator.h"

@interface MSAddViewController () <UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *addTextField;
@property (nonatomic, strong) MSContentValidator *validator;

@end


@implementation MSAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.validator = [[MSContentValidator alloc] init];
}

#pragma mark - Methods

- (void)validateInputText{
    NSError *error = nil;
    
    BOOL isValid = [self.validator isValidContentText:self.addTextField.text error:&error];
    if (isValid == NO) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:error.localizedDescription
                                                            message:error.localizedFailureReason
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - Actions

- (IBAction)actionSaveItem:(id)sender {
    [self validateInputText];
}

#pragma mark - UITableViewDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self validateInputText];
    return NO;
}


@end
