//
//  DNDBlindSpotSampleViewController.m
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/3/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//

#import "DNDBlindSpotSampleViewController.h"
#import "DNDSampleDragView.h"


@interface DNDBlindSpotSampleViewController () <DNDDragSourceDelegate, DNDDropTargetDelegate>
@end


@implementation DNDBlindSpotSampleViewController

#pragma mark - Initialization

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Blind Spot";
    }
    return self;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dragAndDropController registerDragSource:self.dragSourceView withDelegate:self];
    [self.dragAndDropController registerDropTarget:self.blindSpotView withDelegate:self];
}


#pragma mark - Drag Source Delegate

- (UIView *)draggingViewForDragOperation:(DNDDragOperation *)operation {
    UIView *dragView = [[DNDSampleDragView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 75.0f)];
    dragView.alpha = 0.0f;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.alpha = 1.0f;
    }];
    return dragView;
}

- (void)dragOperationWillCancel:(DNDDragOperation *)operation {
    [operation removeDraggingViewAnimatedWithDuration:0.2 animations:^(UIView *draggingView) {
        draggingView.alpha = 0.0f;
        draggingView.center = [operation convertPoint:self.dragSourceView.center fromView:self.view];
    }];
}


#pragma mark - Drop Target Delegate

- (void)dragOperation:(DNDDragOperation *)operation didDropInDropTarget:(UIView *)target {
    [self dragOperationWillCancel:operation];
}

- (BOOL)dragOperation:(DNDDragOperation *)operation shouldPositionDragViewInDropTarget:(UIView *)target {
    return NO;
}

@end
