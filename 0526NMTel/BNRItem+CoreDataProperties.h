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

#import <UIKit/UIKit.h>
#import "BNRItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *contactName;
@property (nullable, nonatomic, retain) NSString *cellPhone;
@property (nullable, nonatomic, retain) NSString *landLine;
@property (nullable, nonatomic, retain) NSString *contactEmail;
@property (nullable, nonatomic, retain) NSString *key;
@property (nonatomic) double *orderingValue;
@property (nullable, nonatomic, retain) UIImage *thumbnail;
@property (nullable, nonatomic, retain) NSManagedObjectModel *assetType;

-(void)setThumbnailFromImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
