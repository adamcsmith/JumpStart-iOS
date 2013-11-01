//
//  AppUserManager.m
//  JumpStart-iOS
//
//  Created by Adam C. Smith on 10/29/13.
//  Copyright (c) 2013 SPARC. All rights reserved.
//

#import "AppUserManager.h"

@interface AppUserManager ()
@end

@implementation AppUserManager

+ (void) createAppUser:(NSString *)endPoint :(NSDictionary *)userData
               success:(void (^)(AFHTTPRequestOperation *, id))successCallback
               failure:(void (^)(AFHTTPRequestOperation *, NSError *))failureCallback {
    
    AFHTTPRequestOperationManager *manager  = [self configureRequestManager];
    
    [manager
     POST: endPoint
     parameters: userData
     success:successCallback
     failure:failureCallback
     ];
}

+ (void) getAppUser:(NSString *)endPoint :(NSDictionary *)userData
           success:(void (^)(AFHTTPRequestOperation *, id))successCallback
           failure:(void (^)(AFHTTPRequestOperation *, NSError *))failureCallback{
    
    AFHTTPRequestOperationManager *manager = [self configureRequestManager];
    
    [manager
     GET: endPoint
     parameters: nil
     success:successCallback
     failure:failureCallback
     ];
    
}

+ (void) updateAppUser:(NSString *)endPoint :(NSDictionary *)userData
           success:(void (^)(AFHTTPRequestOperation *, id))successCallback
           failure:(void (^)(AFHTTPRequestOperation *, NSError *))failureCallback{
    
    AFHTTPRequestOperationManager *manager = [self configureRequestManager];
    
    [manager
     PUT: endPoint
     parameters: userData
     success:successCallback
     failure:failureCallback
     ];
    
}

+ (void) deleteAppUser:(NSString *)endPoint :(NSDictionary *)userData
              success:(void (^)(AFHTTPRequestOperation *, id))successCallback
              failure:(void (^)(AFHTTPRequestOperation *, NSError *))failureCallback{
    
    AFHTTPRequestOperationManager *manager = [self configureRequestManager];
    
    [manager
     DELETE: endPoint
     parameters: userData
     success:successCallback
     failure:failureCallback
     ];
    
}

- (AppUser *) populateAppUser : (id) json {
    
    AppUser *user = [[AppUser alloc] init];
    
    user.userId = [json valueForKeyPath:@"id"];
    user.username = [json valueForKeyPath:@"username"];
    user.password = [json valueForKeyPath:@"password"];
    
//    user.confirmPassword = [json valueForKeyPath:@"confirmPassword"];
//    user.plainTextPassword = [json valueForKeyPath:@"plainTextPassword"];
//    user.temporaryPassword = [json valueForKeyPath:@"temporaryPassword"];
//    user.temporaryPasswordExpiration = [json valueForKeyPath:@"temporaryPasswordExpiration"];
//    user.failedLoginAttempts = [json valueForKeyPath:@"failedLoginAttempts"];
//    user.lastLogin = [json valueForKeyPath:@"lastLogin"];
//    user.created = [json valueForKeyPath:@"created"];
//    user.updated = [json valueForKeyPath:@"updated"];
//    user.salt = [json valueForKeyPath:@"salt"];
//    user.role = [json valueForKeyPath:@"roles"];
    
    return user;
}

+ (AFHTTPRequestOperationManager *) configureRequestManager {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // use json serialization policy
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return manager;
}

@end
