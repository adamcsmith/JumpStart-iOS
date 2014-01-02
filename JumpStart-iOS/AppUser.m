//
//  AppUser.m
//  JumpStart-iOS
//
//  Created by Adam C. Smith on 10/29/13.
//  Copyright (c) 2013 SPARC. All rights reserved.
//

#import "AppUser.h"
#import "Callback.h"
#import "RemoteAPIClient.h"

@implementation AppUser

// base url for endpoint
NSString *userEndpoint = @"http://localhost:9000/api/users";

-(void) encodeWithCoder: (NSCoder*) coder {
    
    [coder encodeObject: self.userId forKey: @"userId"];
    [coder encodeObject: self.username forKey: @"username"];
}

-(id) initWithCoder: (NSCoder*) coder {
    
    self = [super init];
    if ( ! self) return nil;
    
    self.userId = [coder decodeObjectForKey:@"userId"];
    self.username = [coder decodeObjectForKey:@"username"];
    
    return self;
}

- (id)initFromDictionary:(NSDictionary*)dict {
    
    self = [super init];
    
    _userId = [dict valueForKey:@"id"];
    _username = [dict objectForKey:@"username"];
    _roles = [dict objectForKey:@"roles"];
    
    return self;
}



#pragma mark - remote calls for user crud operations

+ (void)createUser:(NSMutableDictionary *)params
           success:(SuccessCallBack)successCallback
           failure:(FailureCallBack)failureCallback {
    
    // make create call
    [RemoteAPIClient create:userEndpoint : params
                    success:successCallback
                    failure:failureCallback];
}

+ (void)findUser:(NSMutableDictionary *)params
         success:(SuccessCallBack)successCallback
         failure:(FailureCallBack)failureCallback {
    
    [RemoteAPIClient retrieve:userEndpoint : params
                      success:successCallback
                      failure:failureCallback];
}

+ (void)updateUser:(NSString *) userId
            params:(NSMutableDictionary *)params
           success:(SuccessCallBack)successCallback
           failure:(FailureCallBack)failureCallback {
    
    userEndpoint = [NSString stringWithFormat:@"%@/%@", userEndpoint, userId];
    
    [RemoteAPIClient update: userEndpoint : params
                    success:successCallback
                    failure:failureCallback];
}

+ (void)deleteUser:(NSString *) userId
           success:(SuccessCallBack)successCallback
           failure:(FailureCallBack)failureCallback {
    
    userEndpoint = [NSString stringWithFormat:@"%@/%@", userEndpoint, userId];
    
    [RemoteAPIClient delete: userEndpoint : nil
                    success:successCallback
                    failure:failureCallback];
}



#pragma mark - convenience methods

+ (AppUser *) populateUserFromJSON:(id) JSON {
    
    NSDictionary *jsonDic = JSON;
    
    AppUser *user = [[AppUser alloc] initFromDictionary:jsonDic];
    
    return user;
}


@end
