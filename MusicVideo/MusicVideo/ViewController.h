//
//  ViewController.h
//  MusicVideo
//
//  Created by Melentyev on 14.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) Reachability *reachability;
@property (strong, nonatomic) Reachability *internetCheck;
@property (strong, nonatomic) NSString *reachabilityStatus;
@end