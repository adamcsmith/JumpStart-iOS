//
//  ViewController.m
//  JumpStart-iOS
//
//  Created by Adam C. Smith on 10/29/13.
//  Copyright (c) 2013 SPARC. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppUserManager.h"

@interface ViewController ()
@property (strong, nonatomic) AppUserManager *appUserManager;
@property (strong, nonatomic) AppUser *foundUser;
@end

@implementation ViewController

// base url for endpoint
NSString *endPointURLBase = @"http://localhost:9000/api/users";

// user id for testing purposes
NSString *userIDForTesting = @"527bcc72036440a177b13ab0";



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _appUserManager = [[AppUserManager alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - crud rest methods

- (IBAction)testPOST:(id)sender {
    
    id createUserSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSLog(@"Created User Success! User details: %@", JSON);
    };
    
    id createUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Create User Failure: %@", error);
    };
    
    // create test user
    NSString *createString = [self createTestUserData1];
    
    // make create call
    [AppUserManager createAppUser:endPointURLBase : createString
                          success:createUserSuccess
                          failure:createUserFailure];
}

- (IBAction)testGET:(id)sender {
    
    id findUserSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
      
        NSLog(@"(GET) User successfully found: %@", JSON);
    };
    
    id findUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"(GET) Failure finding user: %ld", (long)[operation.response statusCode]);
    };
    
    NSString *findUserString = [NSString stringWithFormat:@"%@/%@", endPointURLBase, userIDForTesting];
    
    [AppUserManager getAppUser:findUserString : nil
                       success:findUserSuccess
                       failure:findUserFailure];
}


- (IBAction)testPUT:(id)sender {
    
    id foundUserSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSLog(@"Successfully found user for PUT!");
        
        // lets hold on to the id for later use
        AppUser *foundUser = [[AppUser alloc] init];
        foundUser.userId = [JSON valueForKeyPath:@"id"];
        
        id updateSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
            NSLog(@"User successfully updated! Check them out: %@", JSON);
        };
        
        id updateFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failure when updating user: %@", error);
        };
        
        // set the endpoint
        NSString *updateEndpoint = [NSString stringWithFormat:@"%@/%@", endPointURLBase, foundUser.userId];
        
        // populate data needed to create user
        NSString *updateData = [self createTestUserData1];
        
        // update the user
        [AppUserManager updateAppUser: updateEndpoint : updateData
                              success:updateSuccess
                              failure:updateFailure];
    };
    
    id foundUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"(PUT) Failure finding user: %@", error);
    };
    
    NSString *findUserString = [NSString stringWithFormat:@"%@/%@", endPointURLBase, userIDForTesting];
    
    [AppUserManager getAppUser: findUserString : nil
                          success:foundUserSuccess
                          failure:foundUserFailure];
}


- (IBAction)testDELETE:(id)sender {
    
    id foundUserSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"Delete Successful");
    };
    
    id foundUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Delete Failure: %@", error);
    };
    
    NSString *deleteUserString = [NSString stringWithFormat:@"%@/%@", endPointURLBase, userIDForTesting];
    
    [AppUserManager deleteAppUser: deleteUserString : nil
                       success:foundUserSuccess
                       failure:foundUserFailure];
}



# pragma mark - creating users for testing

- (NSString *) createTestUserData1 {
    
    // populate data needed to create user
    NSDictionary *userDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"rg3@nfl.com", @"username",
                             @"httr", @"password",
                             @"httr", @"confirmPassword", nil];
    
    // converts the dictionary to a string
    NSString *userData = [AppUserManager convertDictionaryToJSONString:userDic];
    
    return userData;
}

- (NSString *) createTestUserData2 {
    
    // populate data needed to create user
    NSDictionary *userDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"mrtyson@gmail.com", @"username",
                             @"dogtreats", @"password",
                             @"dogtreats", @"confirmPassword", nil];
    
    // converts the dictionary to a string
    NSString *userData = [AppUserManager convertDictionaryToJSONString:userDic];
    
    return userData;
}

@end
