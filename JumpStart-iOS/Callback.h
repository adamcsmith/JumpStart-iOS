//
//  Callback.h
//  JumpStart-iOS
//
//  Created by Adam C. Smith on 1/2/14.
//  Copyright (c) 2014 SPARC. All rights reserved.
//

#import "AFNetworking.h"
#import <Foundation/Foundation.h>

@interface CallBack : NSObject

typedef void(^SuccessCallBack)(AFHTTPRequestOperation *operation, id JSON);
typedef void(^FailureCallBack)(AFHTTPRequestOperation *operation, NSError *error);

@end