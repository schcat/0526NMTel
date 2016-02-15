//
//  BNRDetailViewController.m
//  0526NMTel
//
//  Created by Zhixue Li on 5/30/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "AppDelegate.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"
#import "BNRItemStore2.h"

@interface BNRDetailViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *imagePickerPopover;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *landLineField;
@property (weak, nonatomic) IBOutlet UITextField *cellPhoneField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@end

@implementation BNRDetailViewController

- (instancetype)initForNewItem:(BOOL)isNew{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem:" userInfo:nil];
    return nil;
}

- (void)save:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender{
    [[BNRItemStore sharedStore] removeItem:self.item];
    [[BNRItemStore2 sharedStore] removeItem:self.item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareViewsForOrientation:(UIInterfaceOrientation)orientation{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    }else{
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self prepareViewsForOrientation:toInterfaceOrientation];
}

- (IBAction)takePicture:(id)sender {
    
    if ([self.imagePickerPopover isPopoverVisible]) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        self.imagePickerPopover.delegate = self;
        [self.imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else{
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [[BNRImageStore sharedStore] setImage:image forkey:self.item.itemKey];
    self.imageView.image = image;
    if (self.imagePickerPopover) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"User dismissed popover");
    self.imagePickerPopover = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    //  NSLog(@"%@", self.item);
    [super viewWillAppear:animated];
    
    UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
    [self prepareViewsForOrientation:io];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.NMTelContactName;
    self.cellPhoneField.text = item.NMTelCellPhone;
    self.landLineField.text = item.NMTelLandLine;
    self.emailField.text = item.NMTelContactEmail;
    
    NSString *itemKey = self.item.itemKey;
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    self.imageView.image = imageToDisplay;
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.tb.tabBar.hidden = YES;
    
 //   [self.view bringSubviewToFront:_toolbar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    BNRItem *item = self.item;
    item.NMTelContactName = self.nameField.text;
    item.NMTelCellPhone = self.cellPhoneField.text;
    item.NMTelLandLine = self.landLineField.text;
    item.NMTelContactEmail = self.emailField.text;
  //  if ([item.NMTelContactName isEqual: @""]) {
  //
  //  }
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.tb.tabBar.hidden = NO;
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.NMTelContactName;
}

- (IBAction)initCall:(id)sender
{
    NSString *num = self.cellPhoneField.text;// 此处读入电话号码
 //   NSLog(@"%@", num);
    NSString *number = [[NSString alloc] initWithFormat:@"tel://%@",num];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]]; //拨号
}

- (IBAction)initMessage:(id)sender
{
    NSString *num = self.cellPhoneField.text;// 此处读入电话号码
    //   NSLog(@"%@", num);
    NSString *number = [[NSString alloc] initWithFormat:@"sms://%@",num];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]]; //拨号
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
