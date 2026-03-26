# Hammerspoon 代码规范

## 代码简化原则

### 1. 参考简洁实现
- 当存在功能相似但更简洁的实现时，优先参考简洁版本
- 避免过度工程化，保持代码的简单性
- 例：参考 `modules/apps/restart.lua` 来简化应用重启实现

### 2. 模块化设计
- 使用 `modules/core/utils.lua` 中的标准模块创建函数
- 通过 `utils.createAppModule()` 创建模块
- 保持统一的模块结构：`init()`, `checkDeps()`, `setupHotkeys()`

### 3. 公共函数优先
- 优先使用 `modules/core/utils.lua` 中的公共函数
- 避免重复实现相同功能
- 使用统一的提示函数：`showInfo()`, `showError()`, `show_success_notification()` 等

### 4. 去除不必要的复杂性
- 移除过度的错误处理和验证
- 删除不常用的功能分支
- 简化配置选项，使用合理的默认值

### 5. 保持核心功能
- 确保简化后仍保留主要功能
- 不要为了简洁而牺牲必要的功能
- 保持向后兼容性

## 代码风格

### 1. 格式规范
```lua
-- 良好的间距和缩进
function M.functionName()
    local variable = getValue()
    
    if not variable then
        utils.showError("错误信息")
        return false
    end
    
    -- 逻辑处理
    processLogic()
    
    return true
end
```

### 2. 热键绑定
```lua
function M.setupHotkeys()
    M:addHotkey({"cmd", "shift"}, "Q", M.functionName, "功能描述")
    utils.showInfo("热键已设置")
end
```

### 3. 依赖检查
```lua
function M.checkDeps()
    return utils.checkModule("hs.application") and 
           utils.checkModule("hs.hotkey") and 
           utils.checkModule("hs.timer")
end
```

## 最佳实践

### 1. 错误处理
- 使用 `utils.showError()` 显示错误信息
- 在关键点进行必要的检查
- 避免过度的错误处理

### 2. 用户反馈
- 使用中文提示信息
- 提供清晰的操作反馈
- 使用合适的图标前缀（✅ ❌ ⚠️ ℹ️ 🔄）

### 3. 定时器使用
- 使用 `hs.timer.doAfter()` 进行延迟操作
- 合理设置延迟时间（通常1秒足够）
- 避免复杂的嵌套定时器

### 4. 模块初始化
```lua
function M.init()
    -- 模块初始化代码
    return true
end

return M
```

## 重构检查清单

- [ ] 是否使用了公共函数？
- [ ] 是否保持了模块化结构？
- [ ] 是否去除了不必要的复杂性？
- [ ] 是否保持了核心功能？
- [ ] 是否提供了适当的用户反馈？
- [ ] 是否遵循了代码风格规范？
- [ ] 是否进行了必要的依赖检查？ 