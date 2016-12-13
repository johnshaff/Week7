//
//  AutoLayoutTest.m
//  CoreDataHotelService
//
//  Created by John Shaff on 11/30/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AutoLayout.h"


@interface AutoLayoutTest : XCTestCase

@property(strong, nonatomic)UIViewController *testController;
@property(strong, nonatomic)UIView *testView1;
@property(strong, nonatomic)UIView *testView2;

@end

@implementation AutoLayoutTest

- (void)setUp {
    [super setUp];
    
    self.testController = [[UIViewController alloc]init];
    self.testView1 = [[UIView alloc]init];
    self.testView2 = [[UIView alloc]init];
}

- (void)tearDown {
    
    self.testController = nil;
    self.testView1 = nil;
    self.testView2 = nil;
    
    [super tearDown];
}

-(void)testViewControllerNotNil{
    XCTAssertNotNil(self.testController, @"self.testController is nil");
}

-(void)testViewsAreNotEqual {
    XCTAssertNotEqual(self.testView1, self.testView2, @"string");
}

-(void)testViewClass{
    XCTAssert([self.testView1 isKindOfClass:[UIView class]], @"String");
}


-(void)testCreateGenericConstraintFromViewToViewWithAttrAndMult{
    id constraint = [AutoLayout createGenericConstraintFrom:self.testView1 toView:self.testView2 withAttribute:NSLayoutAttributeTop andMultiplier:1.0];
    
    XCTAssert([constraint isMemberOfClass:[NSLayoutConstraint class]], @"String");
}

-(void)testActivateFullViewConstraintsReturnsConstraintsArray{
    NSArray *constraints = [AutoLayout activateFullViewConstraintsUsingVFLFor:self.testView1];
    
    int count = 0;
    
    for (id constraint in constraints){
        if ([constraint isKindOfClass:[NSLayoutConstraint class]]) {
            count++;
        }
    }
    
    XCTAssert(count == 0, @"String", count);
}

@end
