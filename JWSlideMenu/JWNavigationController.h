//
//  JWNavigationController.h
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/22/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JWSlideMenuController;

@interface JWNavigationController : UIViewController <UINavigationBarDelegate>

@property (nonatomic, retain) UINavigationBar *navigationBar;
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) JWSlideMenuController *slideMenuController;
@property (nonatomic, retain, readonly) UIViewController *rootViewController;

- (id)initWithRootViewController:(UIViewController *)rootViewController;
- (void)pushViewController:(UIViewController *)controller;
- (UIViewController *)popViewController;

@end
