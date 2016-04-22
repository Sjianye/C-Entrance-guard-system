//
//  System.m
//  门禁管理系统
//
//  Created by qingyun on 16/4/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "System.h"

@implementation System
-(void)setManager//首次进入页面
{
    NSLog(@"\n     首次进入,请先创建管理员账号,牢记账号及密码⚠️");
    printf("👮       请输入账号\n");
    char a[10];
    scanf("%s",a);
    getchar();
    NSString *str1=[NSString stringWithUTF8String:a];
    printf("👮       请输入密码\n");
    char b[10];
    scanf("%s",b);
    getchar();
    NSString *str2=[NSString stringWithUTF8String:b];
    NSDictionary *dic1=@{@"account":str1,@"pass":str2};
    [dic1 writeToFile:@"dic.txt" atomically:YES];
    NSLog(@"\n       🎆创建成功🎆\n\n");
    [self show];
    
}
-(void)show//主页面
{
    NSFileManager *fm=[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:@"dic.txt"])
    {
        printf("🔔🔔🔔🔔🔔主页面🔔🔔🔔🔔🔔\n         1⃣️管理员入口👮\n         2⃣️员工入口👱\n         3⃣️访客🙋\n         4⃣️退出❌\n");
    }
    else
    {
        [self setManager];
    }
    char x=[self DO];//接收菜单的客户选项
    switch (x) {
        case '1':
            [self managerShow];   //管理员入口
            break;
        case '2':
            [self staffShow];                       //员工入口
            break;
        case '3':
            NSLog(@"\n         tap-tap....tap-tap..... (～﹃～)~zZ");                       //访客模式
            [self show];
            break;
        case '4':
            NSLog(@"\n         退出");                       //退出
            exit(0);
            break;
        default:
            NSLog(@"\n       ⚠️⚠️输入有误,请重新输入\n\n");
            [self show];
            break;
    }
}
-(void)managerShow//管理员登录页面
{
    printf("\n       请输入管理员账号\n");
    char z1[10];
    scanf("%s",z1);
    getchar();
    NSString *z2=[NSString stringWithUTF8String:z1];
    printf("\n       请输入管理员密码\n");
    char m1[10];
    scanf("%s",m1);
    getchar();
    NSString *m2=[NSString stringWithUTF8String:m1];
    NSDictionary* mDic=[[NSDictionary alloc]initWithContentsOfFile:@"dic.txt"];
    NSString *mStrAcc=[[NSString alloc]initWithString:[mDic valueForKey:@"account"]];
    NSString *mStrPass=[[NSString alloc]initWithString:[mDic valueForKey:@"pass"]];
    if ([mStrAcc isEqualToString:z2]&&[mStrPass isEqualToString:m2])
        {
        printf("\n            输入正确\n");
            [self managerShow1];
        }
    else
        {
        printf("\n       输入错误\n\n是否重新输入？y ？\n");
    
            if ([self yn])
            {
                [self managerShow];
            }
            else
            {
                printf("\n       返回上一级\n");
                [self show];
            }
        }
}
-(void)managerShow1//管理页面
{
    printf("\n🔔🔔🔔🔔🔔管理页面🔔🔔🔔🔔🔔\n         1⃣️更改密码👮\n         2⃣️增加员工👮\n         3⃣️修改员工👮\n         4⃣️浏览员工👮\n         5⃣️删除员工👮\n         6⃣️返回上级👮\n\n\n");
    int x1=[self DO];//接收管理员界面选项
    switch (x1) {
        case '1':
            [self managerShow2];         //更改密码
            break;
        case '2':
            [self increStaff];          //增加员工
            break;
        case '3':
            [self changeStaff];         //修改员工
            break;
        case '4':
            [self browseStaff];         //浏览员工信息
            break;
        case '5':
            [self remStaff];                          //删除员工
            break;
        case '6':
            [self show];
            break;
        default:
            NSLog(@"\n       输入有误⚠️");
            printf("\n       输入错误\n\n是否重新输入？y ？\n");
            if ([self yn])
            {
                [self managerShow1];
            }
            else
            {
                printf("\n       返回上一级\n");
                [self show];
            }
            break;
    }
}
-(void)managerShow2
{
    printf("\n       👮管理员密码修改\n\n请输入旧密码:\n");
    char jiumima[10];
    scanf("%s",jiumima);
    getchar();
    NSString *jiumimaStr=[[NSString alloc]initWithUTF8String:jiumima];
    NSString *jiuPass=[[NSString alloc]initWithString:[[NSDictionary dictionaryWithContentsOfFile:@"dic.txt"] valueForKey:@"pass"]];
    if ([jiumimaStr isEqualToString:jiuPass])
    {
        printf("\n       旧密码正确\n请输入新密码:\n");
        char newpass[10];
        scanf("%s",newpass);
        getchar();
        printf("\n       再次输入新密码\n");
        char newpass1[10];
        scanf("%s",newpass1);
        getchar();
        NSString *newPass1=[NSString stringWithUTF8String:newpass];
        NSString *newPass2=[NSString stringWithUTF8String:newpass1];
        if ([newPass1 isEqualToString:newPass2])
        {
            [self changeM:newPass1];//管理员密码修改
            printf("\n       密码修改成功,请牢记管理员密码⚠️⚠️\n");
            [self managerShow1];
        }
        else
        {
            printf("\n       新密码两次输入不一致,请重新修改");
            [self managerShow2];
        }
    }
    else
    {
        printf("\n       输入错误\n\n是否重新输入？y ？\n");
        if ([self yn])
        {
            [self managerShow2];
        }
        else
        {
            [self managerShow1];
        }
    }
}
-(void)changeM:(NSString *)m                //改变管理密码
{
    NSMutableDictionary *mDic=[[NSMutableDictionary alloc] initWithContentsOfFile:@"dic.txt"];
    mDic[@"pass"]=m;
    [mDic writeToFile:@"dic.txt" atomically:YES];
}
-(void)increStaff                       //增加员工
{
    //判断是否存在员工目录
    NSFileManager *fm=[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:@"staff.txt"])
    {
        _staff=[NSMutableArray arrayWithContentsOfFile:@"staff.txt"];
        if (_staff.count>0)
        {
            NSString *newStaffAcc=[self increStaffAcc];
            NSString *newStaffPass=[self increStaffPass];
          //  for (NSDictionary* mDic in _staff)
          //  {
            NSDictionary *mDic=[[NSDictionary alloc]init];
            mDic=@{@"acc":newStaffAcc,@"pass":newStaffPass};
            
                if([_staff containsObject:mDic])
                {
                    NSLog(@"\n          已经存在的员工信息⚠️");
                    [self managerShow1];
                }
                else
                {
                    for (NSDictionary* dic in _staff)
                    {
                        if ([dic[@"acc"] isEqualTo:mDic[@"acc"]] )
                        {
                            NSLog(@"\n          已经存在的员工信息⚠️");
                            [self managerShow1];
                        }
                    }
                    [_staff addObject:@{@"acc":newStaffAcc,@"pass":newStaffPass}];
                    [_staff writeToFile:@"staff.txt" atomically:YES];
                    NSLog(@"\n       员工%@创建成功🎉\n",newStaffAcc);
                    [self managerShow1];

                }
            
        }
        else
        {
            _staff=[[NSMutableArray alloc] initWithCapacity:20];
            NSString *newStaffAcc=[self increStaffAcc];
            NSString *newStaffPass=[self increStaffPass];
            NSDictionary* mDic=@{@"acc":newStaffAcc,@"pass":newStaffPass};
            [_staff addObject:mDic];
            [_staff writeToFile:@"staff.txt" atomically:YES];
            NSLog(@"\n       员工%@创建成功🎉\n",newStaffAcc);
            [self managerShow1];
        }
     }
    else
    {
        _staff=[[NSMutableArray alloc] initWithCapacity:50];
        NSString *newStaffAcc=[self increStaffAcc];
        NSString *newStaffPass=[self increStaffPass];
        NSDictionary *staffDic=@{@"acc":newStaffAcc,@"pass":newStaffPass};
        [_staff addObject:staffDic];
        [_staff writeToFile:@"staff.txt" atomically:YES];
        NSLog(@"\n       恭喜,第一个员工%@创建成功🎉🎉",newStaffAcc);
        [self managerShow1];
    }

}
-(NSString*)increStaffAcc           //写入员工账号
{
    NSLog(@"\n       输入需要添加的员工号码");
    char staffAcc[10];
    scanf("%s",staffAcc);
    getchar();
    return [NSString stringWithUTF8String:staffAcc];
}
-(NSString *)increStaffPass         //写入员工密码
{
    NSLog(@"\n       输入需要添加的员工密码");
    char staffPass[10];
    scanf("%s",staffPass);
    getchar();
    return [NSString stringWithUTF8String:staffPass];
}
-(void)changeStaff                  //修改员工
{
    NSFileManager *fm=[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:@"staff.txt"])
    {
        _staff=[NSMutableArray arrayWithContentsOfFile:@"staff.txt"];
        if (_staff.count>0)
        {
        NSMutableDictionary *staffDic=[[NSMutableDictionary alloc] init];
        printf("\n       输入想要修改的员工\n");
        char change[10];
        scanf("%s",change);
        getchar();
        NSString *changeStr=[NSString stringWithUTF8String:change];
        for (staffDic in _staff)
        {
            if ([staffDic[@"acc"] isEqualToString:changeStr])
            {
                NSLog(@"\n       输入想要修改的密码");
                char newPass[10];
                scanf("%s",newPass);
                getchar();
                NSString *newPassStr=[NSString stringWithUTF8String:newPass];
                staffDic[@"pass"]=newPassStr;
                [_staff writeToFile:@"staff.txt" atomically:YES];
                NSLog(@"\n       修改成功!🎉");
                [self managerShow1];
            }
            else
            {
                NSLog(@"\n       没有找到该员工");
                [self managerShow1];
            }
        }
        }
            else
            {
                NSLog(@"\n      没有员工信息可以修改,请先设置⚠️");
                [self managerShow1];
            }
    }
    else
    {
        NSLog(@"\n       还没有员工信息,请添加⚠️");
        [self managerShow1];
    }
}
-(void)browseStaff  //浏览员工信息
{
     NSFileManager *fm=[NSFileManager defaultManager];
    _staff=[NSMutableArray arrayWithContentsOfFile:@"staff.txt"];
    if ([fm fileExistsAtPath:@"staff.txt"]&&_staff.count>0)
    {
        NSLog(@"      %@",[NSArray arrayWithContentsOfFile:@"staff.txt"]);
        [self managerShow1];
    }
    else
    {
        NSLog(@"\n           还没有员工信息,请添加");
        [self managerShow1];
    }
}
-(void)remStaff      //删除员工信息
{
    NSFileManager *fm=[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:@"staff.txt"])
    {
        _staff=[NSMutableArray arrayWithContentsOfFile:@"staff.txt"];

        if (_staff.count>0)
        {
        NSLog(@"\n         输入要删除的员工号");
        char staffAcc[10];
        scanf("%s",staffAcc);
        getchar();
        NSString *staffStr=[NSString stringWithUTF8String:staffAcc];
//        NSMutableDictionary *staffDic=[[NSMutableDictionary alloc]initWithCapacity:20];
        NSDictionary *mDic=[[NSDictionary alloc]init];
 //       mDic=@{@"acc":staffStr};
        for (mDic in _staff)
        {
            if ([[mDic valueForKey:@"acc"] isEqualToString:staffStr])
            {
                break;
            }
        }
        
            if ([_staff containsObject:mDic])//!$@@%#$^%^&%$#@!%$^&*(^%$#@#!$#$%^&*()*^%$#
            {
                [_staff removeObject:mDic];
                [_staff writeToFile:@"staff.txt" atomically:YES];
                NSLog(@"\n       删除成功!🎉");
                [self managerShow1];
            }
            else
            {
                NSLog(@"\n       没有找到该员工");
                [self managerShow1];
            }
        
    }
        else
        {
            NSLog(@"\n       没有员工信息可以删除⚠️⚠️");
        }
        [self managerShow1];
}
        else
        {
            NSLog(@"\n          请先添加员工信息⚠️⚠️");
            [self managerShow1];
        }
}
-(void)staffShow//员工登录页面      //!@#%^&*(&^@#!#$%^^%
{
    NSFileManager *fm=[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:@"staff.txt"])
    {
        _staff=[NSMutableArray arrayWithContentsOfFile:@"staff.txt"];
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:20];
        
        if (_staff.count>0)
        {
            NSLog(@"\n       输入员工账号👨");
            char a[10];
            scanf("%s",a);
            getchar();
            NSString *staffAcc=[NSString stringWithUTF8String:a];
            NSLog(@"\n       输入员工密码👨");
            char b[10];
            scanf("%s",b);
            getchar();
            NSString *staffPass=[NSString stringWithUTF8String:b];
            for (dic in _staff)
            {
                if (([dic[@"acc"]isEqualToString:staffAcc])&&([dic[@"pass"]isEqualToString:staffPass]))
                {
                    NSLog(@"\n         登录成功🎉");
                    [self staffShow1:dic];
                    
                }
            }
                NSLog(@"\n          账号或密码错误");
                [self show];
        }
        else
        {
            NSLog(@"\n          请先设置员工信息⚠️");
            [self show];
        }
    }
    else
    {
          NSLog(@"\n          请先设置员工信息⚠️");
        [self show];
    }
 
}
-(void)staffShow1:dic   //员工修改密码
{
    printf("\n       1⃣️显示账号信息👨\n       2⃣️修改密码👨\n       3⃣️退出\n");
    switch ([self DO])
    {
        case '1':
            NSLog(@"\n          %@",dic);                //显示账号信息
            [self staffShow1:dic];
            break;
        case '2':
        {    printf("\n          请输入旧密码\n");               //修改密码
            char jiumima[10];
            scanf("%s",jiumima);
            getchar();
            NSString *jiuStr=[NSString stringWithUTF8String:jiumima];
            if ([jiuStr isEqualToString:dic[@"pass"]])
            {
                NSLog(@"\n          旧密码正确\n\n           输入新密码");
                char xin1[10];
                scanf("%s",xin1);
                getchar();
                NSString *xinPass=[NSString stringWithUTF8String:xin1];
                NSLog(@"\n           再次输入新密码");
                char xin2[10];
                scanf("%s",xin2);
                getchar();
                if ([xinPass isEqualToString:[NSString stringWithUTF8String:xin2]])
                {
                 NSLog(@"\n          新密码为%@请牢记密码",xinPass);
                _staff=[NSMutableArray arrayWithContentsOfFile:@"staff.txt"];
                [_staff removeObject:dic];
                [dic setValue:xinPass forKey:@"pass"];
                [_staff addObject:dic];
                [_staff writeToFile:@"staff.txt" atomically:YES];
                [self staffShow1:dic];
                }
                else
                {
                    NSLog(@"          两次新密码输入不一致⚠️⚠️");
                    [self staffShow1:dic];
                }

            }
            else
            {
                NSLog(@"\n            旧密码输入错误⚠️⚠️");
                [self staffShow1:dic];
            }
        }
            break;
        case '3':
            [self show];
            break;
        default:
            NSLog(@"\n            选择有误");
            break;
    }
}
#pragma mark -接收选择器
-(char)DO//接收选择器
{
    char a;
    scanf("%c",&a);
    getchar();
    return a;
}
#pragma mark -接收判断器
-(BOOL)yn//接收判断器
{
    char a;
    scanf("%c",&a);
    getchar();
    if (a=='y'||a=='Y')
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end








