//
//  ASTextViewTableViewCell.m
//  AnonySender
//
//  Created by Jarred Sumner on 8/15/14.
//  Copyright (c) 2014 Uber. All rights reserved.
//

#import "ASTextViewTableViewCell.h"


@implementation ASTextViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UITextView *textView = [[UITextView alloc] init];
        textView.translatesAutoresizingMaskIntoConstraints = NO;
        textView.textContainerInset = UIEdgeInsetsMake(10, 2, 10, 2);
        textView.font = [UIFont systemFontOfSize:16.0f];
        textView.delegate = self;
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(textView);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textView]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textView]|" options:0 metrics:nil views:views]];
    }
    return self;
}

@end
