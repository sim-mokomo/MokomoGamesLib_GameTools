fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
### create_font_unity_assets
```
fastlane create_font_unity_assets
```

### notify_reports
```
fastlane notify_reports
```

### protobuf_create_source_file_list
```
fastlane protobuf_create_source_file_list
```

### update_unity_localized_info_all
```
fastlane update_unity_localized_info_all
```

### update_string_table_all
```
fastlane update_string_table_all
```

### update_store_metadata_files_process
```
fastlane update_store_metadata_files_process
```

### execute_on_host
```
fastlane execute_on_host
```

### execute_on_host_on_client_repo
```
fastlane execute_on_host_on_client_repo
```

### send_slack_message
```
fastlane send_slack_message
```
Slackメッセージを送信
### send_slack_error_message
```
fastlane send_slack_error_message
```

### notify_unity_build_result_all_from_github_action
```
fastlane notify_unity_build_result_all_from_github_action
```

### test
```
fastlane test
```

### test_docker_to_host
```
fastlane test_docker_to_host
```


----

## Android
### android upload_to_store
```
fastlane android upload_to_store
```
ストアへアップロード
### android unity_build
```
fastlane android unity_build
```


----

## iOS
### ios upload_to_store
```
fastlane ios upload_to_store
```
ストアへアップロード
### ios xcode_build
```
fastlane ios xcode_build
```
ストアアップロード用のXcodeビルド
### ios unity_build
```
fastlane ios unity_build
```


----

## linux
### linux unity_build
```
fastlane linux unity_build
```


----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
