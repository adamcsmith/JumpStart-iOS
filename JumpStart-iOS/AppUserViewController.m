//
//  ViewController.m
//  JumpStart-iOS
//
//  Created by Adam C. Smith on 10/29/13.
//  Copyright (c) 2013 SPARC. All rights reserved.
//

#import "AppUserViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "RemoteAPIClient.h"
#import "AppUser.h"

@interface AppUserViewController ()
@property (strong, nonatomic) RemoteAPIClient *remoteAPIclient;
@property (strong, nonatomic) AppUser *foundUser;
@end

@implementation AppUserViewController

// user id's for testing purposes
NSString *userIDForTesting = @"52c59dc40364bd2ad8a19bb9"; // mongo
//NSString *userIDForTesting = @"36"; //mySql



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _remoteAPIclient = [[RemoteAPIClient alloc] init];
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
        [self showSuccessAlertView];
    };
    
    id createUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Create User Failure: %@", operation.responseString);
        [self showFailureAlertView];
    };
    
    // create test user
    NSMutableDictionary *createDic = [self createTestUserData1];
    
    // make create call
    [AppUser createUser:createDic success:createUserSuccess failure:createUserFailure];
}


- (IBAction)testGET:(id)sender {
    
    id findUserSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
      
        NSLog(@"(GET) User successfully found: %@", JSON);
        [self showSuccessAlertView];
    };
    
    id findUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"(GET) Failure finding user: %@", operation.responseString);
        [self showFailureAlertView];
    };
    
    NSMutableDictionary *findUserDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           userIDForTesting, @"id",
                                           nil];
    
    [AppUser findUser:findUserDic success:findUserSuccess failure:findUserFailure];
}


- (IBAction)testPUT:(id)sender {
        
        id updateSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
            NSLog(@"User successfully updated! %@", JSON);
            [self showSuccessAlertView];
        };
        
        id updateFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failure when updating user: %@", operation.responseString);
            [self showFailureAlertView];
        };
    
        // populate data needed to create user
        NSMutableDictionary *updateData = [self createTestUserData2];
        
        // update the user
        [AppUser updateUser:userIDForTesting params:updateData success:updateSuccess failure:updateFailure];
    
}


- (IBAction)testDELETE:(id)sender {
    
    id deleteUserSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"JSON: %@", JSON);
        [self showSuccessAlertView];
    };
    
    id deleteUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Delete Failure: %@", operation.responseString);
        [self showFailureAlertView];
    };
    
    [AppUser deleteUser:userIDForTesting success:deleteUserSuccess failure:deleteUserFailure];
}



# pragma mark - ui alert view

- (void) showSuccessAlertView {

    UIAlertView *testAlert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                        message: @"Woohoo! Successful API Call!"
                                                       delegate:self
                                              cancelButtonTitle:@"Awesome"
                                              otherButtonTitles:nil];
    
    [testAlert show];
}

- (void) showFailureAlertView {
    
    UIAlertView *testAlert = [[UIAlertView alloc] initWithTitle:@"Failure!"
                                                        message: @"Oh no! Your API call failed!"
                                                       delegate:self
                                              cancelButtonTitle:@"Bummer"
                                              otherButtonTitles:nil];
    
    [testAlert show];
}



# pragma mark - creating users for testing

- (NSMutableDictionary *) createTestUserData1 {
    
    // populate data needed to create user
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"jay-z@yahoo.com", @"username",
                             @"httr", @"password",
                             @"httr", @"confirmPassword",
                             nil];
    
    return userDic;
}

- (NSMutableDictionary *) createTestUserData2 {
    
    // populate data needed to create user
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"eminem@gmail.com", @"username",
                             @"dogtreats", @"password",
                             @"dogtreats", @"confirmPassword",
                             nil];
    
    return userDic;
}

@end
