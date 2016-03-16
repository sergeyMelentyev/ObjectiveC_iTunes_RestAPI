//
//  MusciVideoViewController.h
//  MusicVideo
//
//  Created by Админ on 16.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface MusicVideoViewController : UITableViewController
@property (strong, nonatomic) Reachability *reachability;
@property (strong, nonatomic) Reachability *internetCheck;
@property (strong, nonatomic) NSString *reachabilityStatus;
@end