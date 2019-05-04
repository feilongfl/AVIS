# AVIS Media Center

> 这是一个基于flutter的媒体中心，致力于在线媒体资源的浏览。

## warning
项目正在积极开发中，部分功能可能无法正常使用！

## 使用说明
### Agent
> Agent 用于执行具体的操作请求
#### Http Agent（developing）
用于http请求，目前正在开发中，仅支持get方法，不支持自定义头
#### Base64 Agent
base64编解码。
#### Eventformat Agent
产生event消息。
#### Actas Agent（todo）
使用其他Source的Agent序列。
#### Regexp Agent
使用正则表达式格式化内容。
#### Url Codecs Agent
url编解码器
### Source
> Source 用于记录网站的爬取规则，由若干Agent组成。
### Settings
#### homepage tab setting
通过此处设置首页标签，每个标签可以选择多个支持homepage解析的Source。
### Media View
> Media View用于展示最终结果。
#### 单页面文档
提供类似新闻类资源的展示界面。
#### 带章节文档（developing）
提供类似网络小说等带有章节的文本类资源展示界面
#### 无章节图片预览（todo）
提供不包含章节信息的图片浏览界面。
#### 带章节图片预览
提供类似漫画等包含章节信息图片的浏览界面。
#### 音乐播放器（todo）
提供音频类资源的播放。
#### 视频播放器
播放视频。  
![](./pictures/video_land_view.png)






