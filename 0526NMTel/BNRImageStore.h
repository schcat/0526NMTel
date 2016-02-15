//
//  BNRImageStore.h
//  0526NMTel
//
//  Created by Zhixue Li on 1/25/16.
//  Copyright © 2016 Zhixue Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRImageStore : NSObject

+ (instancetype) sharedStore;

- (void)setImage:(UIImage *)image forkey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
