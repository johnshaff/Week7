//
//  AutoLayoutTests.m
//  
//
//  Created by John Shaff on 12/16/16.
//
//

#import <XCTest/XCTest.h>
#import "AutoLayout.h"

@interface AutoLayoutTests : XCTestCase

@end

@implementation AutoLayoutTests

- (void)setUp {
    [super setUp];

  

}

- (void)testCreateGenericConstraintFrom{
    UIView *view = [[UIView alloc]init];
    UIView *superView = [[UIView alloc]init];
    NSLayoutAttribute attribute = NSLayoutAttributeTop;
    CGFloat multiplier = 0.0;
    
    NSLayoutConstraint *newConstraint = [creategener]
    
    XCTAssert(creategener)
    
}

- (void)tearDown {

    
    
    [super tearDown];
}


@end
