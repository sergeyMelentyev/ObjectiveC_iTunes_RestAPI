//
//  AppDelegate.m
//  MusicVideo
//
//  Created by Админ on 14.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // ADD NOTIFICATION EMITTER AND ALWAYS REMOVE THEM BEFORE APP WILL TERMINATE
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.internetCheck = [Reachability reachabilityForInternetConnection];
    [self.internetCheck startNotifier];
    
    return YES;
}

- (void) reachabilityChanged:(NSNotification *)notification {
    self.reachability = (Reachability *)notification.object;
    [self statusChangedWithReachability:self.reachability];
}

- (void) statusChangedWithReachability:(Reachability *)currentReachabilityStatus {
    NetworkStatus networkStatus = [currentReachabilityStatus currentReachabilityStatus];
    switch (networkStatus) {
        case NotReachable:
            self.reachabilityStatus = @"NOACCESS";
            break;
        case ReachableViaWiFi:
            self.reachabilityStatus = @"WIFI";
            break;
        case ReachableViaWWAN:
            self.reachabilityStatus = @"WWAN";
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReachStatusChanged" object:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
