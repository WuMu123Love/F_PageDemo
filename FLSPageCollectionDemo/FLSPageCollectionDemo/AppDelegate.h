//
//  AppDelegate.h
//  FLSPageCollectionDemo
//
//  Created by 天立泰 on 2018/10/23.
//  Copyright © 2018年 天立泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

