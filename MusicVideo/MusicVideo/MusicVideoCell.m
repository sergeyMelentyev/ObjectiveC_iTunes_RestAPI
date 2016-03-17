//
//  MusicVideoCell.m
//  MusicVideo
//
//  Created by Админ on 16.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "MusicVideoCell.h"

@interface MusicVideoCell()
@property (weak, nonatomic) IBOutlet UILabel *videoRankLable;
@property (weak, nonatomic) IBOutlet UILabel *videoArtistLable;
@property (weak, nonatomic) IBOutlet UILabel *videoNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *videoImagePoster;
@property (weak, nonatomic) IBOutlet UIView *videoCellConteiner;
@end

@implementation MusicVideoCell

// STYLES FOR REUSABLE CELL
- (void) awakeFromNib {
    self.videoCellConteiner.layer.cornerRadius = 5.0;
    self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.8].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 3.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
}

// UPGRADE CONTENT OF EACH CELL
- (void) updateUI:(nonnull MusicVideo*)video {
    self.videoRankLable.text = [NSString stringWithFormat:@"#%@ on iTunes today", video.vRank];
    self.videoArtistLable.text = video.vArtist;
    self.videoNameLable.text = video.vName;
    // self.videoImagePoster.image = [UIImage imageNamed:@"noImage"];
    if (video.vImageData != nil) {
        self.videoImagePoster.image = [UIImage imageWithData:video.vImageData];
        NSLog(@"GETTING IMAGE FROM ARRAY");
    } else {
        [self getVideoImageFromUrl:(video) imageView:(self.videoImagePoster)];
        NSLog(@"GETTING IMAGE FROM BACKGROUND THREAD");
    }
}

// CONVERT THE IMAGE FROM URL TO UIIMAGE
- (void) getVideoImageFromUrl:(MusicVideo*)video imageView:(UIImageView*)imageView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: video.vImageUrl]];
        if (data != nil) {
            video.vImageData = data;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = [UIImage imageWithData:video.vImageData];
        });
    });
}

@end

