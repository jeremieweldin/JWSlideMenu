
Description
=========

Use Example
==========

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
        self.window.backgroundColor = [UIColor whiteColor];
        
        JWSlideMenuViewController *f = [[[FirstHDViewController alloc]initWithNibName:@"FirstHDViewController" bundle:nil] autorelease];
        JWSlideMenuController *slideMenu = [[[JWSlideMenuController alloc] init] autorelease];
        [slideMenu addViewController:f withTitle:@"First" andImage:nil];
        self.window.rootViewController = slideMenu;
        
        [self.window makeKeyAndVisible];
        return YES;
    }