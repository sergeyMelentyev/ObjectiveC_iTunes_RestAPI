//
//  MusicVideoSettingsController.m
//  MusicVideo
//
//  Created by Админ on 17.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "MusicVideoSettingsController.h"

@interface MusicVideoSettingsController()
@property (weak, nonatomic) IBOutlet UILabel *aboutDisplay;
@property (weak, nonatomic) IBOutlet UILabel *feedBackDisplay;
@property (weak, nonatomic) IBOutlet UILabel *securityDisplay;
@property (weak, nonatomic) IBOutlet UISwitch *touchID;
@property (weak, nonatomic) IBOutlet UILabel *bestImageDisplay;
@property (weak, nonatomic) IBOutlet UISwitch *hdImage;
@property (weak, nonatomic) IBOutlet UILabel *apiCount;
@property (weak, nonatomic) IBOutlet UISlider *sliderCount;
- (IBAction)touchIdSecurity:(UISwitch *)sender;
- (IBAction)valueChanged:(UISlider *)sender;
@end

@implementation MusicVideoSettingsController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.title = @"Settings";
    self.touchID.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"SecSettings"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"APICNT"] != nil) {
        NSNumber *theValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"APICNT"];
        self.sliderCount.value = [theValue floatValue];
        self.apiCount.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt:(int)self.sliderCount.value]];
    }
}

- (IBAction)touchIdSecurity:(UISwitch *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.touchID.on) {
        [defaults setBool:self.touchID.on forKey:@"SecSettings"];
    } else {
        [defaults setBool:false forKey:@"SecSettings"];
    }
}

- (IBAction)valueChanged:(UISlider *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:([NSNumber numberWithFloat:(float)self.sliderCount.value]) forKey:@"APICNT"];
    self.apiCount.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt:(int)self.sliderCount.value]];
}

@end










