Pod::Spec.new do |s|
s.name             = 'SWSkelethon'
s.version          = '0.7.3'
s.summary          = 'Core protocols'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
List of used protocols
DESC

s.homepage         = 'https://github.com/SkywellDevelopers/SWSkelethon'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'K.Krizhanovskii'=> 'k.kryzhanovsky@skywell.com.ua' }
s.source           = { :git => 'https://github.com/SkywellDevelopers/SWSkelethon.git', :tag => s.version.to_s }

s.ios.deployment_target = '9.0'

s.source_files     = 'SWSkelethon/Classes/**/*'
s.framework        = 'Foundation'
#s.ios.xcconfig     = { "OTHER_SWIFT_FLAGS[config=Debug]" => "-D DEBUG" }
#s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

s.dependency 'Alamofire', '4.5.1'
s.dependency 'AlamofireImage', '3.3'
s.dependency 'RxSwift',
s.dependency 'RxCocoa',
s.dependency 'RealmSwift', '2.10.1'
end
