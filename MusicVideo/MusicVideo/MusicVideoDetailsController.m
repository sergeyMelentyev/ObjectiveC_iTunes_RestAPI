//
//  MusicVideoDetailsController.m
//  MusicVideo
//
//  Created by Админ on 17.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "MusicVideoDetailsController.h"

@interface MusicVideoDetailsController()
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *videoGenre;
@property (weak, nonatomic) IBOutlet UILabel *videoPrice;
@property (weak, nonatomic) IBOutlet UILabel *videoRights;
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

@end