//
//  MSAddViewController.m
//  Minion Says
//
//  Created by anna on 8/31/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSAddViewController.h"
#import "MSContentValidator.h"
#import "MSDataSource.h"

static NSString *const defaultImage = @"newItem.jpg";

@interface MSAddViewController () <UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *addTextField;
@property (nonatomic, strong) MSContentValidator *validator;

@end


@implementation MSAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.validator = [[MSContentValidator alloc] init];
    
}

#pragma mark - Methods

- (void)validateInputText {
    NSError *error = nil;
    
    BOOL isValid = [self.validator isValidContentText:self.addTextField.text error:&error];
    if (isValid == NO) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:error.localizedDescription
                                                            message:error.localizedFailureReason
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                                  otherButtonTitles:nil];
        [alertView show];

    } else {
        [self saveNewItem];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[NSString stringWithFormat:
                                                                     NSLocalizedString(@"Minion say: %@", @"Minion say"),
                                                                     self.addTextField.text]
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                                  otherButtonTitles:nil];
        [alertView show];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)saveNewItem {
    self.dataSource = [[MSDataSource alloc] init];
    [self.dataSource saveModelWithImageName:defaultImage text:self.addTextField.text];
}

#pragma mark - Actions

- (IBAction)actionSave:(id)sender {
    [self validateInputText];
}

#pragma mark - UITableViewDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self validateInputText];
    return NO;
}

@end
