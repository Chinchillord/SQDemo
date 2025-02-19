#!/bin/sh

#  ci_post_xcodebuild.sh
#  SQDemo
#
#  Created by Michael Rack on 2/19/25.
#
  
  # extract coverage data from project using xcode native tool
  
  bash xccov-to-sonarqube-generic.sh /Volumes/workspace/*.xcresult > AAAAA.xml
  cat AAAAA.xml
  # run sonar scanner and upload coverage data with the current app version
  #TODO: Set up my api key? project name? What do we need here
  #sonar-scanner \
    #-Dsonar.projectVersion=${APP_VERSION}
