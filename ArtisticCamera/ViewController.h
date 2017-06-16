//
//  ViewController.h
//  ArtisticCamera
//
//  Created by Tommy on 2017/6/12.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImage *pickedImage;

- (IBAction)takePicture:(UIButton *)sender;
- (IBAction)gotoAlbum:(UIButton *)sender;


@end

