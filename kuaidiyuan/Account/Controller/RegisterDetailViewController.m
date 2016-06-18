//
//  RegisterDetailViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/17.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RegisterDetailViewController.h"
#import "RegisterOneTableViewCell.h"
#import "RegisterTwoTableViewCell.h"
#import "SelectedImageView.h"
#import "SelectedSchollViewController.h"
#import "CollegeModel.h"
#import "SelectedCourierCompanyViewController.h"
@interface RegisterDetailViewController ()<UITableViewDataSource,UITableViewDelegate,RegisterTwoTableViewCellDelegate,RegisterOneTableViewCellDelegate>
{
    SelectedImageView * selectedImageView;
    ///头像
    NSString * avatarImageUploaded;
    ///身份证正反面
    NSString * selectedIdCardFrontImageUrl;
    NSString * selectedIdCardBackImageUrl;
    UIImage * selectedIdCardFrontImage;
    UIImage * selectedIdCardBackImage;
    ///用逗号隔开的身份证正反面
    NSString * uploadIdCardImageStr;
    ///姓名
    NSString * realName;
    ///身份证号
    NSString * IdCard;
    ///大学
    NSString * collegeName;
    NSString * collegeId;
    ///快递公司
    NSString * courierCompanyName;
    NSString * courierCompanyId;
}

@property (nonatomic,strong)UITableView *tableView;

///选择头像视图
@property (nonatomic,strong)UIButton *headImageSelectedBtn;

@end

@implementation RegisterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"校外快递员注册";
    [self createLeftBackNavBtn];
    
    
    
    [self createTableView];
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    


    
    //发布按钮的创建
    
    float space = 16;
    float btnHeight = 44;
    float footViewHeight = 48;
    float btnWidth = SCREEN_WIDTH - 30;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footViewHeight)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"完成注册" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(space, space, btnWidth,btnHeight)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(complementationAction) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:submitBtn];
    
    self.tableView.tableFooterView = backGroundView;
    
   

    //设置headerView
    [self setContentView];
    
    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"RegisterOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    [tableView registerClass:[RegisterTwoTableViewCell class] forCellReuseIdentifier:@"twoCell"];
    
}

#pragma mark - 设置修改头像视图
-(void)setContentView
{
    float space = 16;
    float headImageheight = 60;
    float headImageWidth = 60;
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    backGroundView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    
    
    
    ///选择头像
    _headImageSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headImageSelectedBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [_headImageSelectedBtn setImage:[UIImage imageNamed:@"avatar_change"] forState:UIControlStateNormal];
    [_headImageSelectedBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [_headImageSelectedBtn setFrame:CGRectMake((SCREEN_WIDTH-headImageWidth)/2, space, headImageWidth,headImageheight)];
    _headImageSelectedBtn.tag = selectedImageTypeOfAvatarImage;
    _headImageSelectedBtn.layer.cornerRadius = 30;
    _headImageSelectedBtn.layer.masksToBounds = YES;
    [_headImageSelectedBtn addTarget:self action:@selector(selectedImageFromPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    
    [backGroundView addSubview:_headImageSelectedBtn];
    self.tableView.tableHeaderView = backGroundView;
    
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section == 0) {
        return 4;
    }else{
        return 1;

    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        return 160;
    }else{
        return 45;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:{
                
                RegisterOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentTextField.tag=10001;
                cell.delegate=self;
                return cell;
                
            }
                
                break;
            case 1:{
                
                RegisterOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentTextField.tag=10002;
                cell.delegate=self;
                cell.contentTextField.placeholder = @"身份证号";
                return cell;

                
            }
                
                break;
            case 2:{
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.textLabel.text = @"选择快递公司";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                
                return cell;

                
            }
                
                break;
            case 3:{
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.textLabel.text = @"选择配送学校";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                
                return cell;

            }
                break;
                
            default:
                
                return nil;
                break;
        }
        
        
    }else{
        
        RegisterTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.delegate= self;
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        [CommonUtils showToastWithStr:@"选择快递公司"];
        [self selectedCourierCompany];
    }else if (indexPath.section == 0 && indexPath.row == 3) {
        [CommonUtils showToastWithStr:@"选择配送学校"];
        [self selectedSchool];
    }

}
#pragma mark - 选择快递公司
-(void)selectedCourierCompany
{
    SelectedCourierCompanyViewController * schollVC = [[SelectedCourierCompanyViewController alloc]init];
    schollVC.callBackBlock = ^(NSString *theCourierCompanyName,NSString *theCourierCompanyId) {
        courierCompanyName = theCourierCompanyName;
        courierCompanyId   = theCourierCompanyId;
    };
    [self.navigationController pushViewController:schollVC animated:YES];
}

#pragma mark - 选择学校
-(void)selectedSchool
{
    SelectedSchollViewController * schollVC = [[SelectedSchollViewController alloc]init];
    schollVC.callBackBlock = ^(CollegeModel *collegeModel) {
        collegeName = collegeModel.collegeName;
        collegeId = collegeModel.collegeID;
    };
    [self.navigationController pushViewController:schollVC animated:YES];
}
#pragma mark - 输入的姓名和身份证
-(void)inputContentWithTextField:(UITextField *)textField
{
    if (textField.tag==10001) {
        ///姓名
        realName = textField.text;
    }else if (textField.tag==10002){
        ///身份证号码
        IdCard = textField.text;
    }
}
#pragma mark - 身份证正反面的响应方法
- (void)getIdCardBackWithBtn:(UIButton *)sender{
    
    [CommonUtils showToastWithStr:@"获取身份证反面"];
    [self selectedImageFromPhotoAlbum:sender];
}

- (void)getIdCardFontWithBtn:(UIButton *)sender{
    [CommonUtils showToastWithStr:@"获取身份证正面"];
    [self selectedImageFromPhotoAlbum:sender];
}
#pragma mark - 选择图片
-(void)selectedImageFromPhotoAlbum:(UIButton *)sender
{
    [CommonUtils showToastWithStr:@"选择头像"];
    float height = 200;
    
    selectedImageView = [[SelectedImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height) withSuperController:self];
    weakSelf(wSelf)
    selectedImageView.callBackBlock = ^(UIImage * selectedImage){
        
        if (sender.tag == selectedImageTypeOfIdCardFront) {
            //身份证正面
            [sender setImage:selectedImage forState:UIControlStateNormal];
            selectedIdCardFrontImage = selectedImage;
        }else if (sender.tag == selectedImageTypeOfIdCardBack){
            //身份证背面
            [sender setImage:selectedImage forState:UIControlStateNormal];
            selectedIdCardBackImage = selectedImage;
        }else if (sender.tag==selectedImageTypeOfAvatarImage){
            //头像
            [wSelf.headImageSelectedBtn setBackgroundImage:selectedImage forState:UIControlStateNormal];
            [wSelf.headImageSelectedBtn setImage:[UIImage imageNamed:@"avatar_change"] forState:UIControlStateNormal];
            //需要把图片上传到服务器
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSMutableDictionary * imageDic = [NSMutableDictionary dictionary];
            NSData * imageData = UIImagePNGRepresentation(selectedImage);
            [imageDic setObject:imageData forKey:@"Users[file]"];
            [[HttpClient sharedInstance]uploadImageWithParams:dic withUploadDic:imageDic withSuccessBlock:^(HttpResponseCodeModel *model) {
                avatarImageUploaded = [dic objectForKey:@"picUrl"];
            } withFaileBlock:^(NSError *error) {
                
            }];
        }else{
            
        }
    };
    [[UIApplication sharedApplication].delegate.window addSubview:selectedImageView];
}
#pragma mark - 完成注册按钮响应方法
- (void)complementationAction{
    
    [CommonUtils showToastWithStr:@"完成注册：上传身份证"];
    NSMutableArray * selectedImageArray = [NSMutableArray arrayWithObjects:selectedIdCardFrontImage,selectedIdCardBackImage, nil];
     NSMutableDictionary * imageDic = [NSMutableDictionary dictionary];
     for (int i = 0; i<selectedImageArray.count; i++) {
     UIImage *img = [selectedImageArray objectAtIndex:i];
     ///上传图片,压缩图片，不能过大
     UIImage * scaleImg = [CommonUtils imageByScalingAndCroppingForSize:CGSizeMake(300, 300) withImage:img];
     NSData * imageData = UIImagePNGRepresentation(scaleImg);
     NSString * key = [NSString stringWithFormat:@"UploadForm[file][%d]",i];
     [imageDic setObject:imageData forKey:key];
     }
     
     [[HttpClient sharedInstance]uploadImagesWithParams:imageDic withUploadDic:imageDic withSuccessBlock:^(HttpResponseCodeModel *model) {
     
         if (model.responseCode==ResponseCodeSuccess) {
             NSArray  *imageArr =(NSArray *)model.responseCommonDic;
             uploadIdCardImageStr = [imageArr componentsJoinedByString:@","];
#warning mark - 头像上传接口有问题，先使用这个
             avatarImageUploaded = [imageArr firstObject];
             [self submit];
         }else{
             [CommonUtils showToastWithStr:model.responseMsg];
         }
     } withFaileBlock:^(NSError *error) {
         NSLog(@"%@",error);
     }];
    
}
///提交
-(void)submit
{
    /*
     ///快递公司
     NSString * courierCompanyName;
     NSString * courierCompanyId;
     
     */
//    if (avatarImageUploaded.length<=0) {
//        [CommonUtils showToastWithStr:@"请选择头像"];
//        return;
//    }
    if (uploadIdCardImageStr.length<=0) {
        [CommonUtils showToastWithStr:@"请选择身份证图片"];
        return;
    }
    if (realName.length<=0) {
        [CommonUtils showToastWithStr:@"请填写姓名"];
        return;
    }
    if (IdCard.length<=0) {
        [CommonUtils showToastWithStr:@"请填写身份证号"];
        return;
    }
    if (collegeId.length<=0) {
        [CommonUtils showToastWithStr:@"请选择配送大学"];
        return;
    }
//    if (courierCompanyId.length<=0) {
//        [CommonUtils showToastWithStr:@"请选择配送公司"];
//        return;
//    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userCourierId forKey:@"id"];
    [dic setValue:avatarImageUploaded forKey:@"icon"];
    [dic setValue:realName forKey:@"realname"];
    [dic setValue:IdCard forKey:@"IDcard"];
    [dic setValue:collegeId forKey:@"college_id"];
    [dic setValue:courierCompanyId forKey:@"expresscompany"];
    [dic setValue:uploadIdCardImageStr forKey:@"IDCardPhoto"];
    
    [[HttpClient sharedInstance]perfectUserInfoWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            AppDelegate * appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
            [appDelegate setRootViewController];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
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

@end
