//
//  APIManager.m
//  MusicVideo
//
//  Created by Админ on 14.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+(id) instance {
    static APIManager *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
        return sharedInstance;
    }
}

-(void) loadData:(onComplete)completionHandler {
    // CONFIGURE NSURLSESSION WITHOUT CASHE
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSString *iTunesAddress = @"https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json";
    NSURL *url = [NSURL URLWithString: iTunesAddress];
    [[session dataTaskWithURL:url completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (data != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                NSError *err;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (err == nil) {
                        completionHandler(json, nil);
                    } else {
                        completionHandler(nil, @"DATA IS CORRUPTED");
                    }
                });
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, @"NO INTERNET CONNECTION");
            });
        }
        
    }] resume];
}
@end






