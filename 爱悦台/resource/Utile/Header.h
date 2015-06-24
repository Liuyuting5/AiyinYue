//
//  Header.h
//  爱悦台
//
//  Created by qianfeng on 15/6/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef ____Header_h
#define ____Header_h

/**
 *  屏幕宽度
 */

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/**
 *  屏幕高度
 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//官方推荐
#define OFFICE_URL   @"suggestions/front_page.json?D-A=0&rn=640*540"
#define DEVICE_URL   @"deviceinfo=%7B%22aid%22%3A%2210201027%22%2C%22os%22%3A%22Android%22%2C%22ov%22%3A%224.4.2%22%2C%22rn%22%3A%22480*800%22%2C%22dn%22%3A%22MX4%22%2C%22cr%22%3A%2200000%22%2C%22as%22%3A%22WIFI%22%2C%22uid%22%3A%220658f913a8fe165d024ba839ed691e38%22%2C%22clid%22%3A110010000%7D"
//详情界面
#define DETAIL_URL   @"video/show.json?D-A=0&relatedVideos=true&id="
//首播界面的url
#define  SHOUBO_ARE_URL  @"video/get_mv_areas.json?D-A=0&type=fs"
//热播界面的获取地区的数据
#define  LIVE_AREA_URL  @"video/get_mv_areas.json?D-A=0&type=dv"
//热播界面前半部分
#define  AREA_BEFOR   @"video/list.json?D-A=0&promoTitle=true&"

//热播界面后半部分的数据
#define AREA_BEHIND @"&supportBanner=true&offset=0&size=20"
///刷新数据
#define NEW_DATA_URL  @"&supportBanner=true&offset=%ld&size=20"
//流行界面的获取地区的数据
#define  POP_AREA_URL  @"video/get_mv_areas.json?D-A=0&type=pop"
//猜你喜欢
#define FAVORITE_URL @"video/guess.json?D-A=0&offset=0&size=20"
//猜你喜欢刷新url
#define FAVORITE_NEW_URL  @"video/guess.json?D-A=0&offset=%ld&size=20"
#define  SEARCH_URL  @"http://mapi.yinyuetai.com/search/video.json?D-A=0&offset=0&size=20&keyword="
#define PINDAO_SHOUYE @"http://mapi.yinyuetai.com/recommend/video/aggregation.json?D-A=0&"
//频道列表
#define PINDAO_LIST_URL @"http://mapi.yinyuetai.com/%@/videos.json?D-A=0&order=VideoPubDate&detail=true&offset=0&%@Id=%@&size=20"
#define PINDAO_LIST_MORE_URL @"http://mapi.yinyuetai.com/%@/videos.json?D-A=0&order=VideoPubDate&detail=true&offset=%ld&%@Id=%@&size=20"
//悦单
#define  YUE_DAN_URL @"http://mapi.yinyuetai.com/playlist/list.json?D-A=0&category=%@&offset=%ld&size=20"
//悦单播放链接  需要拼接id和deviceinfo
#define YUE_DAN_DETAIL_url @"http://mapi.yinyuetai.com/playlist/show.json?D-A=0&id=%@"
#define VBANG_AREA   @"vchart/get_vchart_areas.json?D-A=0"
#define VBANG_URL   @"http://mapi.yinyuetai.com/vchart/trend.json?D-A=0&date=true&area=%@&offset=%ld&size=20"
#endif
