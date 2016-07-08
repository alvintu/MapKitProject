//
//  MyCustomAnnotation.h
//  MapKit
//
//  Created by Jo Tu on 7/6/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyCustomAnnotation : NSObject <MKAnnotation> {
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) UIImage *image;

- (id)initWithLocation:(CLLocationCoordinate2D)coord title:(NSString*)title subtitle:(NSString*)subtitle;
// Other methods and properties.


@end
