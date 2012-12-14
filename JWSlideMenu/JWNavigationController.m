//
//  JWNavigationController.m
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/22/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import "JWNavigationController.h"
#import "JWSlideMenuViewController.h"

@interface JWNavigationController(Private)

-(UIViewController*)removeTopViewController;

@end

@implementation JWNavigationController

@synthesize navigationBar;
@synthesize contentView;
@synthesize slideMenuController;
@synthesize rootViewController=_rootViewController;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        
        CGRect masterRect = [[UIScreen mainScreen] bounds];
        
        CGRect contentFrame = CGRectMake(0.0, 44.0, masterRect.size.width, masterRect.size.height - 44.0);
        CGRect navBarFrame = CGRectMake(0.0, 0.0, masterRect.size.width, 44.0);
        
        self.view = [[[UIView alloc] initWithFrame:masterRect] autorelease];
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.view.backgroundColor = [UIColor magentaColor];
        
        self.contentView = [[[UIView alloc] initWithFrame:contentFrame] autorelease];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.contentView];
        
        self.navigationBar = [[[UINavigationBar alloc] initWithFrame:navBarFrame] autorelease];
        self.navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.navigationBar.delegate = self;
        [self.view insertSubview:self.navigationBar aboveSubview:self.contentView];
        
    }
    return self;
}


- (id)initWithRootViewController:(JWSlideMenuViewController *)rootViewController
{
    self = [self init];
    if(self) {
        _rootViewController = rootViewController;
        UIBarButtonItem *menuButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon_20x20.png"] style:UIBarButtonItemStyleBordered target:self.slideMenuController action:@selector(toggleMenu)] autorelease];
        rootViewController.navigationItem.leftBarButtonItem = menuButton;
        [self addChildViewController:rootViewController];
        [self.contentView addSubview:rootViewController.view];
        [self.navigationBar pushNavigationItem:rootViewController.navigationItem animated:YES];
        rootViewController.navigationController = self;
    }
    return self;
}

#pragma mark - UINavigationBarDelegate

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item
{
    UIViewController *controller = [self.childViewControllers lastObject];
    
    if (item==controller.navigationItem) //Will now called only if a back button pop happens, not in manual pops
    {
        [self removeTopViewController];
    }
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item
{
    
}

#pragma mark - Stack Interaction

- (void)pushViewController:(JWSlideMenuViewController *)controller
{
    [self addChildViewController:controller];
    [self.navigationBar pushNavigationItem:controller.navigationItem animated:YES];
    controller.navigationController = self;
    
    controller.view.frame = self.contentView.bounds;
    
    if([self.childViewControllers count] == 1)
    {
        [self.contentView addSubview:controller.view];
    }
    else
    {
        UIViewController *previousController = [self.childViewControllers   objectAtIndex:[self.childViewControllers count]-2];
        [self transitionFromViewController:previousController toViewController:controller duration:0.5 options:UIViewAnimationOptionTransitionNone animations:NULL completion:NULL];
     }
}

- (UIViewController *)popViewController
{
    //Can use this to pop manually rather than back button alone
    UIViewController *controller = [self.childViewControllers lastObject];
    UIViewController *previousController = nil;
    if([self.childViewControllers count] > 1)
    {
        previousController = [self.childViewControllers objectAtIndex:[self.childViewControllers count]-2];
        previousController.view.frame = self.contentView.bounds;
    }
    
    [self transitionFromViewController:controller toViewController:previousController duration:0.3 options:UIViewAnimationOptionTransitionNone animations:NULL completion:NULL];
    [controller removeFromParentViewController];
   
    if(self.navigationBar.items.count > self.childViewControllers.count)
        [self.navigationBar popNavigationItemAnimated:YES];
   
    return controller;
}

- (void)viewDidUnload
{
    _rootViewController = nil;
    self.navigationBar = nil;
    self.contentView = nil;
    
    self.slideMenuController = nil;
    
    [super viewDidUnload];
}

- (void)dealloc {
    [_rootViewController release];
    [navigationBar release];
    [contentView release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(UIViewController*)removeTopViewController
{
    UIViewController *controller = [self.childViewControllers lastObject];
    
    UIViewController *previousController = nil;
    if([self.childViewControllers count] > 1)
    {
        previousController = [self.childViewControllers objectAtIndex:[self.childViewControllers count]-2];
        previousController.view.frame = self.contentView.bounds;
        
        
    }
    
    
    [self transitionFromViewController:controller toViewController:previousController duration:0.3 options:UIViewAnimationOptionTransitionNone animations:NULL completion:NULL];
    [controller removeFromParentViewController];
    
    return controller;
}

@end
