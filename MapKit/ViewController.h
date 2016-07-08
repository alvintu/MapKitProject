//
//  ViewController.h
//  MapKit
//
//  Created by Jo Tu on 7/5/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "WebViewController.h"
#import "MyCustomAnnotation.h"


@interface ViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)setMapStyle:(id)sender;

@property (retain, nonatomic) UIView *leftCalloutAccessoryView;
//@property (retain,nonatomic)NSArray *annotationsArray;

@property (strong,nonatomic)MKPointAnnotation* ann;
@property (strong,nonatomic)MKPointAnnotation* ann1;
@property (strong,nonatomic)MKPointAnnotation* ann2;
@property (strong,nonatomic)MKPointAnnotation* ann3;
@property (strong,nonatomic)MKPointAnnotation* ann4;
//@property (strong,nonatomic)NSURL* urlStorage;


@property (nonatomic, strong) NSMutableArray *places;

@end

