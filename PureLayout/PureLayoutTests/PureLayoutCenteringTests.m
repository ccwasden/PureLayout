//
//  PureLayoutCenteringTests.m
//  PureLayout Tests
//
//  Copyright (c) 2014-2015 Tyler Fox
//  https://github.com/PureLayout/PureLayout
//

#import "PureLayoutTestBase.h"

@interface PureLayoutCenteringTests : PureLayoutTestBase

@end

@implementation PureLayoutCenteringTests

- (void)setUp
{
    [super setUp];

}

- (void)tearDown
{

    [super tearDown];
}

- (void)testAutoCenterInSuperview
{
    [self.viewA autoSetDimensionsToSize:CGSizeMake(100.0, 100.0)];
    [self.viewA autoCenterInSuperview];
    [self evaluateConstraints];
    PL_ALAssertCenterEquals(self.viewA, 500.0, 500.0);
    PL_ALAssertFrameEquals(self.viewA, 450.0, 450.0, 100.0, 100.0);
    
    [self.viewB autoSetDimensionsToSize:CGSizeMake(80.0, 124.0)];
    [self.viewB autoCenterInSuperview];
    [self evaluateConstraints];
    PL_ALAssertCenterEquals(self.viewB, 500.0, 500.0);
    PL_ALAssertFrameEquals(self.viewB, 460.0, 438.0, 80.0, 124.0);
}

- (void)testAutoAlignAxisToSuperviewAxis
{
    [self.viewB autoSetDimensionsToSize:CGSizeMake(150.0, 200.0)];
    [self.viewB autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self evaluateConstraints];
    PL_ALAssertCenterXEquals(self.viewB, 500.0);
    
    [self.viewB autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self evaluateConstraints];
    PL_ALAssertCenterYEquals(self.viewB, 500.0);
    
    [self.viewC autoSetDimensionsToSize:CGSizeMake(25.0, 20.0)];
    [self.viewC autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self evaluateConstraints];
    PL_ALAssertCenterYEquals(self.viewC, 500.0);
    
    [self.viewC autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self evaluateConstraints];
    PL_ALAssertCenterXEquals(self.viewC, 500.0);
    
    [self.viewD autoSetDimensionsToSize:CGSizeMake(400.0, 100.0)];
    [self.viewD autoAlignAxisToSuperviewAxis:ALAxisBaseline];
    [self evaluateConstraints];
#if TARGET_OS_IPHONE
    // viewD and its superview are regular UIViews which have no baseline offset, so the baseline is treated as the bottom edge
    PL_ALAssertMaxYEquals(self.viewD, 1000.0);
#else
    // viewD and its superview are regular NSViews which have no baseline offset, so the baseline is treated as the top edge
    PL_ALAssertMaxYEquals(self.viewD, 100.0);
#endif
}

@end
