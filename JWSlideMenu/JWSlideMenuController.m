//
//  JWSlideMenuController.m
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/14/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import "JWSlideMenuController.h"
#import "JWNavigationController.h"
#import "JWSlideMenuViewController.h"

@implementation JWSlideMenuController

@synthesize menuTableView;
@synthesize menuView;
@synthesize contentToolbar;
@synthesize contentView;
@synthesize menuLabelColor;

- (id)init
{
    self = [super init];
    if (self) {
        
        CGRect masterRect = self.view.bounds;
        float menuWidth = 267.0; //masterRect.size.width - 53
        
        CGRect menuFrame = CGRectMake(0.0, 0.0, menuWidth, masterRect.size.height);
        CGRect contentFrame = CGRectMake(0.0, 0.0, masterRect.size.width, masterRect.size.height);
        
        self.menuLabelColor = [UIColor whiteColor];
        
        self.menuTableView = [[[UITableView alloc] initWithFrame:menuFrame] autorelease];
        self.menuTableView.dataSource = self;
        self.menuTableView.delegate = self;
        self.menuTableView.backgroundColor = [UIColor darkGrayColor];
        self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.menuTableView.separatorColor = [UIColor whiteColor];
                
        self.menuView = [[[UIView alloc] initWithFrame:menuFrame] autorelease];
        [self.menuView addSubview:self.menuTableView];
                
        self.contentView = [[[UIView alloc] initWithFrame:contentFrame] autorelease];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.contentView.backgroundColor = [UIColor grayColor];
        
        [self.view addSubview:self.menuView];
        [self.view insertSubview:self.contentView aboveSubview:self.menuView];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)toggleMenu
{
    
    [UIView beginAnimations:@"Menu Slide" context:nil];
    [UIView setAnimationDuration:0.2];
        
    if(self.contentView.frame.origin.x == 0) //Menu is hidden
    {
        CGRect newFrame = CGRectOffset(self.contentView.frame, self.menuView.frame.size.width, 0.0);
        self.contentView.frame = newFrame;
    }
    else //Menu is shown
    {
        [menuTableView reloadData];
        CGRect newFrame = CGRectOffset(self.contentView.frame, -(self.menuView.frame.size.width), 0.0);
        self.contentView.frame = newFrame;
    }
    
    [UIView commitAnimations];
}

-(JWNavigationController *)addViewController:(JWSlideMenuViewController *)controller withTitle:(NSString *)title andImage:(UIImage *)image
{
    JWNavigationController *navController = [[[JWNavigationController alloc] initWithRootViewController:controller] autorelease];
    navController.slideMenuController = self;
    navController.title = title;
    navController.tabBarItem.image = image;

    [self addChildViewController:navController];
    
    if([self.childViewControllers count] == 1)
    {
        [self.contentView addSubview:navController.view];
    }
    
    return navController;
}

#pragma mark - UITableViewDataSource/Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        // Do something here......................
    }
    
    //TODO: either support tabbaritem or a protocol in order to handle images in the menu.
    
    UIViewController *controller = (UIViewController *)[self.childViewControllers objectAtIndex:indexPath.row] ;
    cell.textLabel.text = controller.title;
    cell.textLabel.textColor = menuLabelColor;
    
    cell.imageView.image = controller.tabBarItem.image;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.childViewControllers count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    //UIViewController *previousChildViewController =
    //[self transitionFromViewController:previousChildViewController toViewController:newController duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:NULL completion:NULL];
    
    if([contentView.subviews count] == 1){
        [[contentView.subviews objectAtIndex:0] removeFromSuperview];
    }
    
    UIViewController* controller = (UIViewController*)[self.childViewControllers objectAtIndex:indexPath.row];
    controller.view.frame = self.contentView.bounds;
    
    [contentView addSubview:controller.view];
    [self toggleMenu];
}
 

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setMenuView:nil];
    [self setContentView:nil];
    [self setMenuTableView:nil];
    [self setMenuLabelColor:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc {
    [menuView release];
    [contentView release];
    [contentToolbar release];
    [menuTableView release];
    [menuLabelColor release];
    [super dealloc];
}
@end
