//
//  AutoLayout.h
//  CoreDataHotelService
//
//  Created by Adam Wallraff on 11/28/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

@import UIKit;

@interface AutoLayout : NSObject

+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute:(NSLayoutAttribute)attribute andMultiplier:(CGFloat)multiplier;

+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute:(NSLayoutAttribute)attribute;

+(NSArray *)activateFullViewConstraintsUsingVFLFor:(UIView *)view;
+(NSArray *)activateFullViewConstraintsFrom:(UIView *)view toView:(UIView *)superView;

+(NSLayoutConstraint *)createLeadingConstraintFrom:(UIView *)view toView:(UIView *)superView;
+(NSLayoutConstraint *)createTrailingConstraintFrom:(UIView *)view toView:(UIView *)superView;

+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView;
+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView withMultiplier:(CGFloat)multiplier;

+(NSLayoutConstraint *)createTopToBottomRelationFrom:(UIView *)view toView:(UIView *)superView;



@end
