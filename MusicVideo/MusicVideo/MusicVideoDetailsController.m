//
//  MusicVideoDetailsController.m
//  MusicVideo
//
//  Created by Админ on 17.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "MusicVideoDetailsController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface MusicVideoDetailsController()
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *videoGenre;
@property (weak, nonatomic) IBOutlet UILabel *videoPrice;
@property (weak, nonatomic) IBOutlet UILabel *videoRights;
- (IBAction)playVideo:(UIBarButtonItem *)sender;
- (IBAction)shareButton:(UIBarButtonItem *)sender;
@end

@implementation MusicVideoDetailsController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.title = self.videoContent.vArtist;
    self.videoName.text = self.videoContent.vName;
    self.videoGenre.text = self.videoContent.vGenre;
    self.videoPrice.text = self.videoContent.vPrice;
    self.videoRights.text = self.videoContent.vRights;
    if (self.videoContent.vImageData != 0) {
        self.imageView.image = [UIImage imageWithData:self.videoContent.vImageData];
    } else {
        self.imageView.image = [UIImage imageNamed:@"noImage"];
    }
}

- (IBAction)playVideo:(UIBarButtonItem *)sender {
    NSURL *url = [NSURL URLWithString:self.videoContent.vVideoUrl];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    playerViewController.player = player;
    [self presentViewController:playerViewController animated:YES completion:^{
        [[playerViewController player] play];
    }];
}

- (IBAction)shareButton:(UIBarButtonItem *)sender {
    [self shareMedia];
}

- (void) shareMedia {
    // CREATE A CONTENT FOR SHARE
    NSString *firstPart = @"Have you had the opportunity to see this video?";
    NSString *secondPart = [NSString stringWithFormat:@"%@ by %@.", self.videoContent.vName, self.videoContent.vArtist];
    NSString *thirdPart = @"Watch it and tell me what you think.";
    NSURL *fourthPart = [NSURL URLWithString: [NSString stringWithFormat:@"%@", self.videoContent.vLinkToItunes]];
    NSString *fifthPart = @"This message created with my Music Video App.";
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[firstPart, secondPart, thirdPart, fourthPart, fifthPart] applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo,
                                   UIActivityTypePostToTencentWeibo,
                                   UIActivityTypePostToTwitter,
                                   UIActivityTypePostToWeibo];
    activityViewController.excludedActivityTypes = excludeActivities;
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}

@end









