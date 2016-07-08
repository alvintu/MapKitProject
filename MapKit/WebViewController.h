//
//  WebViewController.h
//  MapKit
//
//  Created by Jo Tu on 7/5/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) NSURL *webLink;
@end
