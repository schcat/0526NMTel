//
//  BNRDetailViewController.h
//  0526NMTel
//
//  Created by Zhixue Li on 5/30/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController

@property (nonatomic, strong) BNRItem *item;

- (instancetype)initForNewItem:(BOOL)isNew;

@end
