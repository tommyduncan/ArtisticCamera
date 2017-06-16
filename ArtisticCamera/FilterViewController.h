//
//  FilterViewController.h
//  ArtisticCamera
//
//  Created by Tommy on 2017/6/13.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController
@property (nonatomic, strong) UIImage *pendingImage;
@property (nonatomic, strong) UIImage *resultImage;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

- (IBAction)orginal:(UIButton *)sender;
- (IBAction)filter1:(UIButton *)sender;
- (IBAction)darken:(UIButton *)sender;
- (IBAction)back2Root:(UIButton *)sender;
@end
