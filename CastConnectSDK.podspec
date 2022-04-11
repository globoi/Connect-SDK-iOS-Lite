# frozen_string_literal: true

Pod::Spec.new do |spec|
  spec.name         = 'CastConnectSDK'
  spec.version      = '2.0.0'
  spec.summary      = 'Connect SDK iOS Lite'
  spec.description  = <<-DESC
    Connect SDK is an open source framework that connects your mobile apps with multiple TV platforms.
  DESC

  spec.homepage      = 'https://github.com/globoi/Connect-SDK-iOS-Lite.git'
  spec.license       = { type: 'proprietary', file: 'LICENSE' }
  spec.author        = { 'globoID Mobile' => 'globoid.mobile@g.globo' }
  spec.module_name   = 'CastConnectSDK'
  spec.source        = { :git => 'https://github.com/globoi/Connect-SDK-iOS-Lite.git', :tag => spec.version.to_s, :submodules => true }
  spec.platforms     = { ios: '7.1' }

  spec.xcconfig = { 'OTHER_LDFLAGS': '$(inherited) -ObjC' }
  spec.requires_arc  = true
  spec.prefix_header_contents =  <<-PREFIX
                                      //
                                      //  Prefix header
                                      //
                                      //  The contents of this file are implicitly included at the beginning of every source file.
                                      //
                                      //  Copyright (c) 2015 LG Electronics.
                                      //
                                      //  Licensed under the Apache License, Version 2.0 (the "License");
                                      //  you may not use this file except in compliance with the License.
                                      //  You may obtain a copy of the License at
                                      //
                                      //      http://www.apache.org/licenses/LICENSE-2.0
                                      //
                                      //  Unless required by applicable law or agreed to in writing, software
                                      //  distributed under the License is distributed on an "AS IS" BASIS,
                                      //  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
                                      //  See the License for the specific language governing permissions and
                                      //  limitations under the License.
                                      //
                                      
                                      #define CONNECT_SDK_VERSION @"#{spec.version}"
                                      
                                      // Uncomment this line to enable SDK logging
                                      //#define CONNECT_SDK_ENABLE_LOG
                                      
                                      #ifndef kConnectSDKWirelessSSIDChanged
                                      #define kConnectSDKWirelessSSIDChanged @"Connect_SDK_Wireless_SSID_Changed"
                                      #endif
                                      
                                      #ifdef CONNECT_SDK_ENABLE_LOG
                                          // credit: http://stackoverflow.com/a/969291/2715
                                          #ifdef DEBUG
                                          #   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
                                          #else
                                          #   define DLog(...)
                                          #endif
                                      #else
                                          #   define DLog(...)
                                      #endif
                                    PREFIX

  spec.static_framework  = true

  spec.libraries = 'z', 'icucore'

  spec.subspec 'Core' do |sub|
    sub.source_files = [
      'ConnectSDKDefaultPlatforms.h',
      'core/**/*.{h,m}'
    ]

    sub.exclude_files = [
      'core/Frameworks/asi-http-request/External/Reachability/*.{h,m}',
      'core/Frameworks/asi-http-request/Classes/*.{h,m}',
      'core/ConnectSDK*Tests/**/*',
    ]
    
    sub.requires_arc = true
    sub.dependency 'CastConnectSDK/no-arc'

  end

  spec.subspec 'no-arc' do |sub|
    sub.source_files = [
      'core/Frameworks/asi-http-request/External/Reachability/*.{h,m}',
      'core/Frameworks/asi-http-request/Classes/*.{h,m}'
    ]
    
    sub.requires_arc = false
    sub.compiler_flags = '-w'
  end

  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'EXCLUDED_ARCHS[sdk=appletvsimulator*]' => 'arm64',
  }
  spec.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'EXCLUDED_ARCHS[sdk=appletvsimulator*]' => 'arm64',
  }
end
