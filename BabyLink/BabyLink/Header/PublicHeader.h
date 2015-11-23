//
//  PublicHeader.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h

#define RGBCOLOR(HEX)     [UIColor colorWithRed:((((HEX)>>16)&0xFF))/255. green:((((HEX)>>8)&0xFF))/255.  blue:((((HEX)>>0)&0xFF))/255. alpha:1]

//BE3D6F
#define PurpleBtnColor [UIColor colorWithRed:0XBE/255. green:0X3D/255. blue:0X6F/255. alpha:1]
//DC5055
#define RedBtnColor [UIColor colorWithRed:0XDC/255. green:0X50/255. blue:0X55/255. alpha:1]

#define DarkGrayBtnColor RGBCOLOR(0x8F9091)

#define GrayBorderColor RGBCOLOR(0xACACB4)

#define GrayBackColor RGBCOLOR(0xEDEEEF)
//
#define GreenBtnColor RGBCOLOR(0xA7D8D3)



//全局参数
#define ISLOGIN         @"islogin"
#define LOGIN_TIME      @"login_time"

#define MOBILE          @"mobile"
#define MEMBER_ID       @"member_id"
#define MEMBER_NAME     @"member_name"
#define MEMBER_AVAR     @"member_avar"
#define PASSWORD        @"password"
#define PASSWORDLocal   @"passwordLocal"
#define OPENID          @"openid"


#define HOME            @"home"
#define ADD_TIME        @"add_time"
#define BABY_DATE       @"baby_date"
#define BABY_LINK       @"baby_link"
#define BABY_NAM        @"baby_nam"
#define BABY_SEX        @"baby_sex"
#define POSITION        @"position"
#define CITY            @"city"



#endif /* PublicHeader_h */
