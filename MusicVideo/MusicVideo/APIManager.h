//
//  APIManager.h
//  MusicVideo
//
//  Created by Админ on 14.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^onComplete)(NSDictionary* dataDict, NSString* errMessage);

@interface APIManager : NSObject

@property (nonatomic, strong) NSNumber *currentApiCountManager;
+(id) instance;
-(void) loadData:(onComplete)completionHandler;

@end