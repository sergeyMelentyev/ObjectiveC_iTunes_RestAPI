//
//  MusicVideoCell.h
//  MusicVideo
//
//  Created by Админ on 16.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicVideo.h"

@interface MusicVideoCell : UITableViewCell
-(void) updateUI:(nonnull MusicVideo*)video;
@end