
Description
=========
My first attempt to duplicate the Facebook iOS app's menu functionality.

The code works, but is a bit more awkward to use than I would like. The idea is that the JWSlideMenuController is a controller container view that can have many child controllers (JWSlideMenuViewControllers) added to it. Each of the children controllers shows up as a menu option in the menu table view that can be toggled by the menu button.

All children added to JWSlideMenuController get set as rootviewControllers in a new instance of JWNavigationController.  JWNavigationController acts as a UINavigationController, but one that interacts with the JWSlideMenuController.

What is not working
===============
These items are being worked on next:
* Does not yet support displaying the images for the menu items.
* Does not build to a library yet.


Use Example
==========

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
        self.window.backgroundColor = [UIColor whiteColor];
        
        //Create a new JWSlideMenuConroller container
        JWSlideMenuController *slideMenu = [[[JWSlideMenuController alloc] init] autorelease];
        
        //Create a child controller to add to it.
        //This needs to be a subclass of JWSlideMenuViewController, which is a subclass of UIViewController
        JWSlideMenuViewController *f = [[[FirstHDViewController alloc]initWithNibName:@"FirstHDViewController" bundle:nil] autorelease];
        
        //Add the child controller to the container controller
        [slideMenu addViewController:f withTitle:@"First" andImage:nil];
        
        //Set the window's rootViewController to the container.
        self.window.rootViewController = slideMenu;
        
        [self.window makeKeyAndVisible];
        return YES;
    }