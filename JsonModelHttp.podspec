Pod::Spec.new do |s|
  s.name             = 'JsonModelHttp'
  s.version          = '1.0.2'
  s.summary          = '整合简化Http+Json的网络调用'
  s.homepage         = 'https://github.com/wochen85/JsonModelHttp'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CHAT' => '312163862@qq.com' }
  s.source           = { :git => 'https://github.com/wochen85/JsonModelHttp.git', :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.dependency 'AFNetworking'
  s.dependency 'YYModel'

  s.source_files = 'JsonModelHttp/JsonModelHttp/*.{h,m}'

end
