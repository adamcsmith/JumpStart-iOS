//
//  RemoteAPIClient.h
//  JumpStart-iOS
//
//  Created by Adam C. Smith on 11/11/13.
//  Copyright (c) 2013 SPARC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface RemoteAPIClient : NSObject

+ (void) create :(NSString *)endPoint : (NSString *)data
               success:(void (^)(AFHTTPRequestOperation *, id))successCallback
               failure:(void (^)(AFHTTPRequestOperation *, NSError *))failureCallback;

+ (void) retrieve : (NSString *) endPoint : (NSDictionary *) data
             success:(void(^)(AFHTTPRequestOperation *operation, id JSON))successCallback
             failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failureCallback;

+ (void) update : (NSString *) endPoint : (NSString *) data
                success:(void(^)(AFHTTPRequestOperation *operation, id JSON))successCallback
                failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failureCallback;

+ (void) delete : (NSString *) endPoint : (NSDictionary *) data
                success:(void(^)(AFHTTPRequestOperation *operation, id JSON))successCallback
                failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failureCallback;

+ (NSString *) convertDictionaryToJSONString:(NSDictionary *)dictionary;

@end
