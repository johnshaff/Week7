//
//  AutoLayout.m
//  CoreDataHotelService
//
//  Created by Adam Wallraff on 11/28/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

#import "AutoLayout.h"

@implementation AutoLayout


+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute:(NSLayoutAttribute)attribute andMultiplier:(CGFloat)multiplier{
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:view
                                      attribute:attribute
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:superView
                                      attribute:attribute
                                      multiplier:multiplier
                                      constant:0.0];
    
    constraint.active = YES;
    
    return constraint;
    
}

+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute:(NSLayoutAttribute)attribute{
    
    return [AutoLayout createGenericConstraintFrom:view
                                             toView:superView
                                      withAttribute:attribute
                                      andMultiplier:1.0];
    
    
}

+(NSArray *)activateFullViewConstraintsUsingVFLFor:(UIView *)view{
    
    NSArray *constraints = [[NSArray alloc]init];
    
    NSDictionary *viewDictionary = @{@"view": view};
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:viewDictionary];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:viewDictionary];
    
    constraints = [constraints arrayByAddingObjectsFromArray:horizontalConstraints];
    constraints = [constraints arrayByAddingObjectsFromArray:verticalConstraints];
    
    [NSLayoutConstraint activateConstraints:constraints];
    
    return constraints;
    
}

+(NSArray *)activateFullViewConstraintsFrom:(UIView *)view toView:(UIView *)superView{
    
    NSMutableArray *constraints = [[NSMutableArray alloc]init];
    
    NSLayoutConstraint *leadingConstraint = [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeLeading];
    
    NSLayoutConstraint *trailingConstraint = [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeTrailing];
    
    NSLayoutConstraint *topConstraint = [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeTop];

    NSLayoutConstraint *bottomConstraint = [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeBottom];
    
    [constraints addObject:leadingConstraint];
    [constraints addObject:trailingConstraint];
    [constraints addObject:topConstraint];
    [constraints addObject:bottomConstraint];
    
    return constraints.copy;
    
}

+(NSLayoutConstraint *)createLeadingConstraintFrom:(UIView *)view toView:(UIView *)superView{
    return [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeLeading];
}

+(NSLayoutConstraint *)createTrailingConstraintFrom:(UIView *)view toView:(UIView *)superView{
    return [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeTrailing];
}

+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView{
    return [AutoLayout createGenericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeHeight];
}

+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView withMultiplier:(CGFloat)multiplier{
    return [AutoLayout createGenericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeHeight andMultiplier:multiplier];
}

@end













