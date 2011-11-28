
Description
=========
My first attempt to duplicate the Facebook iOS app's menu functionality.

The code works, but is a bit more awkward to use than I would like. The idea is that the JWSlideMenuController is a controller container view that can have many child controllers (JWSlideMenuViewControllers) added to it. Each of the children controllers shows up as a menu option in the menu table view that can be toggled by the menu button.

All children added to JWSlideMenuController get set as rootViewControllers in a new instance of JWNavigationController.  JWNavigationController acts as a UINavigationController, but one that interacts with the JWSlideMenuController.


Usage
=====

1. Clone the repository.
2. Open the project in Xcode.
3. Open your project in Xcode.
4. Drag the JWSlideMenuController to your project.
5. See the code below.
6. See the sample projects for more.

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
    
    
What's Next?
===============
These items are being worked on next:

* Does not build to a library yet.