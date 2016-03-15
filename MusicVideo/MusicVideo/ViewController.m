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
                if (videoName) {
                    vid.vName = [videoName objectForKey:@"label"];
                } else {
                    vid.vName = @"";
                }
                
                NSDictionary *videoRights = [d objectForKey:@"rights"];
                if (videoRights) {
                    vid.vRights = [videoRights objectForKey:@"label"];
                } else {
                    vid.vRights = @"";
                }
                
                NSDictionary *videoPrice = [d objectForKey:@"im:price"];
                if (videoPrice) {
                    vid.vPrice = [videoPrice objectForKey:@"label"];
                } else {
                    vid.vPrice = @"";
                }
                
                NSDictionary *videoArtist = [d objectForKey:@"im:artist"];
                if (videoArtist) {
                    vid.vArtist = [videoArtist objectForKey:@"label"];
                } else {
                    vid.vArtist = @"";
                }
                
                NSDictionary *videoImIdOne = [d objectForKey:@"id"];
                if (videoImIdOne) {
                    NSDictionary *videoImIdTwo = [videoImIdOne objectForKey:@"attributes"];
                    if (videoImIdTwo) {
                        vid.vImId = [videoImIdTwo objectForKey:@"im:id"];
                    }
                } else {
                    vid.vImId = @"";
                }
                
                NSDictionary *videoGenreOne = [d objectForKey:@"category"];
                if (videoGenreOne) {
                    NSDictionary *videoGenreTwo = [videoGenreOne objectForKey:@"attributes"];
                    if (videoGenreTwo) {
                        vid.vGenre = [videoGenreTwo objectForKey:@"label"];
                    }
                } else {
                    vid.vGenre = @"";
                }
                
                NSArray *videoLinkArr = [d objectForKey:@"link"];
                if (videoLinkArr) {
                    NSDictionary *videoLinkDictOne = videoLinkArr[0];
                    if (videoLinkDictOne) {
                        NSDictionary *videoLinkDictTwo = [videoLinkDictOne objectForKey:@"attributes"];
                        if (videoLinkDictTwo) {
                            vid.vLinkToItunes = [videoLinkDictTwo objectForKey:@"href"];
                        }
                    }
                } else {
                    vid.vLinkToItunes = @"";
                }
                
                NSDictionary *videoRelease = [d objectForKey:@"im:releaseDate"];
                if (videoRelease) {
                    vid.vReleaseDate = [videoRelease objectForKey:@"label"];
                } else {
                    vid.vReleaseDate = @"";
                }
                
                NSArray *videoImageArr = [d objectForKey:@"im:image"];
                if (videoImageArr) {
                    NSDictionary *videoImageDict = videoImageArr[2];
                    if (videoImageDict) {
                        NSString *videoImageSize = [[videoImageDict objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"100x100" withString:@"600x600"];
                        if (videoImageSize) {
                            vid.vImageUrl = videoImageSize;
                        }
                    }
                } else {
                    vid.vImageUrl = @"";
                }
                
                NSArray *videoUrlArrOne = [d objectForKey:@"link"];
                if (videoUrlArrOne) {
                    NSDictionary *videoUrlDictOne = videoUrlArrOne[1];
                    if (videoUrlDictOne) {
                        NSDictionary *videoUrlDictTwo = [videoUrlDictOne objectForKey:@"attributes"];
                        if (videoUrlDictTwo) {
                            vid.vVideoUrl = [videoUrlDictTwo objectForKey:@"href"];
                        }
                    }
                } else {
                    vid.vVideoUrl = @"";
                }
                
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
