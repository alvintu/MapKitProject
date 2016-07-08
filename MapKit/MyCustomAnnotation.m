//
//  MyCustomAnnotation.m
//  MapKit
//
//  Created by Jo Tu on 7/6/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import "MyCustomAnnotation.h"

@implementation MyCustomAnnotation


- (id)initWithLocation:(CLLocationCoordinate2D)coord title:(NSString*)title subtitle:(NSString*)subtitle{
    self = [super init];
    if (self) {
        coord = _coordinate;
    }
    return self;
}

@end
