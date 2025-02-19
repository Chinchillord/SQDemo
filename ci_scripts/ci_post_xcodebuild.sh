#!/bin/sh

#  ci_post_xcodebuild.sh
#  SQDemo
#
#  Created by Michael Rack on 2/19/25.
#
  
  # extract coverage data from project using xcode native tool
  brew install sonar-scanner
  bash xccov-to-sonarqube-generic.sh /Volumes/workspace/*.xcresult > AAAAA.xml
  cat AAAAA.xml
sonar-scanner \
  -Dsonar.organization=chinchillord \
  -Dsonar.projectKey=Chinchillord_SQDemo \
  -Dsonar.sources=. \
  -Dsonar.host.url=https://sonarcloud.io
  -Dsonar.coverageReportPath=AAAAA.xml
