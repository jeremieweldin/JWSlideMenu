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
    //NSArray *childControllers;

    IBOutlet UITableView *menuTableView;
    IBOutlet UIView *menuView;
    IBOutlet UIView *contentWrapperView;
    IBOutlet UIBarButtonItem *menuButton;

}
@property (retain, nonatomic) IBOutlet UITableView *menuTableView;
@property (retain, nonatomic) IBOutlet UIView *menuView;
@property (retain, nonatomic) IBOutlet UIView *contentWrapperView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *menuButton;

-(IBAction)toggleMenu;
-(void)addViewController:(UIViewController *)controller;

@end
