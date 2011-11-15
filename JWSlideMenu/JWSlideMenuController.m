//
//  JWSlideMenuController.m
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/14/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

//TODO: remove the xib and do all the layout in initwithnib or viewdidload

#import "JWSlideMenuController.h"

@implementation JWSlideMenuController

@synthesize menuTableView;
@synthesize menuView;
@synthesize contentWrapperView;
@synthesize contentView;
@synthesize menuButton;

- (id)init
{
    self = [super init];
    if (self) {
        
        CGRect masterRect = self.view.bounds;
        
        CGRect menuFrame = CGRectMake(0.0, 0.0, masterRect.size.width - 53, masterRect.size.height);
        CGRect contentWrapperFrame = CGRectMake(0.0, 0.0, masterRect.size.width, masterRect.size.height);
        CGRect contentFrame = CGRectMake(0.0, 44.0, masterRect.size.width, masterRect.size.height - 44);
        CGRect toolbarFrame = CGRectMake(0.0, 0.0, masterRect.size.width, 44);
        
        self.menuTableView = [[UITableView alloc] initWithFrame:menuFrame];
        self.menuTableView.dataSource = self;
        self.menuTableView.delegate = self;
        self.menuView = [[UIView alloc] initWithFrame:menuFrame];
                
        self.contentWrapperView = [[UIView alloc] initWithFrame:contentWrapperFrame];
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
        toolBar.tintColor = [UIColor redColor];
        self.menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon_20x20.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(toggleMenu)];
        [toolBar setItems:[NSArray arrayWithObject:self.menuButton] animated:YES];
        self.contentView = [[UIView alloc] initWithFrame:contentFrame];
        self.contentView.backgroundColor = [UIColor grayColor];
        
        [self.menuView addSubview:self.menuTableView];
        
        [self.contentWrapperView addSubview:toolBar];
        [self.contentWrapperView insertSubview:self.contentView aboveSubview:toolBar];
        
        [self.view addSubview:self.menuView];
        [self.view insertSubview:self.contentWrapperView aboveSubview:self.menuView];
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
    
    //TODO: either support tabbaritem or a protocol in order to handle images in the menu.
    
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
//    UIToolbar *toolbar = [[UIToolbar alloc] init];
//    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
//    NSMutableArray *items = [[NSMutableArray alloc] init];
//    [items addObject:[[[UIBarButtonItem alloc] initWith....] autorelease]];
//    [toolbar setItems:items animated:NO];
//    [items release];
//    [self.view addSubview:toolbar];
//    [toolbar release];
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
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
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
