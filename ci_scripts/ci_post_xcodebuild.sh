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
    ls -la $CI_WORKSPACE/.git
    git status
    export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
    git status
    bash xccov-to-sonarqube-generic.sh /Volumes/workspace/*.xcresult > AAAAA.xml
    cat AAAAA.xml
    cd $(git rev-parse --show-toplevel)
    sonar-scanner \
    -Dsonar.organization=chinchillord \
    -Dsonar.projectKey=Chinchillord_SQDemo \
    -Dsonar.sources=. \
    -Dsonar.host.url=https://sonarcloud.io \
    -Dsonar.coverageReportPaths=AAAAA.xml \
fi
