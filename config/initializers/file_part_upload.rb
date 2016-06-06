FilePartUpload.config do
  mode :qiniu

  # 配置 qiniu 使用的 bucket 名称
  qiniu_bucket         ENV['qiniu_bucket']

  # 配置 qiniu 使用的 bucket 的 domain
  qiniu_domain         ENV['qiniu_domain']

  # 配置要使用 bucket 的 子路径
  # 比如 base_path 如果是 "f",那么文件会上传到 bucket 下的 f 子路径下
  qiniu_base_path      ENV['qiniu_base_path']

  # 配置 qiniu 账号的 app access key
  qiniu_app_access_key ENV['qiniu_app_access_key']

  # 配置 qiniu 账号的 app secret key
  qiniu_app_secret_key ENV['qiniu_app_secret_key']

  # 配置 qiniu callback host
  # 文件上传完毕后，如果需要转码，提交转码请求给七牛后，当转码完毕后，七牛会发送请求给 App-Server
  # 所以这里需要配置 App-Server Host,并且可以被公网访问
  qiniu_callback_host  ENV['qiniu_callback_host']
end
