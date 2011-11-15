//
//  JWSlideMenuController.h
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/14/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWSlideMenuController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *menuTableView;
    UIView *menuView;
    UIToolbar *contentToolbar;
    UIView *contentWrapperView;
    UIBarButtonItem *menuButton;

}
@property (retain, nonatomic) UITableView *menuTableView;
@property (retain, nonatomic) UIView *menuView;
@property (retain, nonatomic) UIToolbar *contentToolbar;
@property (retain, nonatomic) UIView *contentWrapperView;
@property (retain, nonatomic) UIView *contentView;
@property (retain, nonatomic) UIBarButtonItem *menuButton;

-(IBAction)toggleMenu;
-(void)addViewController:(UIViewController *)controller;

@end
