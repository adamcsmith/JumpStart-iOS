//
//  AppUserManager.h
//  JumpStart-iOS
//
//  Created by Adam C. Smith on 10/29/13.
//  Copyright (c) 2013 SPARC. All rights reserved.
//
#import "AppUser.h"
#import "AFHTTPRequestOperationManager.h"

@interface AppUserManager : NSObject

+ (void) createAppUser : (NSString *) endPoint : (NSDictionary *) userData
                success:(void(^)(AFHTTPRequestOperation *operation, id JSON))successCallback
                failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failureCallback;

+ (void) getAppUser : (NSString *) endPoint : (NSDictionary *) userData
                success:(void(^)(AFHTTPRequestOperation *operation, id JSON))successCallback
                failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failureCallback;

+ (void) updateAppUser : (NSString *) endPoint : (NSDictionary *) userData
             success:(void(^)(AFHTTPRequestOperation *operation, id JSON))successCallback
             failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failureCallback;

+ (void) deleteAppUser : (NSString *) endPoint : (NSDictionary *) userData
                success:(void(^)(AFHTTPRequestOperation *operation, id JSON))successCallback
                failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failureCallback;

- (AppUser *) populateAppUser : (id) JSON;

@end
