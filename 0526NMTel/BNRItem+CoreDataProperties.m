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

#import "BNRItem+CoreDataProperties.h"

@implementation BNRItem (CoreDataProperties)

@dynamic contactName;
@dynamic cellPhone;
@dynamic landLine;
@dynamic contactEmail;
@dynamic key;
@dynamic orderingValue;
@dynamic thumbnail;
@dynamic assetType;

- (void)setThumbnailFromImage:(UIImage *)image
{
    CGSize origImageSize = image.size;
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    float ratio = MAX(newRect.size.width/origImageSize.width, newRect.size.height/origImageSize.height);
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width)/2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height)/2.0;
    [image drawInRect:projectRect];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    UIGraphicsEndImageContext();
}

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    self.dateCreated
}

@end
