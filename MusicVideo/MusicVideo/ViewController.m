//
//  ViewController.m
//  MusicVideo
//
//  Created by Melentyev on 14.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"
#import "MusicVideo.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *videoList;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoList = [[NSArray alloc] init];
    
    // PARSER FROM ITUNES API JSON TO NSARRAY
    [[APIManager instance] loadData:^(NSDictionary *dataDict, NSString *errMessage) {
        if (dataDict) {
            NSMutableArray *arrOfVideosForTableView = [[NSMutableArray alloc] init];
            NSDictionary *feed = [dataDict objectForKey:@"feed"];
            NSArray *entry = [feed objectForKey:@"entry"];
            for (NSDictionary *d in entry) {
                MusicVideo *vid = [[MusicVideo alloc] init];
                
                NSDictionary *videoName = [d objectForKey:@"im:name"];
                vid.vName = [videoName objectForKey:@"label"];
                
                NSArray *videoImageArr = [d objectForKey:@"im:image"];
                NSDictionary *videoImageDict = videoImageArr[2];
                NSString *videoImageSize = [[videoImageDict objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"100x100" withString:@"600x600"];
                vid.vImageUrl = videoImageSize;
                
                NSArray *videoUrlArrOne = [d objectForKey:@"link"];
                NSDictionary *videoUrlDictOne = videoUrlArrOne[1];
                NSDictionary *videoUrlDictTwo = [videoUrlDictOne objectForKey:@"attributes"];
                vid.vVideoUrl = [videoUrlDictTwo objectForKey:@"href"];
                
                [arrOfVideosForTableView addObject:vid];
            }
            self.videoList = arrOfVideosForTableView;
        } else if (errMessage) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Connection Error" message:@"No internet connection found" preferredStyle: UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull okAction) {
                // ANY LOGIC AFTER OK ALERT PRESSED
            }];
            [alert addAction:okAction];
            [self presentViewController: alert animated:YES completion:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
