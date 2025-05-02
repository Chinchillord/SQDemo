#!/bin/sh

# Fail early on errors
set -e

# This script runs after Xcode Cloud's build step, and if the action is `build-for-testing`,
# it re-runs tests with code coverage enabled, converts results to SonarQube format,
# and uploads them to SonarCloud for analysis.

# Only proceed if the workflow is Code Coverage Check
if [ "$CI_WORKFLOW" = "Code Coverage Check" ]
then
    # Remove any previous result bundle if it exists
    rm -rf $CI_RESULT_BUNDLE_PATH
        
    # Re-run tests using the same build, enabling code coverage and saving results
    xcodebuild \
      -project "/Volumes/workspace/repository/SQDemo.xcodeproj" \
      -scheme "SQDemo" \
      -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
      -enableCodeCoverage YES \
      -resultBundlePath $CI_RESULT_BUNDLE_PATH \
      test-without-building
      
    # Intall SonarScanner for coverage reporting
    brew install sonar-scanner
    
    # Convert `.xcresult` to SonarQube generic XML format
    bash xccov-to-sonarqube-generic.sh /Volumes/workspace/*.xcresult > AAAAA.xml
    
    # Run sonar-scanner to upload coverage to SonarCloud
    sonar-scanner \
      -Dsonar.projectBaseDir=/Volumes/workspace/repository \
      -Dsonar.organization=benpatterson48 \
      -Dsonar.projectKey=benpatterson48_SQDemo \
      -Dsonar.sources=. \
      -Dsonar.host.url=https://sonarcloud.io \
      -Dsonar.coverageReportPaths=ci_scripts/AAAAA.xml \
      -Dsonar.scm.disabled=true
else
    echo "==> Not running sonar-scanner or PR check process."
fi
