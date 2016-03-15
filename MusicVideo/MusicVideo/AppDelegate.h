//
//  AppDelegate.h
//  MusicVideo
//
//  Created by Админ on 14.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *reachability;
@property (strong, nonatomic) Reachability *internetCheck;
@property (strong, nonatomic) NSString *reachabilityStatus;

@end