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
-(void) awakeFromNib {
    self.layer.cornerRadius = 2.0;
    self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.8].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
}
-(void) updateUI:(nonnull MusicVideo*)video {
    self.videoArtistLable.text = video.vArtist;
    self.videoNameLable.text = video.vName;
    self.videoImagePoster.image = [UIImage imageNamed:@"noImage"];
}
@end