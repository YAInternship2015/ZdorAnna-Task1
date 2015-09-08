//
//  MSAddViewController.m
//  Minion Says
//
//  Created by anna on 8/31/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSAddViewController.h"
#import "MSContentValidator.h"
#import "MSContentManager.h"
#import "MSContentFactory.h"

@interface MSAddViewController () <UITableViewDelegate>

#warning (nonatomic, weak) - такой формати прописан в наших гайдлайнах
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

        
    } else {
        [self saveNewItem];
#warning @"Minion say: %@" следует вынести в Localizable.strings
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[NSString stringWithFormat:@"Minion say: %@",
                                                                     self.addTextField.text]
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                                  otherButtonTitles:nil];
        [alertView show];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)saveNewItem{
    MSContentManager *contentManager = [[MSContentManager alloc] init];
#warning можно создать категорию к UIImage, где будет метод вроде +defaultContentImage. И тогда имя картинки будет инкапсулировано в категории, и в метод фабрики Вы будете передавать уже UIImage
    [contentManager saveModel:[MSContentFactory contentWithImageName:@"newItem.jpg"
                                                                text:self.addTextField.text]];
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
