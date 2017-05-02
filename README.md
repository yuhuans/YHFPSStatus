# YHFPSStatus
在状态栏显示FPS当前状态

## 使用说明

拖动文件YHFPSStatus.swift到您的项目

```
  YHFPSStatus.shared().open()
        YHFPSStatus.shared().fpsChange={ str in
            print(str)
        }

```