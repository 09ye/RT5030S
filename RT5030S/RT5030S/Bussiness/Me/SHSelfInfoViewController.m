//
//  SHSelfInfoViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHSelfInfoViewController.h"
#import "SHTitleHorizontalViewCell.h"

@interface SHSelfInfoViewController ()

@end

@implementation SHSelfInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
   
    detail = [[NSMutableDictionary alloc]init];
    if ([[self.intent.args objectForKey:@"classType"]isEqualToString:@"regist"]) {
        UIButton * searchButton = [[UIButton alloc] initWithFrame:CGRectMake(75, self.view.frame.size.height-200, 170, 35)];
        searchButton.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorTextBlue"];
        [searchButton setTitle:@"完成注册" forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(registOnTouch) forControlEvents:UIControlEventTouchUpInside];
        searchButton.layer.cornerRadius = 3;
        searchButton.layer.masksToBounds = YES;
        searchButton.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin);
        [self.view insertSubview:searchButton aboveSubview:self.tableView];
        edit = YES;
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" target:self action:@selector(editInfo)];
    }
    mResult = [[NSMutableDictionary alloc]init];
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"queryInfo.jhtml");
    post.postData = [Utility createPostData:dic];
    [post start:^(SHTask *task ) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
        
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 && indexPath.section == 0){
        return 76;
    }
    return CELL_GENERAL_HEIGHT2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (  section == 1&&[[self.intent.args objectForKey:@"classType"]isEqualToString:@"regist"]) {
        return 2;
    }
    return 5;
}

-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHTitleHorizontalViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"table_horizontal_cell"];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHTitleHorizontalViewCell" owner:nil options:nil] objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
      
    }
    cell.editing = NO;
    cell.imgPhone.hidden = YES;
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            cell.imgPhone.hidden = NO;
            cell.labTitle.text = @"头像";
            CGRect rect = cell.labTitle.frame;
            rect.origin.y = 21;
            cell.labTitle.frame = rect;
            UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeLogoAction)];
            cell.imgPhone.userInteractionEnabled = YES;
//            cell.imgPhone = imgPhoto;
            [cell.imgPhone  setUrl:[detail objectForKey:@"headImg"]];
            [cell.imgPhone addGestureRecognizer:tapGr];
            
        }else if(indexPath.row == 1){
            cell.labTitle.text = @"昵称";
            cell.txtContent.text = [detail objectForKey:@"nickName"];
            cell.editing = edit;
        }else if(indexPath.row == 2){
            cell.labTitle.text = @"年龄";
            cell.txtContent.text = [[detail objectForKey:@"age"] stringValue];
            cell.editing = edit;
        }else if(indexPath.row == 3){
            cell.labTitle.text = @"性别";// ????
            cell.txtContent.text = mSexName;
        }else if(indexPath.row == 4){
            cell.labTitle.text = @"身高";
            cell.txtContent.text = [[detail objectForKey:@"height"]stringValue];
            cell.editing = edit;
        }
    }else if (indexPath.section == 1){
        if(indexPath.row == 0){
            cell.labTitle.text = @"邮箱";
            cell.txtContent.text = [detail objectForKey:@"email"];;
            cell.editing = edit;
        }else if(indexPath.row == 1){
            cell.labTitle.text = @"地区";
            cell.txtContent.text = [detail objectForKey:@"area"];;
            cell.editing = edit;
        }else if(indexPath.row == 2){
            
            cell.labTitle.text = @"家庭成员切换";
            cell.txtContent.text = @"";
        }else if(indexPath.row == 3){
            cell.labTitle.text = @"修改密码";
            cell.txtContent.text = @"";
        }else if(indexPath.row == 4){
            cell.labTitle.text = @"切换账户";
            cell.txtContent.text = @"";
        }
    }
  
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        if(indexPath.row == 3){// 选择性别
            SHIntent * intent = [[SHIntent alloc ]init];
            intent.target = @"SHSexSelectViewController";
            if ([mSexName isEqualToString:@"女"]) {
                [intent.args setValue:@"F" forKey:@"sex"];
            }else{
                [intent.args setValue:@"M" forKey:@"sex"];
            }
            intent.container = self.navigationController;
            intent.delegate = self;
            [[UIApplication sharedApplication] open:intent];
        }
        
    }else if (indexPath.section == 1 ) {
        if (indexPath.row == 3) {// 修改密码
            SHIntent * intent = [[SHIntent alloc ]init];
            intent.target = @"SHUpdatePasswordViewController";
            intent.container = self.navigationController;
            [[UIApplication sharedApplication] open:intent];
        }
    }
    
}
-(void)sexSelectViewControllerDidSelect:(SHSexSelectViewController *) controll sex:(NSString * )sex
{
    if ([sex isEqualToString:@"F"]) {
        mSexName = @"女";
        [detail setValue:@"F" forKey:@"gender"];
    }else{
        mSexName = @"男";
        [detail setValue:@"M" forKey:@"gender"];
    }

    NSIndexPath *index= [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:YES];
}
-(void)registOnTouch
{
    

    for (int i = 1 ;i <5; i++) {
        SHTitleHorizontalViewCell * cell = (SHTitleHorizontalViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (i ==1 ) {
            if ([cell.txtContent.text isEqualToString:@""]) {
                [self showAlertDialog:@"昵称不能为空"];
                return;
            }
            [detail setValue:cell.txtContent.text forKey:@"nickName"];
            
        }else if(i == 2){
            if ([cell.txtContent.text isEqualToString:@""]) {
                [self showAlertDialog:@"年龄不能为空"];
                return;
            }
            [detail setValue:cell.txtContent.text forKey:@"age"];

            
        }else if (i ==3){
            if ([cell.txtContent.text isEqualToString:@""]) {
                [self showAlertDialog:@"性别不能为空"];
                return;
            }
            [detail setValue:cell.txtContent.text forKey:@"gender"];
        }else if (i ==4){
            if ([cell.txtContent.text isEqualToString:@""]) {
                [self showAlertDialog:@"身高不能为空"];
                return;
            }
            [detail setValue:cell.txtContent.text  forKey:@"height"];
        }
    }
    for (int i = 0 ;i <2; i++) {
        SHTitleHorizontalViewCell * cell = (SHTitleHorizontalViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
        if (i ==0 ) {
            if ([cell.txtContent.text isEqualToString:@""]) {
                [self showAlertDialog:@"邮箱不能为空"];
                return;
            }
            if ( ![SHTools isValidateEmail:cell.txtContent.text]) {
                [self showAlertDialog:@"您输入的是邮箱吗？"];
                return;
            }
            [detail setValue:cell.txtContent.text forKey:@"email"];
            
        }else if(i == 1){
            if ([cell.txtContent.text isEqualToString:@""]) {
                [self showAlertDialog:@"年龄不能为空"];
                return;
            }
            [detail setValue:cell.txtContent.text forKey:@"area"];
        }
        
    }

    [self showWaitDialogForNetWork];
    SHPostTaskM *task = [[SHPostTaskM alloc]init];
    task.tag = 1;
    task.delegate = self;
    task.URL = URL_FOR(@"completeInfo.jhtml");
    [detail setValue:SHEntironment.instance.userId forKey:@"userId"];
    task.postData = [Utility createPostData:detail];
    [task start];

}
-(void) editInfo
{
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" target:self action:@selector(sumbit)];
    edit = YES;
    [self.tableView reloadData];
    
}
-(void) sumbit
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" target:self action:@selector(editInfo)];
    edit = NO;
    [self.tableView reloadData];
}
-(void) taskDidFinished:(SHTask *)task
{
    
    [self dismissWaitDialog];
    if (task.tag == 1) {// 完成注册
         [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
    }
   
}
-(void) taskDidFailed:(SHTask *)task
{
    [self dismissWaitDialog];
    [task.respinfo show];
}
#pragma  mark  修改 背后logo

-(void)changeLogoAction{
        AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
        //user/updateUserAvatar  data{string } encode by base64
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"拍照", @"从相册中选取", nil];
        choiceSheet.tag=11;
        [choiceSheet showInView:app.viewController.view];
    
    
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    
    if (buttonIndex == 0) {
        // 拍照
        
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            
            [app.viewController  presentViewController:controller
                                              animated:YES
                                            completion:^(void){
                                                NSLog(@"Picker View Controller is presented");
                                            }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [app.viewController presentViewController:controller
                                             animated:YES
                                           completion:^(void){
                                               NSLog(@"Picker View Controller is presented");
                                           }];
        }
    }
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
#pragma  mark   选取Logos图片 截取 相关代码

#pragma mark  =＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark VPImageCropperDelegate

- (void)imageCropper:(SHImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    imgPhoto.image = editedImage;
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
        // TO DO  这里 开始更新 背景
        
        [self uploadCustomImage:editedImage];
        
        
    }];
    
}

- (void)imageCropperDidCancel:(SHImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma  mark 上传用户自定义背景  task  tag  99

-(void) uploadCustomImage:(UIImage  *)img{
    
    [self showWaitDialogForNetWork];
    
    // 请求修改{initiator,partake,fcode,favorite,cash, property,}
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    //user/updateUserBgImage
    post.URL = URL_FOR(@"uploaddata");
    post.delegate = self;
    //｛session_id,data{encode_image(bas   e64)}｝
    NSData *dataObj = UIImageJPEGRepresentation(img, 1.0);
    NSString  *base64String= [ Base64 encode: dataObj];
    [post.postArgs setValue:@"image"  forKey:@"type"];
    [post.postArgs setValue:base64String  forKey:@"data"];
    post.tag = 99;
    [post start];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    BOOL camera = NO;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera && picker.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        camera = YES;//iphone4 前置摄像头反向
    }else{
        camera = NO;
    }
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        SHImageCropperViewController *imgEditorVC = [[SHImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:1.0];
        imgEditorVC.delegate = self;
        imgEditorVC.isCamera = camera;
        [app.viewController presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO  上传图片到服务起 lqh77
            
            
            
        }];
    }];
}




- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}
- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
