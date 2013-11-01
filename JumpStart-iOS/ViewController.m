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
@property (strong, nonatomic) AppUser *createdUser;
@property (strong, nonatomic) AppUser *updatedUser;
@end

@implementation ViewController

NSString *endPointURLBase = @"http://localhost:9000/api/users";

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


- (IBAction)testGET:(id)sender {
    
    id findUserSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
      
        NSLog(@"findUserSuccess: %@", JSON);
        
        _foundUser = [_appUserManager populateAppUser:JSON];
        NSLog(@"foundUser: %@", _foundUser);
    };
    
    id findUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"status code: %ld", (long)[operation.response statusCode]);
    };
    
    NSString *findUserString = [NSString stringWithFormat:@"%@/%@", endPointURLBase, @"1"];
    
    [AppUserManager getAppUser:findUserString : nil
                       success:findUserSuccess
                       failure:findUserFailure];
}


- (IBAction)testPOST:(id)sender {
    
    id createUserSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSLog(@"JSON: %@", JSON);
        
        _createdUser = [[AppUser alloc] init];
        _createdUser.userId = [JSON valueForKeyPath:@"data.id"];
    };
    
    id createUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Create Failure: %@", error);
    };
    
    // populate data needed to create user
    NSDictionary *userDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"jimmy@gmail.com", @"username",
                             @"password", @"password",
                             @"password", @"confirmPassword", nil];
    
    [AppUserManager createAppUser: endPointURLBase :userDic
                          success:createUserSuccess
                          failure:createUserFailure];
}


- (IBAction)testPUT:(id)sender {
    
    id foundUserSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSLog(@"JSON: %@", JSON);
        
        AppUser *foundUser = [[AppUser alloc] init];
        foundUser.userId = [JSON valueForKeyPath:@"id"];
        
        id updateSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
            NSLog(@"updated JSON: %@", JSON);
        };
        
        id updateFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"update failure: %@", error);
        };
        
        NSString *updateUserString = [NSString stringWithFormat:@"%@/%@", endPointURLBase, foundUser.userId];
        
        // populate data needed to create user
        NSDictionary *userDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"willy@aol.com", @"username",
                                 @"password", @"password",
                                 @"password", @"confirmPassword", nil];
        
        [AppUserManager updateAppUser: updateUserString : userDic
                              success:updateSuccess
                              failure:updateFailure];
    };
    
    id foundUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"NSERROR: %@", error);
    };
    
    NSString *findUserString = [NSString stringWithFormat:@"%@/%@", endPointURLBase, @"1"];
    
    [AppUserManager getAppUser: findUserString : nil
                          success:foundUserSuccess
                          failure:foundUserFailure];
}


- (IBAction)testDELETE:(id)sender {
    
    id foundUserSuccess = ^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"Delete Successful");
    };
    
    id foundUserFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"delete failure: %@", error);
    };
    
    NSString *deleteUserString = [NSString stringWithFormat:@"%@/%@", endPointURLBase, @"1"];
    
    [AppUserManager deleteAppUser: deleteUserString : nil
                       success:foundUserSuccess
                       failure:foundUserFailure];
}

@end
