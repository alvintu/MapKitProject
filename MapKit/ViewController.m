//
//  ViewController.m
//  MapKit
//
//  Created by Jo Tu on 7/5/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;

@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *viewAllButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userCoordinate;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MapKit";
    self.mapView.zoomEnabled = YES;
    [self loadHardCodedValues];

    [self zoomToFitMapAnnotations:self.mapView];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    NSString *reuseId = @"Pin";
    MKPinAnnotationView *annov = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if(!annov)
    {
        annov = [[MKPinAnnotationView alloc]initWithAnnotation:annotation
                                               reuseIdentifier:reuseId];
    }
        annov.pinTintColor = [UIColor greenColor];  //or Green or Purple
        annov.canShowCallout = YES;
//        annov.rightCdalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    UIImageView *tempImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    annov.leftCalloutAccessoryView = tempImageView;
//    tempImageView.image = [UIImage imageNamed:<#(nonnull NSString *)#>]
    MyCustomAnnotation *customann = annov.annotation;
    tempImageView.image = customann.image;

  
    
    
    UIButton *detailButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
    detailButton.frame = CGRectMake(0, 0, 30, 30);
    detailButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    detailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    annov.rightCalloutAccessoryView = detailButton;
    
    
    
    
    return annov;

}



- (void)mapView:(MKMapView *)eMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"tapped");
    WebViewController *webViewController = [[WebViewController alloc]init];
    MyCustomAnnotation *customann = view.annotation;

    webViewController.webLink = customann.url;

        [self.navigationController pushViewController:webViewController animated:YES];

   

}


- (void)zoomToFitMapAnnotations:(MKMapView *)mapView {
    
        if ([mapView.annotations count] == 0) return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    NSLog(@"count is %lu",[self.mapView.annotations count]);
    
    for(MyCustomAnnotation *annotation in self.mapView.annotations) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.8;
    
    // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.8;
    
    // Add a little extra space on the sides
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}


-(void)loadHardCodedValues{
    
    
    
    MyCustomAnnotation *ann = [[MyCustomAnnotation alloc]init];
    ann.coordinate = CLLocationCoordinate2DMake (40.741434, -73.990039);;
    ann.title = @"TurnToTech";
    ann.subtitle = @"iOS BootCamp";
    ann.url = [NSURL URLWithString:@"http://turntotech.io"];
    ann.image = [UIImage imageNamed:@"apple-icon-180x180.png"];
    
    MyCustomAnnotation *ann1 = [[MyCustomAnnotation alloc]init];
    ann1.coordinate = CLLocationCoordinate2DMake(40.744464, -73.993063);
    ann1.title = @"Perpetuum";
    ann1.subtitle = @"Coffee Shop";
    ann1.url = [NSURL URLWithString:@"http://yelp.com/biz/perpetuum-cafe-new-york"];
    ann1.image = [UIImage imageNamed:@"perpetuum.jpg"];

    
    MyCustomAnnotation *ann2 = [[MyCustomAnnotation alloc]init];
    ann2.coordinate = CLLocationCoordinate2DMake (40.742037, -73.987563);
    ann2.title = @"Shake Shack";
    ann2.subtitle = @"Burgers";
    ann2.url = [NSURL URLWithString:@"http://shakeshack.com"];
    ann2.image = [UIImage imageNamed:@"shakeshack.png"];

    
    MyCustomAnnotation *ann3 = [[MyCustomAnnotation alloc]init];
    ann3.title = @"Gregorys Coffee";
    ann3.subtitle = @"Basic Coffee";
    ann3.coordinate = CLLocationCoordinate2DMake (40.740943, -73.985494);
    ann3.url = [NSURL URLWithString:@"http://gregoryscoffee.com/"];
    ann3.image = [UIImage imageNamed:@"gregorys.jpg"];

    
    
    MyCustomAnnotation *ann4 = [[MyCustomAnnotation alloc]init];
    ann4.coordinate = CLLocationCoordinate2DMake (40.740543, -73.98781);
    ann4.title = @"Sophies Cuban Cuisine";
    ann4.subtitle = @"Cuban Food";
    ann4.url = [NSURL URLWithString:@"http://sophiescuban.com/"];
    ann4.image = [UIImage imageNamed:@"sophies.jpg"];

    
    [self.mapView addAnnotation:ann];
    [self.mapView addAnnotation:ann1];
    [self.mapView addAnnotation:ann2];
    [self.mapView addAnnotation:ann3];
    [self.mapView addAnnotation:ann4];

}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}



- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    
//    // If the text changed, reset the tableview if it wasn't empty.
//    if (self.places.count != 0) {
//        
//        // Set the list of places to be empty.
//        self.places = @[];
//        // Reload the tableview.
//        [self.tableView reloadData];
//        // Disable the "view all" button.
//        self.viewAllButton.enabled = NO;
//    }
//}


- (void)startSearch:(NSString *)searchString {
    if (self.localSearch.searching)
    {
        [self.localSearch cancel];
    }
    
    // Confine the map search area to the user's current location.
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 40.741434;
    newRegion.center.longitude = -73.990039;
    
    // Setup the area spanned by the map region:
    // We use the delta values to indicate the desired zoom level of the map,
    //      (smaller delta values corresponding to a higher zoom level).
    //      The numbers used here correspond to a roughly 8 mi
    //      diameter area.
    //
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    request.naturalLanguageQuery = searchString;
    request.region = newRegion;
    
    MKLocalSearchCompletionHandler completionHandler = ^(MKLocalSearchResponse *response, NSError *error) {
        if (error != nil) {
            NSString *errorStr = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not find places"
                                                            message:errorStr
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
//        }
    else {

        [self.mapView removeAnnotations:_mapView.annotations];

        for (MKMapItem *item in response.mapItems)
        {
            MyCustomAnnotation *annotation = [[MyCustomAnnotation alloc] init];
            annotation.title      = item.name;
            annotation.coordinate = item.placemark.coordinate;
            annotation.subtitle   = item.placemark.title;
            annotation.url = item.url;
//            annotation.image = FOR FUTURE PROJECT
            
    
//            NSURL *url = [NSURL URLWithString:@"http://img.abc.com/noPhoto4530.gif"];
//            NSData *data = [NSData dataWithContentsOfURL:url];
//            UIImage *image = [UIImage imageWithData:data];

            NSLog(@"%@",response.mapItems);
            [self.mapView addAnnotation:annotation];
            

        }
       
        
        [self zoomToFitMapAnnotations:self.mapView];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    };
    
    if (self.localSearch != nil) {
        self.localSearch = nil;
    }
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [self.localSearch startWithCompletionHandler:completionHandler];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self startSearch:self.searchBar.text];

    
//     Check if location services are available
//    if ([CLLocationManager locationServicesEnabled] == NO) {
//        NSLog(@"%s: location services are not available.", __PRETTY_FUNCTION__);
//        
//        // Display alert to the user.
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Location services"
//                                                                       message:@"Location services are not enabled on this device. Please enable location services in settings."
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
//                                                              handler:^(UIAlertAction * action) {}]; // Do nothing action to dismiss the alert.
//        
//        [alert addAction:defaultAction];
//        [self presentViewController:alert animated:YES completion:nil];
//        
//        return;
//    }
//    
//    // Request "when in use" location service authorization.
//    // If authorization has been denied previously, we can display an alert if the user has denied location services previously.
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
//        [self.locationManager requestWhenInUseAuthorization];
//    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
//        NSLog(@"%s: location services authorization was previously denied by the user.", __PRETTY_FUNCTION__);
//        
//        // Display alert to the user.
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Location services"
//                                                                       message:@"Location services were previously denied by the user. Please enable location services for this app in settings."
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
//                                                              handler:^(UIAlertAction * action) {}]; // Do nothing action to dismiss the alert.
//        
//        [alert addAction:defaultAction];
//        [self presentViewController:alert animated:YES completion:nil];
//        
//        return;
//    }
//    
//    // Start updating locations.
//    self.locationManager.delegate = self;
//    [self.locationManager startUpdatingLocation];
    
//     When a location is delivered to the location manager delegate, the search will actually take place. See the -locationManager:didUpdateLocations: method.
}


#pragma mark - CLLocationManagerDelegate methods

//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    
//    // Remember for later the user's current location.
//    CLLocation *userLocation = locations.lastObject;
//    self.userCoordinate = userLocation.coordinate;
//    
//    [manager stopUpdatingLocation]; // We only want one update.
//    
//    manager.delegate = nil;         // We might be called again here, even though we
//    // called "stopUpdatingLocation", so remove us as the delegate to be sure.
//    
//    // We have a location now, so start the search.
//    [self startSearch:self.searchBar.text];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    // report any errors returned back from Location Services
//}
//
-(IBAction)setMapStyle:(id)sender
{
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}


@end
