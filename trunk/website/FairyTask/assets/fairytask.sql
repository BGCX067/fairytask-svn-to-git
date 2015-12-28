-- phpMyAdmin SQL Dump
-- version 3.2.0
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 08 月 20 日 17:56
-- 服务器版本: 5.0.67
-- PHP 版本: 5.2.9-2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `fairytask`
--

-- --------------------------------------------------------

--
-- 表的结构 `ft_category`
--

CREATE TABLE IF NOT EXISTS `ft_category` (
  `id` int(5) NOT NULL auto_increment,
  `lft` int(5) NOT NULL,
  `rgt` int(5) NOT NULL,
  `level` int(5) NOT NULL,
  `title` varchar(50) NOT NULL,
  `desc` varchar(255) default NULL,
  `url` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `ft_category`
--

INSERT INTO `ft_category` (`id`, `lft`, `rgt`, `level`, `title`, `desc`, `url`) VALUES
(1, 0, 23, 0, '后台管理', NULL, NULL),
(2, 1, 10, 1, '任务管理', '任务管理模块', '/index.php/task'),
(3, 2, 7, 2, '开发', '', 'task/list/3'),
(4, 8, 9, 2, '联系我们', NULL, 'contact'),
(5, 11, 16, 1, '文章管理', NULL, ''),
(6, 12, 13, 2, '新闻动态', NULL, 'news'),
(7, 14, 15, 2, '最新活动', NULL, 'play'),
(8, 17, 22, 1, '图片管理', NULL, ''),
(9, 18, 19, 2, '产品展示', NULL, 'product'),
(10, 20, 21, 2, '公司图片', NULL, 'picture'),
(11, 3, 6, 3, '网站开发', '网站开发', '/index.php/task/list/11'),
(12, 4, 5, 4, '综合性网站', '综合性网站', '/index.php/task/list/12');

-- --------------------------------------------------------

--
-- 表的结构 `ft_party`
--

CREATE TABLE IF NOT EXISTS `ft_party` (
  `id` int(10) NOT NULL auto_increment COMMENT '主键',
  `label` varchar(50) default NULL COMMENT '公会名称',
  `desc` varchar(255) default NULL COMMENT '公会描述',
  `level` int(10) default NULL COMMENT '等级',
  `icon` varchar(55) default NULL COMMENT '公会会标',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公会表' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `ft_party`
--


-- --------------------------------------------------------

--
-- 表的结构 `ft_staticdefine`
--

CREATE TABLE IF NOT EXISTS `ft_staticdefine` (
  `id` int(10) NOT NULL auto_increment,
  `label` varchar(55) default NULL COMMENT '显示名称',
  `desc` varchar(255) default NULL COMMENT '描述与说明',
  `count` int(10) default NULL COMMENT '本类下有多少条数据',
  `type` int(10) default NULL COMMENT '定义类型',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='定义表，比如说状态id对应名称，type对应名称等' AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `ft_staticdefine`
--

INSERT INTO `ft_staticdefine` (`id`, `label`, `desc`, `count`, `type`) VALUES
(1, '见习魔法师', NULL, NULL, NULL),
(2, '下位魔法师', NULL, NULL, NULL),
(3, '中位魔法师', NULL, NULL, NULL),
(4, '上位魔法师', NULL, NULL, NULL),
(5, '大魔法师', NULL, NULL, NULL),
(6, '下位魔导士', NULL, NULL, NULL),
(7, '中位魔导士', NULL, NULL, NULL),
(8, '上位魔导士', NULL, NULL, NULL),
(9, '下位魔导师', NULL, NULL, NULL),
(10, '中位魔导师', NULL, NULL, NULL),
(11, '上位魔导师', NULL, NULL, NULL),
(12, '下位法神', NULL, NULL, NULL),
(13, '中位法神', NULL, NULL, NULL),
(14, '上位法神', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `ft_task`
--

CREATE TABLE IF NOT EXISTS `ft_task` (
  `id` int(10) NOT NULL auto_increment,
  `lable` varchar(100) default NULL COMMENT '任务标题',
  `posterid` int(11) NOT NULL COMMENT '发布者',
  `summery` varchar(255) default NULL COMMENT '简述',
  `categoryid` int(10) default NULL COMMENT '任务分类ID',
  `typeid` int(10) default NULL COMMENT '任务类型',
  `statusid` int(10) default NULL COMMENT '任务状态 对就status表',
  `content` text COMMENT '任务内容',
  `hunterid` int(10) default NULL COMMENT '任务接收者id',
  `partyid` int(10) default NULL,
  `finishdate` int(10) default NULL,
  `toptype` int(10) default '0' COMMENT '置顶类型',
  `toptime` int(10) default '0' COMMENT '置顶时间',
  `create_time` int(10) default NULL,
  `update_time` int(10) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `ft_task`
--

INSERT INTO `ft_task` (`id`, `lable`, `posterid`, `summery`, `categoryid`, `typeid`, `statusid`, `content`, `hunterid`, `partyid`, `finishdate`, `toptype`, `toptime`, `create_time`, `update_time`) VALUES
(1, '测试', 1, '测试任务', 1, 1, 1, '近日，沈阳部分商铺出现了关门歇业的现象。当地许多网友上传了商铺关门的照片，微博认证为“弥漫视觉摄影工作室”的网友“弥漫视觉摄影”称，这些天沈阳好多店面都门上贴一字条“外出旅游暂停营业”，“一打听才知道工商局要在全市打假”。但此原因并未得到有关部门证实。  此时，距沈阳东北、五爱等市场大量商铺开始关门歇业已过去3个星期，打假重罚的传言终于从日杂市场影响到各种店铺，以及市民的正常生活。实际上，大连、本溪、鞍山、抚顺等地也出现了类似情况。截至发稿，沈阳官方仍未就此事作出解释。  《辽沈晚报》的官方微博昨日称，不少网友反映沈阳一些小门市、店铺关门了，“传言称多因近日的打假活动”，但是尚未有官方说法。  《沈阳晚报》官方微博还发起“打假互动”，称近日沈阳各商铺面临前所未有的“打假风波”，目前流言四起，很多版本说自己受到了打假部门的重罚。“但所有遭到重罚的都只停留在传说，如果您亲友真的受到了处罚，请告诉我们真实的情况。”  据了解，从7月15日前后，辽宁省内媒体开始出现有城市部分商户关门歇业的报道。7月15日的《辽沈晚报》报道称，沈阳地区的一些商户出现了关门歇业的情况，7月13日，沈阳东北日杂市场部分商铺关门歇业，不过次日九成商铺重新营业。有老板表示，听说检查完了，才敢重新开张。“咱也不知道是哪里来检查，看别人家关门，我也关了。”而14日沈阳的五爱国际小商品城和服装城的许多商铺都关门歇业。《鞍山日报》的报道还称，当时沈阳东北日杂市场的80%商铺关门歇业，五爱街、南塔、十三韦路、小东批发、南二批发市场等，95%以上的商铺都关门了。', 1, 1, 20120807, 0, 0, NULL, NULL),
(2, '哈哈哈', 1, '', NULL, NULL, NULL, '<u>fdsafdas<img src="http://www.fairytask.com/assets/1a21b5f8/plugins/emoticons/images/1.gif" border="0" alt="" /><span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">我，大亮，毛子三人作过几起花案，挑刺激的回忆一下。</span><br />\r\n<br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">　　去年夏天一晚上，我们三喝美了，大亮说他一小弟在三十五中念初二，老跟</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">他念叨一班花，这小子看了挺动心，把盘子都踩好了，今晚儿大伙儿一起找找乐</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">儿去。那哪能不去呢，我们就跟他溜达进一楼群里，在一楼档子角上等着那马子</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">放学会家，过了有15分钟吧，看见一小ｍｍ，15、6 岁左右吧，穿着件蓝色儿的</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">运动装上衣，上面还打着学校名，水磨白的牛仔裤，背个大书包，扭扭地过来了。</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">长的很瘦，有点过于苗条了，长腿细腰。娃娃脸儿，长头发扎个马尾，路灯不亮</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">了，看不太仔细，感觉很漂亮，皮肤很白很滑，我当时就他妈想咬一口。大亮说</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">就是她了，我们刷拉围上去，小丫头看不对想跑，没咱们几个快，立马给围当间</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">儿了，大亮从后面先把嘴给捂上了，小丫头俩手想掰，哪拧的过老亮，毛子刀一</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">亮，“别吵吵，吵吵整死你。”妈地话一唬，小ｍｍ就傻啦，声也没了，瞅着贴</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">着下巴壳儿的军刺眼泪唰就下来了。</span><br />\r\n<br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">登录聊天室后选择广东区,http://cpa.zuiaibt./找到深圳10人视频房间区，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">房间名（男欢女爱）房间密码853进来后30秒不开视频的t、害羞的请绕道。</span><br />\r\n<br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">　　哥几个硬架着小ｍｍ拖到边上一小房后边儿，“光哥先上，光哥先上。”大</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">亮这小子滑的很，让我先吃枪子儿。去他妈，干了再说。我就解皮带。“让她脸</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">冲墙蹶着。”大亮背靠墙，一手拽头发，一手用小ｍｍ的衣领捂住她的嘴，往下</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">一压，小ｍｍ的脑袋歪扭着正好顶在他小肚子上。大毛别住两胳膊，小ｍｍ一孔</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">雀开屏，小屁股一下子蹶了起来。知道不好，小丫头拼命扭腰，不让我靠前儿，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">毛子手上一使劲儿，“肏你个臊屄的，又来臊劲了不是？！找死啊！”，小mm</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">“呜呜”两声，立马老实了，毛子也不松劲，小丫头疼的腿都软了，直往下堆。</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">“好，毛子，就这样，保持住。”小mm一挣扎，腰露出来了，真他妈白，摸上去</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">跟缎子一样，嫩得几乎用点力就会破掉。我把她运动服往上一撩，衣服就反盖她</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">头上了，白色的乳罩就露出来了，我一把解开，两手顺势就摸前面了，乳房不大，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">感觉有俩馒头大吧，乳头应该有葡萄那么大小。很软，真的很软，象蒸熟的馒头</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">那么软的感觉。小mm不干了，使劲摇小pp，我这鸡巴正帖着呢，这不刺激我么。</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">毛子使劲儿一抬她胳膊，大亮再往下一压她脑袋，立马不动了，小屁股蹶的更高</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">了。我用脚分开她两腿，左腿伸到她两腿当间儿，大腿顶在她裤裆上，伸手解开</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">她的裤带，连牛仔裤和裤头一起往下扒，小丫头扭腰的劲儿不大，我没费劲雪白</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">的小屁股就露出来了，扒过女孩裤子的都知道，裤子褪过了屁股就好办了，因为</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">越往下越细，我把她牛仔裤和裤头褪到她小腿下半截，一是限制她踢我，二是并</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">腿一会而操起来更紧。小mm的屁股肉很紧，很有弹性，象两半儿小月牙儿，冰凉</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">冰凉的，摸着真嫩。刚才脱她裤子的时侯看了一下，小bb也白白嫩嫩的，不大，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">很精致。我褪下裤子，一鸡巴触在小bb上，小mm的大阴唇又温又软，包住我的鸡</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">巴头，处女就是处女， b眼太小了，我捅了老半天才把鸡巴头戳进去一大半儿，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">四周的嫩肉像铜墙铁壁，将鸡巴头紧紧夹着，b 口紧紧箍着鸡巴头下的浅沟，感</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">觉太好了。小mm“唔”声不断，给我助性，用力扭动细腰和小屁股，试图挣脱，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">双腿使劲儿向一起并拢，想顶出我的鸡巴，哪定得出去呢，感觉更紧。我扶住她</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">的腰，狠狠的往里顶，越往里越暖越滑，感觉有吸力在一股一股地箍着鸡巴，mm</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">的逼很紧，鸡吧就象被个口袋紧紧扎住一样，尤其是根部，勒着鸡巴根儿，热热</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">的。小bb里面剧烈颤抖，一紧一紧的，象是痉挛，可能是痛吧，不断按摩着我的</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">鸡巴头。费了好大劲儿，一寸一寸的往里进，太紧了，水又不多，感觉鸡巴周围</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">紧贴着全是嫩肉，箍得挺疼，可算进去一大半了，前头顶到了肉，再进一点，确</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">实到头了。我开始往外抽鸡巴，mm里面挺干的，感觉b 里的嫩肉跟着鸡巴往外跑，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">拔出一半低头一看，粉红色的b 膜外翻，鸡吧上有几缕血。我拔出一半， mm 的</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">小屁股也不怎么扭了，我扳着她的腰，开始抽插，她又开始扭。我在mm的逼里不</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">敢太猛烈的做抽插运动，怕一下就射了，我要好好的操一操逼，享受享受。真他</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">妈的爽，处女的小b 就是他妈的紧，操得我鸡巴疼。越操小b 里面的水越多，我</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">操的越快。我操一下，小丫头就“呜”一声，要是大亮不捂嘴，小b 非得哭爹叫</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">妈不可，我鸡巴挺大的，小丫头b 还没长开，又是雏，够她受的。就看两半月牙</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">儿似的小白屁股撅着，细皮嫩肉的屁股沟中间一根儿大黑粗鸡巴里出外进的，刺</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">激。我后来两手改摸她的小屁股，真嫩，一挤都象要出水儿，手感太好了。干了</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">才不到二十分钟我就射了，小丫头的光腚随着我的射精动作不停的抖，拔出鸡吧</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">一看，上面一些鲜红的血和着mm的骚水及我的精液，亮亮的。</span><br />\r\n<br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">登录聊天室后选择广东区,http://cpa.zuiaibt./找到深圳10人视频房间区，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">房间名（男欢女爱）房间密码853进来后30秒不开视频的t、害羞的请绕道。</span><br />\r\n<br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">　　完了，我掰胳膊换毛子。他老起刺儿，非得要开后庭花，操屁眼儿，有病。</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">我伸头一看，小丫头人漂亮，屁眼儿也长的挺好，浅褐色的，一小点儿，诂么放</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">不进毛子的大鸡巴。毛子的鸡巴往那一对，小丫头立马毛了，把小屁股甩得跟拨</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">浪鼓似的，毛子往她腰上就是一手肘，马上瘫了。毛子一手从前面搂腰把她提住，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">一手扶鸡巴往里触。哪进得去。我帮他托腰，他先摸了一下小mm的b ，沾了点水，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">其实就是我的精，然后把右手食指插入小屁眼儿，小丫头还要扭，又一手肘，打</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">了个小便失禁，尿顺着小丫头细细的两腿间往下淌。毛子再把右手中指也插入小</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">屁眼儿，挺费劲儿，血就下来了。毛子抽出手，两手分开小丫头的两瓣小白屁股，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">鸡巴头顶顶在小mm的屁眼上，再往里进，这下头算进去一点儿，小丫头屁股上的</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">肉绷得紧紧的，全身不停的猛震，头用力的顶在大亮身上，拼命地收屁股，毛子</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">双手紧紧搂住mm的小屁股，强力控制住小妮子疯狂扭动的身体。等插深点儿了，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">mm就不动了，应该是因为痛吧。花了十分钟，毛子才把鸡巴完的全钉进屁眼中，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">开始在干涸的直肠里抽插，小丫头的身子随着肛交动作的冲击而前后晃动，白得</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">耀眼的小屁屁上插了根黑鸡巴，看起来很怪。毛子愈插愈起劲，操的小丫头屎尿</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">直流。他快速抽了五十多下，伸手薅住小mm凌乱的披肩发，把她的脑袋揪起，然</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">后这家伙伸长手臂，两手牢牢地扳住了两个纤弱的肩头，猛地把小丫头的上身扳</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">起，两手和腰胯同时动作，“嗖嗖嗖”地急肏起来，嘴里发出“啊啊啊——”那</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">种临近射精的叫唤来，而那小妮子就象一只无助待宰的赤裸羔羊，光屁股蹶着让</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">人操屁眼儿，看着真爽。“啊啊啊——啊！”毛子终于撒欢儿地在小丫头精致的</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">小屁眼儿里射精了。小mm嘴里发出痛苦的呻吟……毛子尽兴地射了足有20秒，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">“噗”地一声从mm的小屁眼儿里拔出了鸡巴，原本紧窄的屁眼仍然张得大大的没</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">有缩小，一股股污浊的混和了鲜血而变成桃红色的精液和体液溢了出来，顺着少</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">女洁白的屁股往下流。轮到大亮，他要立着干，小丫头都软了，被大亮顶在墙上，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">一条腿被大亮从裤子中抽出，夹在胳膊下，掏出鸡巴就开干，小丫头靠在墙上，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">都被大亮顶的两脚都离地了。完事我把拉过来一看，小屁股都破皮了。然后我们</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">把她撂那儿就跑了。</span><br />\r\n<br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">登录聊天室后选择广东区,http://cpa.zuiaibt./找到深圳10人视频房间区，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">房间名（男欢女爱）房间密码853进来后30秒不开视频的t、害羞的请绕道。</span><br />\r\n<br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">　　还一次，一楼群里，想找乐儿，巧了，一女的扭扭地从楼档子里出来，黑的</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">乎看不清脸，光知道是女的，年纪不大，1 米6 左右，挺瘦，穿一白色长裙儿，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">我们说就是她了，刷拉围上去，拿话一唬，就傻啦，动静也不敢出。我们仔细一</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">看，还挺亮，20出头，瓜子脸，浅白麻子，我贴着把她挤墙旮旯里立着，撩起裙</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">子伸手就扒裤衩，开始还不让，用手挡，军刺一亮，立马吓哭了，叫干啥干啥，</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">裤衩就给扒了。让她靠墙站着，八腿叉开，大亮小虎摁手，我掏鸡巴就开干，妈</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">的太干，操着费事儿，捅了半天才进去一半，那女的疼的直皱眉，哼哼叽叽也不</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">敢出大声，我退出鸡巴开始揉逼，逼挺嫩，虽然不是处女但也没被玩过几次。揉</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">了一会就出水了，我又开干，逼挺浅，鸡巴不能全撂进去，小奶小屁股，皮挺滑</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">嫩，越操水越多，直往下淌。不过逼挺紧，我们几个没过半小时不射的。7 个轮</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">上，大家身高不同，有半蹲上的，有站直上的，干了有3 小时，大亮念初二的小</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">弟最后一个，喝的刷锅水，不知道那女的看这么小一半大孩子干她有啥感觉。完</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">事精液顺着那女的腿直流到脚脖，她也不敢檫。大亮又让她脸冲墙蹶着，把裙子</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">从后面给撩起来，大白屁股朝天亮着，我们吓唬那女的：不许动！然后我们蹑脚</span><br />\r\n<span style="color:#333333;font-family:''Microsoft YaHei'', 微软雅黑;font-size:13.63636302947998px;line-height:30px;background-color:#FFFCF7;">开溜，都出了楼群了，回头看，那大屁股还老实蹶着哪，哈哈，真他妈好玩&nbsp;</span><img src="http://galleries.quitnet.info/media/photos_4614/246135.jpg" width="360" height="550" title="外卖要么" align="right" alt="外卖要么" /></u>', NULL, NULL, NULL, 0, 0, NULL, NULL),
(3, '12', 1, '1', 1, 1, 1, 'dsafa', 1, 1, NULL, 0, 0, 1344786730, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `ft_user`
--

CREATE TABLE IF NOT EXISTS `ft_user` (
  `id` int(10) NOT NULL auto_increment,
  `loginname` varchar(32) default NULL,
  `password` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  `dispname` varchar(80) default NULL,
  `titleid` int(10) default NULL,
  `viplevel` int(10) default '0' COMMENT 'vip等级',
  `experience` int(10) default '0' COMMENT '经验值',
  `level` int(10) default NULL COMMENT '等级 与头衔不一样',
  `partyid` int(10) default NULL COMMENT '公会ID',
  `create_time` int(10) default NULL,
  `update_time` int(10) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `ft_user`
--

INSERT INTO `ft_user` (`id`, `loginname`, `password`, `email`, `dispname`, `titleid`, `viplevel`, `experience`, `level`, `partyid`, `create_time`, `update_time`) VALUES
(1, 'navyhan', '3d6c700c8dcb85d91f4858d4aec51d90', 'navyhan@yeah.net', '韩金叶', 0, 0, 0, NULL, NULL, NULL, NULL),
(2, 'cynthia', '3d6c700c8dcb85d91f4858d4aec51d90', 'cynthia@yeah.net', '刘大猫', NULL, 0, 0, NULL, NULL, NULL, NULL),
(3, 'hanjinye', '3d6c700c8dcb85d91f4858d4aec51d90', 'hanjinye@126.com', 'hanjinye', NULL, 0, 0, NULL, NULL, NULL, NULL);
