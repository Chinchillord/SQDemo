#!/bin/sh

#  ci_post_xcodebuild.sh
#  SQDemo
#
#  Created by Michael Rack on 2/19/25.
#
  
  # extract coverage data from project using xcode native tool
if [ "$CI_XCODEBUILD_ACTION" = "test-without-building" ]
then
    brew install sonar-scanner
    bash xccov-to-sonarqube-generic.sh /Volumes/workspace/*.xcresult > AAAAA.xml
    cat AAAAA.xml
    sonar-scanner \
      -Dsonar.projectBaseDir=/Volumes/workspace/repository \
      -Dsonar.organization=chinchillord \
      -Dsonar.projectKey=Chinchillord_SQDemo \
      -Dsonar.sources=SQDemo \
      -Dsonar.tests=SQDemo/SQDemoTests,SQDemo/SQDemoUITests \
      -Dsonar.host.url=https://sonarcloud.io \
      -Dsonar.coverageReportPaths=ci_scripts/AAAAA.xml \
      -Dsonar.scm.disabled=true
fi
