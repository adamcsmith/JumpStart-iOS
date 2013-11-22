//
//  ViewController.m
//  JumpStart-iOS
//
//  Created by Adam C. Smith on 10/29/13.
//  Copyright (c) 2013 SPARC. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "RemoteAPIClient.h"
#import "AppUser.h"

@interface ViewController ()
@property (strong, nonatomic) RemoteAPIClient *remoteAPIclient;
@property (strong, nonatomic) AppUser *foundUser;
@end

@implementation ViewController

// base url for endpoint
NSString *endPointURLBase = @"http://localhost:9000/api/users";

// user id's for testing purposes
//NSString *userIDForTesting = @"528cef9f0364b3c80e5ff431"; // mongo
NSString *userIDForTesting = @"36"; //mySql



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
    NSString *createString = [self createTestUserData1];
    
    // make create call
    [RemoteAPIClient create:endPointURLBase : createString
                    success:createUserSuccess
                    failure:createUserFailure];
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
    
    NSString *findUserString = [NSString stringWithFormat:@"%@/%@", endPointURLBase, userIDForTesting];
    
    [RemoteAPIClient retrieve:findUserString : nil
                      success:findUserSuccess
                      failure:findUserFailure];
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
        
        // set the endpoint
        NSString *updateEndpoint = [NSString stringWithFormat:@"%@/%@", endPointURLBase, userIDForTesting];
        
        // populate data needed to create user
        NSString *updateData = [self createTestUserData2];
        
        // update the user
        [RemoteAPIClient update:updateEndpoint : updateData
                        success:updateSuccess
                        failure:updateFailure];
    
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
    
    NSString *deleteUserString = [NSString stringWithFormat:@"%@/%@", endPointURLBase, userIDForTesting];
    
    [RemoteAPIClient delete:deleteUserString : nil
                    success:deleteUserSuccess
                    failure:deleteUserFailure];
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

- (NSString *) createTestUserData1 {
    
    // populate data needed to create user
    NSDictionary *userDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"robertgriffiniii@yahoo.com", @"username",
                             @"httr", @"password",
                             @"httr", @"confirmPassword",
                             nil];
    
    // converts the dictionary to a string
    NSString *userData = [RemoteAPIClient convertDictionaryToJSONString:userDic];
    
    return userData;
}

- (NSString *) createTestUserData2 {
    
    // populate data needed to create user
    NSDictionary *userDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"mrtyson@gmail.com", @"username",
                             @"dogtreats", @"password",
                             @"dogtreats", @"confirmPassword",
                             nil];
    
    // converts the dictionary to a string
    NSString *userData = [RemoteAPIClient convertDictionaryToJSONString:userDic];
    
    return userData;
}

@end
