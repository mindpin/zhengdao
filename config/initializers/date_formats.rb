# 自定义时间格式化
# 参考：https://github.com/mindpin/tech-exp/issues/17

Time::DATE_FORMATS[:default] = "%Y-%m-%d %H:%M:%S"
Time::DATE_FORMATS[:local] = "%Y-%m-%d %H:%M"
Time::DATE_FORMATS[:short1] = "%m.%d %H:%M"

Time::DATE_FORMATS[:ch_date] = lambda { |time|
  months = %w(一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月)
  dates = %w(一日 二日 三日 四日 五日 六日 七日 八日 九日 十日 十一日 十二日 十三日 十四日 十五日 十六日 十七日 十八日 十九日 二十日 二十一日 二十二日 二十三日 二十四日 二十五日 二十六日 二十七日 二十八日 二十九日 三十日 三十一日)

  "#{months[time.localtime.month - 1]}#{dates[time.localtime.day - 1]}"
}