//
//  BNRItem+CoreDataProperties.h
//  0526NMTel
//
//  Created by Zhixue Li on 2/1/16.
//  Copyright © 2016 Zhixue Li. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{
    NSString *_NMTelContactName;
    NSString *_NMTelCellPhone;
    NSString *_NMTelLandLine;
    NSString *_NMTelContactEmail;
}
- (instancetype)initWithItemName:(NSString *)ContactName
                  NMTelCellPhone:(NSString *)CellPhone
                   NMTelLandLine:(NSString *)LandLine
               NMTelContactEmail:(NSString *)ContactEmail;

+ (instancetype)initItem;

@property (nonatomic, copy) NSString *NMTelContactName;
@property (nonatomic, copy) NSString *NMTelCellPhone;
@property (nonatomic, copy) NSString *NMTelLandLine;
@property (nonatomic, copy) NSString *NMTelContactEmail;
@property (nonatomic, copy) NSString *itemKey;

@end
