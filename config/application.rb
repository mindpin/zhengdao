require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module KnowledgeCamp
  class Application < Rails::Application
    config.assets.precompile += %w{
      zhengdao.css
      zhengdao.js

      *.png *.svg
      *.ttf *.eot *.woff *.woff2 *.otf'
    }

    # 时区，国际化
    config.time_zone = 'Beijing'
    config.i18n.default_locale = 'zh-CN'.to_sym
    config.encoding = 'utf-8'
    config.autoload_paths += %W(#{config.root}/lib)

    # 允许 ajax 注册登录
    config.to_prepare do
      DeviseController.respond_to :html, :json
    end

    ### browserify coffee 引用
    config.browserify_rails.commandline_options = "-t coffee-reactify --extension='.coffee'"
  end
end
