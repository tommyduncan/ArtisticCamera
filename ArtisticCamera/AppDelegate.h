//
//  AppDelegate.h
//  ArtisticCamera
//
//  Created by Tommy on 2017/6/12.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

