//
//  BNRImageTransformer.m
//  0526NMTel
//
//  Created by Zhixue Li on 1/25/16.
//  Copyright © 2016 Zhixue Li. All rights reserved.
//

#import "BNRImageTransformer.h"
#import <UIKit/UIKit.h>

@implementation BNRImageTransformer

+ (Class) transformedValueClass{
    return [NSData class];
}
- (id) transformedValue:(id)value{
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    return UIImagePNGRepresentation(value);
}
- (id)reverseTransformedValue:(id)value{
    return [UIImage imageWithData:value];
}

@end
