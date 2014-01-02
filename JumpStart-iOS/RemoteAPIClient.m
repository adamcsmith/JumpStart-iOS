//
//  RemoteAPIClient.m
//  JumpStart-iOS
//
//  Created by Adam C. Smith on 11/11/13.
//  Copyright (c) 2013 SPARC. All rights reserved.
//

#import "RemoteAPIClient.h"

@implementation RemoteAPIClient

// TODO: should we encrypt user passwords before we send them over the wire?


#pragma mark - crud operations

/**
 BASIC CRUD OPERATIONS -
 These operations work for both MySQL and Mongo databases
 **/

+ (void) create:(NSString *)endPoint : (NSDictionary *)data
        success:(void (^)(AFHTTPRequestOperation *, id))successCallback
        failure:(void (^)(AFHTTPRequestOperation *, NSError *))failureCallback{
    
    AFHTTPRequestOperationManager *manager = [self configureRequestManager];
    
    AFHTTPRequestOperation *operation = [manager POST:endPoint parameters:data success:successCallback failure:failureCallback];
    
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:^{}];
    
    [operation start];
}

+ (void) retrieve:(NSString *)endPoint :(NSDictionary *)data
          success:(void (^)(AFHTTPRequestOperation *, id))successCallback
          failure:(void (^)(AFHTTPRequestOperation *, NSError *))failureCallback{
    
    AFHTTPRequestOperationManager *manager = [self configureRequestManager];
    
    AFHTTPRequestOperation *operation = [manager GET:endPoint parameters:data success:successCallback failure:failureCallback];
    
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:^{}];
    
    [operation start];
    
}

+ (void) update:(NSString *)endPoint :(NSDictionary *)data
        success:(void (^)(AFHTTPRequestOperation *, id))successCallback
        failure:(void (^)(AFHTTPRequestOperation *, NSError *))failureCallback{
    
    AFHTTPRequestOperationManager *manager = [self configureRequestManager];
    
    AFHTTPRequestOperation *operation = [manager PUT:endPoint parameters:data success:successCallback failure:failureCallback];
    
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:^{}];
    
    [operation start];
}

+ (void) delete:(NSString *)endPoint : (NSDictionary *) data
        success:(void (^)(AFHTTPRequestOperation *, id))successCallback
        failure:(void (^)(AFHTTPRequestOperation *, NSError *))failureCallback{
    
    AFHTTPRequestOperationManager *manager = [self configureRequestManager];
    
    [manager
     DELETE: endPoint
     parameters: data
     success:successCallback
     failure:failureCallback
     ];
}



#pragma mark - AFNetworking 2.0 config methods

+ (AFHTTPRequestOperationManager *) configureRequestManager {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // use json serialization policy
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return manager;
}

//+ (NSString *) convertDictionaryToJSONString:(NSDictionary *)dictionary {
//    
//    NSMutableDictionary *tempDic = [NSMutableDictionary new];
//    
//    if (dictionary && [dictionary count] > 0) {
//        
//        for (NSString *key in dictionary) {
//            
//            NSString *keyValue = [dictionary objectForKey:key];
//            //dont add any params that are empty strings
//            if (![keyValue isEqualToString:@""] && key != nil) {
//                
//                [tempDic setObject:keyValue forKey:key];
//            }
//        }
//    }
//    
//    NSData *dataDic = [NSJSONSerialization dataWithJSONObject:tempDic options:NSJSONWritingPrettyPrinted error:nil];
//    
//    NSString *jsonString = [[NSString alloc] initWithData:dataDic encoding:NSUTF8StringEncoding];
//    
//    return jsonString;
//}

@end
