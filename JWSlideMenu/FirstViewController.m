//
//  FirstViewController.m
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/15/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import "FirstViewController.h"
#import "JWNavigationController.h"
#import "ThirdViewController.h"

@implementation FirstViewController

-(IBAction)pushTest:(id)sender
{
    UIViewController *controller = [[[ThirdViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"First";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
