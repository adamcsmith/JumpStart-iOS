//
//  AppUser.h
//  JumpStart-iOS
//
//  Created by Adam C. Smith on 10/29/13.
//  Copyright (c) 2013 SPARC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUser : NSObject

@property (strong, nonatomic) NSString *userId;

// required fields for creation
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *confirmPassword;

// optional fields -- TODO: haven't tested these formats
@property (strong, nonatomic) NSString *plainTextPassword;
@property (strong, nonatomic) NSString *temporaryPassword;
@property (strong, nonatomic) NSString *temporaryPasswordExpiration;
@property (strong, nonatomic) NSString *failedLoginAttempts;
@property (strong, nonatomic) NSDate *lastLogin;
@property (strong, nonatomic) NSDate *created;
@property (strong, nonatomic) NSDate *updated;
@property (strong, nonatomic) NSString *salt;

@end
