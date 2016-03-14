//
//  APIManager.h
//  MusicVideo
//
//  Created by Админ on 14.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^onComplete)(NSArray* dataArray, NSString* errMessage);

@interface APIManager : NSObject
+(id) instance;
-(void) loadData:(onComplete)completionHandler;
@end