//
//  JWSlideMenuController.m
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/14/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import "JWSlideMenuController.h"

@implementation JWSlideMenuController
@synthesize menuTableView;
@synthesize menuView;
@synthesize contentWrapperView;
@synthesize contentView;
@synthesize menuButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

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
        
    if(self.contentWrapperView.frame.origin.x == 0) //Menu is hidden
    {
        CGRect newFrame = CGRectOffset(self.contentWrapperView.frame, self.menuView.frame.size.width, 0.0);
        self.contentWrapperView.frame = newFrame;
    }
    else //Menu is shown
    {
        [menuTableView reloadData];
        CGRect newFrame = CGRectOffset(self.contentWrapperView.frame, -(self.menuView.frame.size.width), 0.0);
        self.contentWrapperView.frame = newFrame;
    }
    
    [UIView commitAnimations];
}

-(void)addViewController:(UIViewController *)controller
{
    [self addChildViewController:controller];
    
}

//- (void)switchToNewController:(UIViewController *)newController
//{   
//    if([self.childViewControllers count] == 0)
//    {
//        [self addChildViewController:newController];
//        [self.backsplash addSubview:newController.view];
//        newController.view.frame = self.backsplash.frame;
//        
//    }
//    else
//    {
//        UIViewController *previousChildViewController = [self.childViewControllers objectAtIndex:0];
//        [self addChildViewController:newController];
//        [self transitionFromViewController:previousChildViewController toViewController:newController duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:NULL completion:NULL];
//        
//        newController.view.frame = self.backsplash.frame;
//        
//        [previousChildViewController removeFromParentViewController];
//        [previousChildViewController release];
//    }
//}

#pragma mark -UITableViewDataSource/Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                      reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // Do something here......................
    }
    
    UIViewController *controller = (UIViewController *)[self.childViewControllers objectAtIndex:indexPath.row];
    cell.textLabel.text = controller.title;
    
    //[controller release];
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
    if([contentView.subviews count] == 1)
    {
        [[contentView.subviews objectAtIndex:0] removeFromSuperview];
    }
    [contentView addSubview:((UIViewController *)[self.childViewControllers objectAtIndex:indexPath.row]).view];
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
    [self setContentWrapperView:nil];
    [self setMenuButton:nil];
    [self setMenuTableView:nil];
    [self setContentView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [menuView release];
    [contentWrapperView release];
    [menuButton release];
    [menuTableView release];
    [contentView release];
    [super dealloc];
}
@end
