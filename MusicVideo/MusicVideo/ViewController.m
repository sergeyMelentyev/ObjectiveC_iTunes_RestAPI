//
//  ViewController.m
//  MusicVideo
//
//  Created by Melentyev on 14.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[APIManager instance] loadData:^(NSArray *dataArray, NSString *errMessage) {
        if (dataArray) {
            NSLog(@"%@", dataArray);
        } else if (errMessage) {
            NSLog(@"NO INTERNET CONNECTION");
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
