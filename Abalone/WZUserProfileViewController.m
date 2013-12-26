//
//  WZUserProfileViewController.m
//  MyCard
//
//  Created by 吾在 on 13-3-20.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUserProfileViewController.h"
#import "WZUser+Me.h"
#import "WZUser+Gender.h"
#import "WZProfileModifier.h"
#import "WZUser+Networks.h"
#import "NSString+Format.h"
#import "UIWindow+Lock.h"
#import "ImageUtil.h"
#import "WZPICUpload.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJsonParser.h"
#import "CreateWeiboViewController.h"

@interface WZUserProfileViewController () <UIActionSheetDelegate,UIAlertViewDelegate>
{
    CreateWeiboViewController *createWeiboViewController;
}
- (NSString *)warning;

- (void)record;
- (void)reload;
- (void)succeed:(NSNotification *)notification;
- (void)failed:(NSNotification *)notification;

@end

@implementation WZUserProfileViewController
NSString *faceImageId,*imgServerId,*imageFullPath;

@synthesize nameField = _nameField;
@synthesize genderSwitch = _genderSwitch;
@synthesize emailField = _emailField;
@synthesize birthButton = _birthButton;
@synthesize realName =_realName;
@synthesize faceImageView=_faceImageView;



- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section==0&&indexPath.row==0) {
//        [self login];
//    }
//    else if (indexPath.section==1&&indexPath.row==1) {
//        [self recommend];
//    }
//    else if (indexPath.section==1&&indexPath.row==2) {
//        [self recommendUser];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
        [[WZProfileModifier modifier] invalid];
}
#pragma mark - 
- (NSString *)warning
{
    NSString *warning = nil;
    if (_emailField.text.length  && ![_emailField.text isValidEmail]) {
        warning = @"邮箱不合法";
    }
    return warning;
}

- (void)reload
{
    WZUser *user = [WZUser me];
    _nameField.text = user.name;
    _genderSwitch.on = [user isMale];
    _emailField.text = user.email;
    _realName.text = user.username;//真实姓名
    NSDate *birth = user.birth;
    
    if (!avatarImage)
    {
        if (user.faceIcon)
        {
            self.faceImageView.imageURL = [NSURL URLWithString:user.faceIcon];
        }
        else
        {
            self.faceImageView.image = [UIImage imageNamed:@"defAvatar.png"];
        }
        self.faceImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeFaceIcon:)];
        [self.faceImageView addGestureRecognizer:singleTap1];
    }
    
    if (birth) {
        static NSDateFormatter *birthdayDateFormatter = nil;
        if (!birthdayDateFormatter) {
            birthdayDateFormatter = [NSDateFormatter new];
            birthdayDateFormatter.dateFormat = @"yyyy-MM-dd";
        }
        NSString *string =  [birthdayDateFormatter stringFromDate:birth];
        [self.birthButton setTitle:string forState:UIControlStateNormal];
        [self.birthButton setTitle:string forState:UIControlStateHighlighted];
    }
    else
    {
        [self.birthButton setTitle:@"请选择生日" forState:UIControlStateNormal];
        [self.birthButton setTitle:@"请选择生日" forState:UIControlStateHighlighted];
    }
    
}

- (void)record
{
    WZProfileModifier *modifier = [WZProfileModifier modifier];
    [modifier prepareChange:_nameField.text forKey:kWZUserProfileNameKey];
    //[modifier prepareChange:_qianming.text forKey:KWZUserProfileQianming];

    //[self setSwitch:_genderSwitch onText:"是" offText:"否"];
    
    
    [modifier prepareChange:_emailField.text forKey:kWZUserProfileEmailKey];
    
    NSString *value = [_genderSwitch isOn]?@"男":@"女";
    [modifier prepareChange:value forKey:kWZUserProfileGenderKey];
    [modifier prepareChange:_realName.text forKey:KWZuserProfileRealNameKey];
    
    if (faceImageId)
    {
        [modifier prepareChange:faceImageId forKey:KWZUserProfileFaceIconKey];
    }
    if (imageFullPath)
    {
        [modifier prepareChange:imageFullPath forKey:KWZuserProfilePicKey];
    }
}
#pragma mark -
- (IBAction)logout:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定注销" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)_logout
{
    [self closeKeyboard:nil];
    [WZUser leave];
    if (self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.firstOtherButtonIndex==buttonIndex) {
        [self _logout];
    }
}

#pragma mark -
- (IBAction)update:(id)sender
{
    [self closeKeyboard:nil];
    NSString  *fullPath=@"";
    NSLog(@"%@",createWeiboViewController.imagePathArray);
    if (createWeiboViewController)
    {
        if (createWeiboViewController.imagePathArray.count !=0)
        {
            for (int i =0; i<createWeiboViewController.imagePathArray.count ;i++)
            {
                NSString *path = [createWeiboViewController.imagePathArray objectAtIndex:i];
                if (i == createWeiboViewController.imagePathArray.count - 1)
                {
                    fullPath = [fullPath stringByAppendingString:path];
                }
                else
                {
                    fullPath = [fullPath stringByAppendingString:path];
                    fullPath = [ fullPath stringByAppendingString:@","];

                }
            }
        }
    }
    imageFullPath = fullPath;
//    NSString *warning = [self warning];
//    if (warning) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:warning delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//        [alert show];
//    }
//    else {
        [self record]; //判断并记录是否有更改
        if ([WZProfileModifier modifier].changes) {
            [UIWindow lock];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succeed:) name:WZUserProfileUpdateSucceedNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failed:) name:WZUserProfileUpdateFailedNotification object:nil];
            WZUser *user = [WZUser me];
            NSLog(@"qian userfaceIcon==%@",user.faceIcon);

            [[WZUser me] update];
            user = [WZUser me];
            NSLog(@"hout userfaceIcon==%@",user.faceIcon);

        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没有改动" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }
//    }
}

- (IBAction)cancel:(id)sender
{
    [self closeKeyboard:nil];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)closeKeyboard:(id)sender
{
    if ([sender isKindOfClass:[UITextField class]]) {
        [sender resignFirstResponder];
    }
    else
    {
        [_nameField resignFirstResponder];
        [_emailField resignFirstResponder];
        
    }
}

- (IBAction)birthday:(id)sender
{
    [self closeKeyboard:nil];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择生日\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
    UIDatePicker *picker = [UIDatePicker new];
    picker.datePickerMode = UIDatePickerModeDate;
    picker.tag = 100;
    CGRect frame = picker.frame;
    frame.origin.y += 50;
    picker.frame = frame;
    [sheet addSubview:picker];
    if (self.navigationController.tabBarController) {
        [sheet showFromTabBar:self.navigationController.tabBarController.tabBar];
    }
    else
    {
        [sheet showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"result == %@",actionSheet.title);
    if (actionSheet.title)
    {
        if (buttonIndex != actionSheet.cancelButtonIndex) {
                    UIView *picker = [actionSheet viewWithTag:100];
                    if ([picker isKindOfClass:[UIDatePicker class]]) {
                       NSDate *date = [(UIDatePicker *)picker date];
                        if ([date timeIntervalSinceNow] > 0) {
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"不合法的日期" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                            [alert show];
                        }
                        else
                        {
                           static NSDateFormatter *birthdayDateFormatter = nil;
                            if (!birthdayDateFormatter) {
                                birthdayDateFormatter = [NSDateFormatter new];
                                birthdayDateFormatter.dateFormat = @"yyyy-MM-dd";
                            }
            
                            NSString *string =  [birthdayDateFormatter stringFromDate:date];
                            [self.birthButton setTitle:string forState:UIControlStateNormal];
                            [self.birthButton setTitle:string forState:UIControlStateHighlighted];
                           
                            [[WZProfileModifier modifier] prepareChange:date forKey:kWZUserProfileBirthKey];
                        }
                        
                    }
        }
    }
    else
    {
        switch (buttonIndex) {
            case 0://从相册选择
            [self LocalPhoto];
            break;
        case 1://拍照
            [self takePhoto];
            break;
        default:
            break;
    }
    }
}


//获取图库图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    avatarImage = [ImageUtil imageWithImageSimple:image scaledToSize:CGSizeMake(100, 100)];
    
    
    self.faceImageView.image = avatarImage;
    
    
    
    NSString *urlString = @"http://172.168.1.116:4000/imageUploadServer";
    
    NSData *data = UIImagePNGRepresentation(avatarImage);//获取图片数据
    
    NSMutableData *imageData = [NSMutableData dataWithData:data];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *aRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [aRequest setDelegate:self];//代理
    
    [aRequest setRequestMethod:@"POST"];
    
    [aRequest setData:imageData withFileName:@"myphoto.jpg" andContentType:@"image/jpeg" forKey:@"postImage"];
    
    // [aRequest setPostValue:imageData forKey:@"file"];
    [aRequest addRequestHeader:@"Content-Type" value:@"binary/octet-stream"];//这里的value值 需与服务器端 一致
    
    [aRequest startAsynchronous];//开始。异步
    [aRequest setDidFinishSelector:@selector(uploadPicSucceed:)];//当成功后会自动触发 headPortraitSuccess 方法
    [aRequest setDidFailSelector:@selector(uploadPicfailed:)];//如果失败会 自动触发 headPortraitFail 方法
  
    pickerController = picker;
     [pickerController dismissViewControllerAnimated:YES completion:nil];
}






#pragma mark -
- (void)uploadPicSucceed:(ASIFormDataRequest *)notification
{
    avatarImage = nil;

    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *tempDict = [parser objectWithString:notification.responseString];
    faceImageId = [tempDict objectForKey:@"fileUrl"];
    imgServerId = [tempDict objectForKey:@"fileFullUrl"];
    
     WZUser *user = [WZUser me];
     user.faceIcon = imgServerId;
    [[RKObjectManager sharedManager].objectStore save:nil];

     NSLog(@"blog回调结果:%@",notification.responseString);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpLoadPicFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpLoadPicSucceedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"头像上传成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
    
}

- (void)uploadPicfailed:(ASIFormDataRequest *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpLoadPicFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpLoadPicSucceedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"头像上传失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}




#pragma mark -
- (void)succeed:(NSNotification *)notification
{
    WZUser *user = [WZUser me];
    NSLog(@"userfaceIcon==%@",user.faceIcon);
    if (imgServerId)
    {
        user.faceIcon =imgServerId;
        [[RKObjectManager sharedManager].objectStore save:nil];
    }
    NSLog(@"user.postimage == %@",user.postImage);
    NSString *oldPath = @"";
    NSString *picServerPath = @"http://172.168.1.116:4000/fileServer/showImages?fileUrl=";
    if (createWeiboViewController.imageFullPathArray.count !=0)
    {
        for (int i =0; i<createWeiboViewController.imageFullPathArray.count;i++)
        {
            NSString *path = [createWeiboViewController.imageFullPathArray objectAtIndex:i];
            if (i == createWeiboViewController.imageFullPathArray.count - 1)
            {
                NSString *fullPath = @"";
//                fullPath = [picServerPath stringByAppendingString:fullPath];
                fullPath = [fullPath stringByAppendingString:path];
                oldPath = [oldPath stringByAppendingString:fullPath];
            }
            else
            {
                NSString *fullPath = @"";
//                fullPath = [picServerPath stringByAppendingString:fullPath];
                fullPath = [fullPath stringByAppendingString:path];
                
                fullPath = [ fullPath stringByAppendingString:@","];
                oldPath = [oldPath stringByAppendingString:fullPath];
            }
            
        }
    
        user.postImage =oldPath;
        [[RKObjectManager sharedManager].objectStore save:nil];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileUpdateSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileUpdateFailedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}

- (void)failed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileUpdateSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileUpdateFailedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改失败" message:[notification object] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}


//从相册选择
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//拍照
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        NSLog(@"该设备无摄像头");
    }
}



- (IBAction)goPicView:(id)sender {
    createWeiboViewController = [[CreateWeiboViewController alloc]init];
    UINavigationController *createWeiboNav=[[UINavigationController alloc]initWithRootViewController:createWeiboViewController];
    createWeiboNav.navigationBar.barStyle = UIBarStyleBlack;
    [self presentViewController:createWeiboNav animated:YES completion:NO];

}

- (void)changeFaceIcon:(id)sender {
    //弹出选项列表选择图片来源
      UIImageView *imageView = (UIImageView *)[(UITapGestureRecognizer *)sender view];
        UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"相机", nil];
        [chooseImageSheet showInView:self.view];
 
    
}
- (IBAction)mySpaceAction:(id)sender {
    
}
@end
