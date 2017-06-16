//
//  FilterViewController.m
//  ArtisticCamera
//
//  Created by Tommy on 2017/6/13.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "FilterViewController.h"
#import <Social/Social.h>
#import "UIView+Toast.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.previewImageView.image = self.pendingImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)orginal:(UIButton *)sender {
    self.resultImage = self.pendingImage;
    self.previewImageView.image = self.resultImage;
}

- (IBAction)filter1:(UIButton *)sender {
    self.resultImage = [self sourceImage:self.pendingImage index:1];
    self.previewImageView.image = self.resultImage;
}

- (IBAction)darken:(UIButton *)sender {
    self.resultImage = [self sourceImage:self.pendingImage index:2];
    self.previewImageView.image = self.resultImage;
}

- (IBAction)hueAdjust:(id)sender {
    self.resultImage = [self sourceImage:self.pendingImage index:3];
    self.previewImageView.image = self.resultImage;
}

- (IBAction)mono:(id)sender {
    self.resultImage = [self sourceImage:self.pendingImage index:4];
    self.previewImageView.image = self.resultImage;
}
- (IBAction)saveImage:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.resultImage, nil, nil, nil);
    [self.view makeToast:@"相片儲存成功！"
                duration:2.0
                position:CSToastPositionBottom];
}

- (IBAction)shareImage:(id)sender {
    // 判斷社群網站的服務是否可用
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        // 建立對應社群網站的ComposeViewController
        SLComposeViewController *mySocialComposeView = [[SLComposeViewController alloc] init];
        mySocialComposeView = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        // 插入文字
        [mySocialComposeView setInitialText:@"iOS期末專案展演！！"];
        
        // 插入網址
        /*NSURL *myURL = [[NSURL alloc] initWithString:@"https://cg2010studio.wordpress.com/"];
        [mySocialComposeView addURL: myURL];*/
        
        // 插入圖片
        UIImage *myImage = self.resultImage;
        [mySocialComposeView addImage:myImage];
        
        // 呼叫建立的SocialComposeView
        [self presentViewController:mySocialComposeView animated:YES completion:^{
            NSLog(@"成功呼叫 SocialComposeView");
        }];
        
        // 訊息成功送出與否的之後處理
        [mySocialComposeView setCompletionHandler:^(SLComposeViewControllerResult result){
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"取消送出");
                    break;
                case SLComposeViewControllerResultDone:
                    [self.view makeToast:@"相片成功分享至Facebook！"
                                duration:2.0
                                position:CSToastPositionBottom];
                    NSLog(@"完成送出");
                    break;
                default:
                    NSLog(@"其他例外");
                    break;
            }
        }];
    }
    else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"請先在系統設定中登入臉書帳號。" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [av show];
    }
}

- (IBAction)back2Root:(UIButton *)sender {
    [self performSegueWithIdentifier:@"Filter_to_Root" sender:self];
}

-(UIImage *)sourceImage:(UIImage *)image index:(NSInteger)index {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciSourceImage = [[CIImage alloc] initWithImage:self.pendingImage];
    CIFilter *filter;
    switch(index){
        case 0:
            break;
        case 1:    // 飽和, 對比, 亮度
            filter = [CIFilter filterWithName:@"CIColorControls"];
            [filter setValue:ciSourceImage forKey:kCIInputImageKey];
            [filter setValue:@(1.1) forKey:kCIInputSaturationKey];
            [filter setValue:@(1.1) forKey:kCIInputContrastKey];
            [filter setValue:@(0.0) forKey:kCIInputBrightnessKey];
            break;
        case 2:    // 黯淡
            filter = [CIFilter filterWithName:@"CIPhotoEffectFade"];
            [filter setValue:ciSourceImage forKey:kCIInputImageKey];
            break;
        case 3:    // 飽和
            filter = [CIFilter filterWithName:@"CIHueAdjust"];
            [filter setValue:ciSourceImage forKey:kCIInputImageKey];
            [filter setValue:@(3.14) forKey:kCIInputAngleKey];
            break;
        case 4:
            filter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
            [filter setValue:ciSourceImage forKey:kCIInputImageKey];
            break;
        default:
            break;
    }
    
    // 得到過濾後的圖片
    CIImage *outputImage = [filter outputImage];
    
    // 轉換圖片
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    self.previewImageView.image = newImage;
    
    // 釋放 C 對象
    CGImageRelease(cgImage);
    
    return newImage;
}
@end
