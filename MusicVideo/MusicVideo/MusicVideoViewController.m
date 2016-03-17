//
//  MusciVideoViewController.m
//  MusicVideo
//
//  Created by Админ on 16.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "MusicVideoViewController.h"
#import "APIManager.h"
#import "MusicVideo.h"
#import "MusicVideoCell.h"
#import "MusicVideoDetailsController.h"

@interface MusicVideoViewController ()
@property (nonatomic, strong) NSArray *videoList;
@end

@implementation MusicVideoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoList = [[NSArray alloc] init];
}
// CUSTOM FUNCTION FOR PUTTING TABLEVIEW BACK TO THE MAIN THREAD AND UPGRADE IT
-(void) updateTableData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
- (void) viewDidAppear:(BOOL)animated {
    // ADD NOTIFICATION EMITTER AND ALWAYS REMOVE THEM BEFORE APP WILL TERMINATE
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.internetCheck = [Reachability reachabilityForInternetConnection];
    [self.internetCheck startNotifier];
    [self statusChangedWithReachability:self.internetCheck];
    [self reachabilityStatusChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityStatusChanged) name:@"ReachStatusChanged" object:nil];
    [self runAPI];
}

// PARSER FROM ITUNES API JSON TO NSARRAY
- (void) runAPI {
    [[APIManager instance] loadData:^(NSDictionary *dataDict, NSString *errMessage) {
        if (dataDict) {
            NSMutableArray *arrOfVideosForTableView = [[NSMutableArray alloc] init];
            NSDictionary *feed = [dataDict objectForKey:@"feed"];
            NSArray *entry = [feed objectForKey:@"entry"];
            NSInteger rank = 1;
            for (NSDictionary *d in entry) {
                MusicVideo *vid = [[MusicVideo alloc] init];
                
                vid.vRank = [NSString stringWithFormat:@"%ld", (long)rank];
                
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
                        NSString *videoImageSize = [[videoImageDict objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"100x100" withString:@"800x800"];
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
                rank++;
            }
            self.videoList = arrOfVideosForTableView;
            [self updateTableData];
            NSLog(@"GOOD %lu", (unsigned long)self.videoList.count);
        } else if (errMessage) {
            NSLog(@"ERROR %lu", (unsigned long)self.videoList.count);
        }
    }];
}

- (void) reachabilityChanged:(NSNotification *)notification {
    self.reachability = (Reachability *)notification.object;
    [self statusChangedWithReachability:self.reachability];
}

- (void) statusChangedWithReachability:(Reachability *)currentReachabilityStatus {
    NetworkStatus networkStatus = [currentReachabilityStatus currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        self.reachabilityStatus = @"NOACCESS";
    } else if (networkStatus == ReachableViaWiFi) {
        self.reachabilityStatus = @"WIFI";
    } else {
        self.reachabilityStatus = @"WWAN";
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReachStatusChanged" object:nil];
}

- (void) reachabilityStatusChanged {
    if ([self.reachabilityStatus isEqualToString:@"NOACCESS"]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No Internet Access" message:@"Please make sure you are connected to the Internet" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else if ([self.reachabilityStatus isEqualToString:@"WIFI"]) {
        if (self.videoList.count == 0) {
            [self runAPI];
        }
    } else {
        if (self.videoList.count == 0) {
            [self runAPI];
        }
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicVideoCell *cell = (MusicVideoCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MusicVideoCell alloc] init];
    }
    return cell;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicVideo *video = [self.videoList objectAtIndex:indexPath.row];
    MusicVideoCell *vidCell = (MusicVideoCell*)cell;
    [vidCell updateUI:video];
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     MusicVideo *video = [self.videoList objectAtIndex:indexPath.row];
     [self performSegueWithIdentifier:@"musicDetail" sender:video];
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoList.count;
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"musicDetail"]) {
        MusicVideoDetailsController *mvdc = (MusicVideoDetailsController*)segue.destinationViewController;
        MusicVideo *video = (MusicVideo*)sender;
        mvdc.videoContent = video;
    }
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReachStatusChanged" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end