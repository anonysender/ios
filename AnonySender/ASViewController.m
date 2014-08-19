//
//  ASViewController.m
//  AnonySender
//
//  Created by Jarred Sumner on 8/14/14.
//  Copyright (c) 2014 Uber. All rights reserved.
//

#import "ASViewController.h"
#import "ASTextFieldTableViewCell.h"
#import "ASTextViewTableViewCell.h"

#import "SVProgressHUD.h"

static const NSInteger ASHeaderSection = 0;
static const NSInteger ASBodySection = 1;

static NSString * ASTextFieldCellReuseIdentifier = @"ASTextFieldCellReuseIdentifier";
static NSString * ASTextViewCellReuseIdentifier = @"ASTextViewCellReuseIdentifier";

@interface ASViewController () <UITextFieldDelegate>

@property (nonatomic, weak) UITextField *toTextField;
@property (nonatomic, weak) UITextField *subjectTextField;
@property (nonatomic, weak) UITextView *bodyTextView;

@end

@implementation ASViewController

#pragma mark - UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"Anonysender";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendEmail)];
    }
    return self;
}

- (void)loadView {
    [super loadView];

    self.tableView.scrollEnabled = NO;
    // Get rid of
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];

    [self.tableView registerClass:[ASTextFieldTableViewCell class] forCellReuseIdentifier:ASTextFieldCellReuseIdentifier];
    [self.tableView registerClass:[ASTextViewTableViewCell class] forCellReuseIdentifier:ASTextViewCellReuseIdentifier];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.toTextField becomeFirstResponder];
}

#pragma mark - ASViewController

- (void)sendEmail {
    [SVProgressHUD showWithStatus:@"Sending..." maskType:SVProgressHUDMaskTypeBlack];
    NSString *data = [NSString stringWithFormat:@"to=%@&subject=%@&body=%@", self.toTextField.text, self.subjectTextField.text, self.bodyTextView.text];
    
    NSURL *url = [NSURL URLWithString:@"http://anonysender.herokuapp.com/mails"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
        NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
        if ([indexSet containsIndex:statusCode]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"Sent!"];
                self.toTextField.text = nil;
                self.subjectTextField.text = nil;
                self.bodyTextView.text = nil;
                [self.toTextField becomeFirstResponder];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:@"Failed to send!"];
            });
        }
    }];
    [task resume];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case ASHeaderSection:
            return 44.0f;
        
        case ASBodySection:
            return 200.0f;
            
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case ASHeaderSection:
            return 2;
            
        case ASBodySection:
            return 1;
            
        default:
            return 0;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case ASHeaderSection: {
            ASTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ASTextFieldCellReuseIdentifier forIndexPath:indexPath];

            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text= @"To:";
                    cell.textField.placeholder = @"example@example.com";
                    cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
                    cell.textField.delegate = self;
                    cell.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    cell.textField.autocorrectionType = UITextAutocorrectionTypeNo;
                    self.toTextField = cell.textField;
                    break;
                
                case 1:
                    cell.textLabel.text = @"Subject:";
                    cell.textField.placeholder = @"Example Subject";
                    cell.textField.delegate = self;
                    cell.textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
                    cell.textField.autocorrectionType = UITextAutocorrectionTypeNo;
                    self.subjectTextField = cell.textField;
                    break;
            }
            
            return cell;
        }

        case ASBodySection: {
            ASTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ASTextViewCellReuseIdentifier forIndexPath:indexPath];
            self.bodyTextView = cell.textView;
            return cell;
        }

        default:
            return nil;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.toTextField isEqual:textField]) {
        [self.subjectTextField becomeFirstResponder];
    } else if ([self.subjectTextField isEqual:textField]) {
        [self.bodyTextView becomeFirstResponder];
    }
    
    return NO;
}


@end
