//
//  BNRItem+CoreDataProperties.m
//  0526NMTel
//
//  Created by Zhixue Li on 2/1/16.
//  Copyright © 2016 Zhixue Li. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BNRItem.h"
@implementation BNRItem

- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@   %@",
     self.NMTelContactName,
     self.NMTelCellPhone];
    //   self.NMTelLandLine,
    //   self.NMTelContactEmail];
    
    return descriptionString;
}
- (instancetype)initWithItemName:(NSString *)ContactName
                  NMTelCellPhone:(NSString *)CellPhone
                   NMTelLandLine:(NSString *)LandLine
               NMTelContactEmail:(NSString *)ContactEmail
{
    self = [super init];
    if (self) {
        _NMTelContactName = ContactName;
        _NMTelCellPhone = CellPhone;
        _NMTelLandLine = LandLine;
        _NMTelContactEmail = ContactEmail;
        
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
    }
    return self;
}

+ (instancetype)initItem
{
    BNRItem *newItem = [[self alloc] initWithItemName:@""
                                       NMTelCellPhone:@""
                                        NMTelLandLine:@""
                                    NMTelContactEmail:@""];
    return newItem;
}

@end