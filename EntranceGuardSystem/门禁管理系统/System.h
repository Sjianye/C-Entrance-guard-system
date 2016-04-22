//
//  System.h
//  门禁管理系统
//
//  Created by qingyun on 16/4/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface System : NSObject
//@property(nonatomic,strong)NSMutableDictionary* manager;
@property(nonatomic,strong)NSMutableArray* staff;
@property(nonatomic,copy)NSString* visitor;
-(void)show;//主页面
//-(void)setManager;//首次进入页面
//-(void)managerShow;//管理员登录页面
//-(void)managerShow1;//管理员操作页面
//-(void)managerShow2;//管理员密码修改
//-(char)DO;//接收选择器
//-(BOOL)yn;//接收
//-(void)changeM:(NSString *)m;//改变管理密码
//-(void)increStaff;//增加员工
//-(NSString*)increStaffAcc;//写入员工账号
//-(NSString*)increStaffPass;//写入员工密码
//-(void)changeStaff;//改变员工
//-(void)browseStaff;//浏览员工信息
//-(void)remStaff;//删除员工信息
//-(void)staffShow;//员工登录界面
//-(void)staffShow1:(NSMutableDictionary*)nsDic;//员工登录后界面
@end
