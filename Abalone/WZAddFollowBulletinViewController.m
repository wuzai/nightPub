//
//  WZAddFollowBulletinViewController.m
//  Abalone
//
//  Created by chen  on 13-11-28.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WZAddFollowBulletinViewController.h"
#import "WZUser+Me.h"
#import "UIWindow+Lock.h"
#import "WZFollowBulltin+Networks.h"

@interface WZAddFollowBulletinViewController ()

@end

@implementation WZAddFollowBulletinViewController



@synthesize textView=_textView;
@synthesize countLabel=_countLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"添加评论";
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard:)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[flexible,closeItem];
    self.textView.inputAccessoryView = toolbar;
    self.textView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCommentSuccess:) name:WZFollowBulletinAddSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCommentFail:) name:WZFollowBulletinAddFailedNotification object:nil];
}

-(void)closeKeyboard:(id)sender
{
    [self.textView  resignFirstResponder];
}

-(void)updateWordsNum
{
    NSString *textNum = [NSString stringWithFormat:@"%i/200",self.textView.text.length];
    self.countLabel.text = textNum;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect frame = self.textView.frame;
    frame.size.height = 80;
    self.textView.frame = frame;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSUInteger num = self.textView.text.length;
    if (num < 200) {
        [self updateWordsNum];
    }else{
        self.textView.text = [self.textView.text substringToIndex:200];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect frame = self.textView.frame;
    frame.size.height = 145;
    self.textView.frame = frame;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}


-(void)languageChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value1 = [userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *value2 = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame1,frame2;
    [value1 getValue:&frame1];
    [value2 getValue:&frame2];
    CGFloat height = frame2.size.height - frame1.size.height;
    CGRect frame = self.textView.frame;
    frame.size.height -= height;
    self.textView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:WZFollowBulletinAddSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:WZFollowBulletinAddFailedNotification object:nil];
    }
    
}

- (IBAction)sendFollowBulletin:(id)sender{
    
    NSString *cleanString = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!cleanString.length) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入有效数据 " delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        
    }else{
        [UIWindow lock];
        [WZFollowBulltin  addFollowBulletin:self.textView.text by:[WZUser me] forBulletinId:self.bulletin.gid];
    }
    
}

-(void)sendCommentSuccess:(NSNotification *)notification
{
    [UIWindow unlock];
    
    WZFollowBulltin *comment = [[notification object] lastObject];
    comment.user = [WZUser me];
    comment.bulletin = self.bulletin;
    
    comment.createAt = [NSDate date];
    comment.content = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [[RKObjectManager sharedManager].objectStore save:nil];
    
    self.textView.text = nil;
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"感谢您的评论！ " delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

-(void)sendCommentFail:(NSNotification *)notification
{
    [UIWindow unlock];
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"评论失败，请检查网络！" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}
@end
