//
//  ThirdViewController.m
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/15/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = [[[UIView alloc] initWithFrame:super.view.bounds] autorelease];
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(120.0, 220.0, 60.0, 21.0)] autorelease];
        label.text = @"Third";
        [self.view addSubview:label];
        self.title = @"Third";
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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
