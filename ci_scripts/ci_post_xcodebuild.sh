#!/bin/sh

#  ci_post_xcodebuild.sh
#  SQDemo
#
#  Created by Michael Rack on 2/19/25.
#
    rm -rf $CI_RESULT_BUNDLE_PATH
        
    xcodebuild \
      -project "$CI_XCODE_PROJECT" \
      -scheme "SQDemo" \
      -destination 'platform=iOS Simulator,name=iPhone 16' \
      -enableCodeCoverage YES \
      -resultBundlePath $CI_RESULT_BUNDLE_PATH \
      test-without-building
      
    brew install sonar-scanner
    bash xccov-to-sonarqube-generic.sh /Volumes/workspace/*.xcresult > AAAAA.xml
    cat AAAAA.xml
    echo "==> Full repository dump:"
    find /Volumes/workspace/repository -print
    echo "==> Tree dump of repo (all files):"
    find /Volumes/workspace/repository | sort
    echo "==> Listing contents under expected test paths:"
    find /Volumes/workspace/repository/SQDemoTests -type f
    find /Volumes/workspace/repository/SQDemoUITests -type f
    sonar-scanner \
      -Dsonar.organization=benpatterson48 \
      -Dsonar.projectKey=benpatterson48_SQDemo \
      -Dsonar.sources=. \
      -Dsonar.host.url=https://sonarcloud.io \
      -Dsonar.coverageReportPaths=AAAAA.xml \
      -Dsonar.scm.disabled=true
