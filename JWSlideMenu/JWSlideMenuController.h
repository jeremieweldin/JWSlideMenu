//
//  JWSlideMenuController.h
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/14/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JWNavigationController;
@class JWSlideMenuViewController;

@interface JWSlideMenuController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) UITableView *menuTableView;
@property (retain, nonatomic) UIView *menuView;
@property (retain, nonatomic) UIToolbar *contentToolbar;
@property (retain, nonatomic) UIView *contentView;
@property (retain, nonatomic) UIColor *menuLabelColor;

-(IBAction)toggleMenu;
-(JWNavigationController *)addViewController:(JWSlideMenuViewController *)controller withTitle:(NSString *)title andImage:(UIImage *)image;


@end
