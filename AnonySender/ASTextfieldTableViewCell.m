//
//  ASTextfieldTableViewCell.m
//  AnonySender
//
//  Created by Jarred Sumner on 8/15/14.
//  Copyright (c) 2014 Uber. All rights reserved.
//

#import "ASTextFieldTableViewCell.h"

@implementation ASTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont systemFontOfSize:14.f];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.returnKeyType = UIReturnKeyNext;
        [self.contentView addSubview:textField];
        self.textField = textField;
        
        UILabel *textLabel = self.textLabel;
        textLabel.font = [UIFont systemFontOfSize:14.f];
        textLabel.textColor = [UIColor grayColor];
        textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [textLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

        NSDictionary *views = NSDictionaryOfVariableBindings(textLabel, textField);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[textLabel]-8-[textField]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    }

    return self;
}

@end
