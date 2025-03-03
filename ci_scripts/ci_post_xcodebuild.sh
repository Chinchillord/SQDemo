#!/bin/sh

#  ci_post_xcodebuild.sh
#  SQDemo
#
#  Created by Michael Rack on 2/19/25.
#
  
  # extract coverage data from project using xcode native tool
echo $(git rev-parse --show-toplevel)
ls $(git rev-parse --show-toplevel)
ls $(git rev-parse --show-toplevel) | echo
if [ "$CI_XCODEBUILD_ACTION" = "test-without-building" ]
then
    brew install sonar-scanner
    bash xccov-to-sonarqube-generic.sh /Volumes/workspace/*.xcresult > AAAAA.xml
    cat AAAAA.xml
    cd $(git rev-parse --show-toplevel)
    sonar-scanner \
    -Dsonar.organization=chinchillord \
    -Dsonar.projectKey=Chinchillord_SQDemo \
    -Dsonar.sources=. \
    -Dsonar.host.url=https://sonarcloud.io \
    -Dsonar.coverageReportPaths=AAAAA.xml \
    -Dsonar.scm.provider=git
fi
