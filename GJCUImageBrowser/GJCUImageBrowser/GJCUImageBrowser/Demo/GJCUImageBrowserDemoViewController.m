//
//  GJCFImageBrowserDemoViewController.m
//  GJCommonFoundation
//
//  Created by ZYVincent on 14-10-30.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "GJCUImageBrowserDemoViewController.h"
#import "TVGDebugQuickUI.h"
#import "GJCFUitils.h"
#import "GJCFAssetsPickerViewController.h"

@interface GJCUImageBrowserDemoViewController ()<GJCUImageBrowserViewControllerDataSource,GJCFAssetsPickerViewControllerDelegate>

@property (nonatomic,strong)GJCUImageBrowserViewController *detailVC;

@property (nonatomic,strong)NSMutableArray *currentAssetsArray;

@end

@implementation GJCUImageBrowserDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentAssetsArray = [[NSMutableArray alloc]init];
    
    UIButton *pushDetail = [TVGDebugQuickUI buttonAddOnView:self.view title:@"推入浏览" target:self selector:@selector(pushBrowserDetail)];
    pushDetail.gjcf_top = 120;
    pushDetail.gjcf_left = 30;
    
    
    UIButton *presentDetail = [TVGDebugQuickUI buttonAddOnView:self.view title:@"模态浏览" target:self selector:@selector(presentBrowserDetail)];
    presentDetail.gjcf_top = 160;
    presentDetail.gjcf_left = 30;
    
    UIButton *pickAssets = [TVGDebugQuickUI buttonAddOnView:self.view title:@"选择照片" target:self selector:@selector(choosePhotos)];
    pickAssets.gjcf_top = 220;
    pickAssets.gjcf_left = 30;
    
    UIButton *presentAssetDetail = [TVGDebugQuickUI buttonAddOnView:self.view title:@"预览GJCFAsset" target:self selector:@selector(presentAssetsDetail)];
    presentAssetDetail.gjcf_top = 270;
    presentAssetDetail.gjcf_left = 30;
}

- (NSArray *)imageUrls
{
    return @[
             @"http://g.hiphotos.baidu.com/image/w%3D310/sign=c8e79be89c510fb378197196e933c893/377adab44aed2e73a5fe537d8501a18b87d6fa48.jpg",
             @"http://a.hiphotos.baidu.com/image/w%3D310/sign=a9da57abf503738dde4a0a23831ab073/f603918fa0ec08fa41e63bac5aee3d6d54fbdad2.jpg",
             @"http://a.hiphotos.baidu.com/image/w%3D310/sign=c7098e7673cf3bc7e800cbede100babd/0e2442a7d933c8957143ea00d21373f08202008f.jpg",
             @"http://h.hiphotos.baidu.com/image/w%3D310/sign=152abdeebc096b63811958513c328733/ac345982b2b7d0a213987e5cc9ef76094a369a99.jpg",
             @"http://d.hiphotos.baidu.com/image/w%3D310/sign=91a2b5cc19d5ad6eaaf962ebb1ca39a3/b64543a98226cffc5dae31babb014a90f603ea36.jpg",
             @"http://c.hiphotos.baidu.com/image/pic/item/8694a4c27d1ed21b7c0945ccae6eddc450da3fd2.jpg",
             @"http://h.hiphotos.baidu.com/image/pic/item/1ad5ad6eddc451daf63667c2b5fd5266d11632d2.jpg",
             @"http://b.hiphotos.baidu.com/image/pic/item/d058ccbf6c81800a509ae327b23533fa828b479f.jpg",
             @"http://g.hiphotos.baidu.com/image/pic/item/e61190ef76c6a7efa05481eefffaaf51f2de6683.jpg",
             @"http://h.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f4d66310de2fe9925bd317d83.jpg",
             @"http://f.hiphotos.baidu.com/image/pic/item/09fa513d269759ee28f84903b0fb43166c22df49.jpg",
             @"http://g.hiphotos.baidu.com/image/pic/item/38dbb6fd5266d0164f543f27942bd40735fa356b.jpg",
             @"http://d.hiphotos.baidu.com/image/pic/item/80cb39dbb6fd52662b5bd6d9a918972bd507368f.jpg",
             @"http://d.hiphotos.baidu.com/image/pic/item/11385343fbf2b21110296f83c88065380dd78efc.jpg",
             @"http://f.hiphotos.baidu.com/image/pic/item/b7fd5266d0160924567048d6d60735fae7cd34a2.jpg",
             @"http://b.hiphotos.baidu.com/image/pic/item/91529822720e0cf386fa966c0846f21fbe09aa1c.jpg",
             @"http://f.hiphotos.baidu.com/image/pic/item/6c224f4a20a4462344657cf59a22720e0df3d7fe.jpg",
             @"http://a.hiphotos.baidu.com/image/pic/item/8d5494eef01f3a2985120c599b25bc315d607c4b.jpg",
             @"http://b.hiphotos.baidu.com/image/pic/item/a8014c086e061d953b4befaf79f40ad162d9ca1c.jpg",
             @"http://h.hiphotos.baidu.com/image/pic/item/bd315c6034a85edf225627b44b540923dc54754b.jpg",
             @"http://f.hiphotos.baidu.com/image/pic/item/9922720e0cf3d7ca1e1ed0b2f01fbe096a63a90e.jpg",
             ];
}

- (void)pushBrowserDetail
{
    if (!self.detailVC) {
        self.detailVC = [[GJCUImageBrowserViewController alloc]initWithImageUrls:[self imageUrls]];
        self.detailVC.browserDataSource = self;
    }
    [self.navigationController pushViewController:self.detailVC animated:YES];
}

- (void)presentBrowserDetail
{
    GJCUImageBrowserNavigationViewController *detailVCNav = [[GJCUImageBrowserNavigationViewController alloc]initWithImageUrls:[self imageUrls]];
    detailVCNav.browserDataSource = self;
    [self presentViewController:detailVCNav animated:YES completion:nil];
    
}

- (void)choosePhotos
{
    GJCFAssetsPickerViewController *assetsViewController = [[GJCFAssetsPickerViewController alloc]init];
    assetsViewController.pickerDelegate = self;
    assetsViewController.mutilSelectLimitCount = 8;
    [self presentViewController:assetsViewController animated:YES completion:nil];
}

- (void)presentAssetsDetail
{
    GJCUImageBrowserNavigationViewController *detailVCNav = [[GJCUImageBrowserNavigationViewController alloc]initWithGJCFAssets:self.currentAssetsArray];
    detailVCNav.browserDataSource = self;
    [self presentViewController:detailVCNav animated:YES completion:nil];
}

- (UIView *)imageBrowserShouldCustomBottomToolBar:(GJCUImageBrowserViewController *)browserController
{
    UIButton *removeImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    removeImageButton.frame = CGRectMake((GJCFSystemScreenWidth - 100)/2, GJCFSystemScreenHeight - 35 - 20, 100, 35);
    [removeImageButton setTitle:@"删除" forState:UIControlStateNormal];
    removeImageButton.backgroundColor = [UIColor orangeColor];
    removeImageButton.layer.cornerRadius = 6.f;
    [removeImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [removeImageButton addTarget:self action:@selector(removeImage) forControlEvents:UIControlEventTouchUpInside];
    
    return removeImageButton;
}

- (void)removeImage
{
    [self.detailVC removeImageAtIndex:self.detailVC.pageIndex];
}

- (void)imageBrowser:(GJCUImageBrowserViewController *)browserController didFinishRemoveAtIndex:(NSInteger)index
{
}

- (UIView *)imageBrowserShouldCustomRightNavigationBarItem:(GJCUImageBrowserViewController *)browserController
{
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.frame = (CGRect){0,0,40,20};
    [checkButton setTitle:@"责任" forState:UIControlStateNormal];
    [checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [checkButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return checkButton;
}

- (void)rightButtonClick
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"click" message:[NSString stringWithFormat:@"点击了%d",self.detailVC.pageIndex] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - GJCFAssetsPickerDelegate

- (void)pickerViewController:(GJCFAssetsPickerViewController *)pickerViewController didFinishChooseMedia:(NSArray *)resultArray
{
    [self.currentAssetsArray addObjectsFromArray:resultArray];
    [pickerViewController dismissPickerViewController];
}

- (void)pickerViewController:(GJCFAssetsPickerViewController *)pickerViewController didReachLimitSelectedCount:(NSInteger)limitCount
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"超过限制%d张数",limitCount] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)pickerViewControllerRequirePreviewButNoSelectedImage:(GJCFAssetsPickerViewController *)pickerViewController
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请选择要预览的图片"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)pickerViewControllerPhotoLibraryAccessDidNotAuthorized:(GJCFAssetsPickerViewController *)pickerViewController
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请授权访问你的相册"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

@end
