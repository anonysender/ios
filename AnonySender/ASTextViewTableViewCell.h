//
//  ASTextViewTableViewCell.h
//  AnonySender
//
//  Created by Jarred Sumner on 8/15/14.
//  Copyright (c) 2014 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASTextViewTableViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic, weak) UITextView *textView;

@end
