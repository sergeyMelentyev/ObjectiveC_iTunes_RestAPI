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

-(void) loadData:(nullable onComplete)completionHandler {
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json"]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (data != nil) {
            NSError *err;
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            if (err == nil) {
                completionHandler(json, nil);
            } else {
                completionHandler(nil, @"DATA IS CORRUPTED");
            }
        } else {
            completionHandler(nil, @"NO INTERNET CONNECTION");
        }
        
    }] resume];
}
@end






