# ------------------------------

# 对Date的扩展，将 Date 转化为指定格式的String   
# 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
# 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
# 例子：   
# jQuery.format_date new Date(), "yyyy-MM-dd hh:mm:ss.S" ==> 2006-07-02 08:09:04.423   
# jQuery.format_date new Date(), "yyyy-M-d h:m:s.S"      ==> 2006-7-2 8:9:4.18   
jQuery.format_date = (date, fmt)->
  o =
    "M+" : date.getMonth() + 1
    "d+" : date.getDate()
    "h+" : date.getHours()
    "m+" : date.getMinutes()
    "s+" : date.getSeconds()
    "q+" : Math.floor((date.getMonth() + 3) / 3) # 季度
    "S"  : date.getMilliseconds()

  if /(y+)/.test fmt
    fmt = fmt.replace RegExp.$1, "#{date.getFullYear()}".substr(4 - RegExp.$1.length)

  for k, v of o
    if new RegExp("(#{k})").test fmt
      fmt = fmt.replace RegExp.$1, if RegExp.$1.length == 1 then v else "00#{v}".substr "#{v}".length

  fmt