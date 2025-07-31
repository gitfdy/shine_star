# ShineStar API 规范文档

## 1. 概述

### 1.1 API 基础信息
- **存储方式**: 本地存储 (Hive/SQLite)
- **数据格式**: JSON
- **字符编码**: UTF-8
- **无需网络**: 所有操作在本地完成

### 1.2 本地存储流程
```dart
// 初始化本地存储
await Hive.initFlutter();
await LocalStorageService.initialize();

// 数据操作示例
final ideas = await LocalStorageService.loadIdeas();
await LocalStorageService.saveIdea(newIdea);
```

## 2. 本地存储 API

### 2.1 本地数据操作
```dart
// 保存想法到本地
Future<void> saveIdea(Idea idea) async {
  await LocalStorageService.saveIdea(idea);
}

// 从本地加载想法
Future<List<Idea>> loadIdeas() async {
  return await LocalStorageService.loadIdeas();
}

// 删除本地想法
Future<void> deleteIdea(String ideaId) async {
  await LocalStorageService.deleteIdea(ideaId);
}

// 更新本地想法
Future<void> updateIdea(Idea idea) async {
  await LocalStorageService.updateIdea(idea);
}
```

### 2.2 本地设置管理
```dart
// 保存应用设置
Future<void> saveSettings(Map<String, dynamic> settings) async {
  await LocalStorageService.saveSettings(settings);
}

// 加载应用设置
Map<String, dynamic> loadSettings() {
  return LocalStorageService.loadSettings();
}

// 重置所有设置
Future<void> resetSettings() async {
  await LocalStorageService.resetSettings();
}
```

### 2.3 数据备份和恢复
```dart
// 导出数据
Future<String> exportData() async {
  final ideas = await LocalStorageService.loadIdeas();
  final settings = LocalStorageService.loadSettings();
  return jsonEncode({
    'ideas': ideas.map((idea) => idea.toJson()).toList(),
    'settings': settings,
    'exportDate': DateTime.now().toIso8601String(),
  });
}

// 导入数据
Future<void> importData(String jsonData) async {
  final data = jsonDecode(jsonData);
  // 验证数据格式
  // 导入想法数据
  // 导入设置数据
}
```

## 3. 想法记录 API

### 3.1 创建想法记录
```dart
// 创建新想法
Future<Idea> createIdea({
  required String title,
  required String content,
  required String contentType,
  List<String> tags = const [],
  String? mediaPath,
}) async {
  final idea = Idea(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    title: title,
    content: content,
    contentType: contentType,
    createdAt: DateTime.now(),
    tags: tags,
    mediaPath: mediaPath,
  );
  
  await LocalStorageService.saveIdea(idea);
  return idea;
}
```

### 3.2 获取想法列表
```dart
// 获取所有想法
Future<List<Idea>> getAllIdeas() async {
  return await LocalStorageService.loadIdeas();
}

// 按日期获取想法
Future<List<Idea>> getIdeasByDate(DateTime date) async {
  final allIdeas = await LocalStorageService.loadIdeas();
  return allIdeas.where((idea) => 
    idea.createdAt.year == date.year &&
    idea.createdAt.month == date.month &&
    idea.createdAt.day == date.day
  ).toList();
}

// 按标签获取想法
Future<List<Idea>> getIdeasByTag(String tag) async {
  final allIdeas = await LocalStorageService.loadIdeas();
  return allIdeas.where((idea) => idea.tags.contains(tag)).toList();
}
```

### 3.3 更新想法记录
```dart
// 更新想法
Future<void> updateIdea(Idea idea) async {
  await LocalStorageService.updateIdea(idea);
}

// 删除想法
Future<void> deleteIdea(String ideaId) async {
  await LocalStorageService.deleteIdea(ideaId);
}

// 搜索想法
Future<List<Idea>> searchIdeas(String query) async {
  final allIdeas = await LocalStorageService.loadIdeas();
  return allIdeas.where((idea) =>
    idea.title.toLowerCase().contains(query.toLowerCase()) ||
    idea.content.toLowerCase().contains(query.toLowerCase()) ||
    idea.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()))
  ).toList();
}
```

### 3.4 删除想法记录
```javascript
// 请求
DELETE /rest/v1/ideas?id=eq.{idea_id}
Authorization: Bearer {access_token}

// 响应
{
  "success": true,
  "message": "想法记录已删除"
}
```

## 4. 文件上传 API

### 4.1 上传文件
```javascript
// 请求
POST /storage/v1/object/upload
Authorization: Bearer {access_token}
Content-Type: multipart/form-data

FormData:
- file: (binary file)
- bucket: "ideas"
- path: "user_id/filename.ext"

// 响应
{
  "id": "file_id",
  "name": "filename.ext",
  "bucket_id": "bucket_id",
  "owner": "user_id",
  "created_at": "2024-12-01T10:00:00Z",
  "updated_at": "2024-12-01T10:00:00Z",
  "last_accessed_at": "2024-12-01T10:00:00Z",
  "metadata": {
    "size": 1024000,
    "mimetype": "image/jpeg"
  }
}
```

### 4.2 获取文件URL
```javascript
// 请求
GET /storage/v1/object/sign/ideas/user_id/filename.ext
Authorization: Bearer {access_token}

// 响应
{
  "signedURL": "https://storage.supabase.co/...",
  "expiresIn": 3600
}
```

## 5. AI分析 API

### 5.1 批量分析
```javascript
// 请求
POST /functions/v1/analyze-ideas
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "user_id": "user_uuid",
  "time_range": {
    "start": "2024-12-01",
    "end": "2024-12-07"
  },
  "analysis_type": "comprehensive" // comprehensive, feasibility, suggestion
}

// 响应
{
  "analysis_id": "uuid",
  "status": "processing", // processing, completed, failed
  "progress": 50,
  "estimated_completion": "2024-12-01T10:30:00Z"
}
```

### 5.2 获取分析结果
```javascript
// 请求
GET /rest/v1/ai_analyses?idea_id=eq.{idea_id}&analysis_type=eq.comprehensive
Authorization: Bearer {access_token}

// 响应
{
  "id": "uuid",
  "idea_id": "idea_uuid",
  "analysis_type": "comprehensive",
  "content": {
    "summary": "本周您记录了15个想法，主要集中在产品创新和技能提升两个领域...",
    "key_insights": [
      "您的想法主要集中在技术实现方面",
      "有3个想法具有较高的商业价值",
      "建议优先考虑市场验证"
    ],
    "recommendations": [
      "建议对高价值想法进行深入调研",
      "可以考虑寻找合作伙伴",
      "建议制定详细的执行时间表"
    ],
    "feasibility_score": 75,
    "priority_ranking": [
      {
        "idea_id": "uuid",
        "title": "想法标题",
        "priority_score": 85,
        "reason": "具有高商业价值和可行性"
      }
    ]
  },
  "confidence": 0.85,
  "status": "completed",
  "created_at": "2024-12-01T10:00:00Z"
}
```

### 5.3 生成执行计划
```javascript
// 请求
POST /functions/v1/generate-action-plan
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "analysis_id": "analysis_uuid",
  "user_feedback": {
    "selected_ideas": ["idea_uuid_1", "idea_uuid_2"],
    "preferences": {
      "timeline": "8_weeks",
      "budget": "medium",
      "team_size": "small"
    }
  }
}

// 响应
{
  "plan_id": "uuid",
  "action_plan": {
    "timeline": {
      "week_1": ["市场调研", "用户访谈"],
      "week_2_3": ["原型设计", "技术验证"],
      "week_4_6": ["MVP开发", "测试反馈"],
      "week_7_8": ["产品发布", "市场推广"]
    },
    "resources": {
      "time": "每周20小时",
      "budget": "$5000",
      "team": "2-3人团队"
    },
    "milestones": [
      {
        "week": 1,
        "task": "完成市场调研报告",
        "deliverables": ["调研报告", "用户画像"]
      },
      {
        "week": 3,
        "task": "完成原型设计",
        "deliverables": ["产品原型", "技术方案"]
      }
    ],
    "risks": [
      {
        "risk": "技术实现难度",
        "probability": "medium",
        "impact": "high",
        "mitigation": "提前技术验证，准备备选方案"
      }
    ]
  },
  "created_at": "2024-12-01T10:00:00Z"
}
```

## 6. 订阅管理 API

### 6.1 检查订阅状态
```javascript
// 请求
GET /rest/v1/users?id=eq.{user_id}&select=subscription_status,subscription_end,trial_start
Authorization: Bearer {access_token}

// 响应
{
  "subscription_status": "active", // free, trial, active, expired
  "subscription_end": "2024-12-31T23:59:59Z",
  "trial_start": "2024-12-01T00:00:00Z"
}
```

### 6.2 处理Google Pay支付
```javascript
// 请求
POST /functions/v1/process-google-pay
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "payment_data": {
    "paymentMethodData": {
      "tokenizationData": {
        "token": "google_pay_token"
      }
    }
  },
  "amount": 5.00,
  "currency": "USD"
}

// 响应
{
  "success": true,
  "payment_id": "uuid",
  "subscription": {
    "status": "active",
    "start_date": "2024-12-01T00:00:00Z",
    "end_date": "2024-12-08T00:00:00Z"
  }
}
```

### 6.3 取消订阅
```javascript
// 请求
POST /functions/v1/cancel-subscription
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "reason": "用户主动取消"
}

// 响应
{
  "success": true,
  "message": "订阅已取消，将在当前周期结束后生效",
  "effective_date": "2024-12-08T00:00:00Z"
}
```

## 7. 错误处理

### 7.1 错误响应格式
```javascript
{
  "error": {
    "code": "ERROR_CODE",
    "message": "错误描述",
    "details": {
      "field": "具体字段",
      "value": "错误值"
    }
  }
}
```

### 7.2 常见错误码
| 错误码 | HTTP状态码 | 描述 |
|--------|------------|------|
| `AUTH_REQUIRED` | 401 | 需要认证 |
| `INVALID_TOKEN` | 401 | 无效的访问令牌 |
| `PERMISSION_DENIED` | 403 | 权限不足 |
| `RESOURCE_NOT_FOUND` | 404 | 资源不存在 |
| `VALIDATION_ERROR` | 422 | 数据验证失败 |
| `RATE_LIMIT_EXCEEDED` | 429 | 请求频率超限 |
| `INTERNAL_ERROR` | 500 | 服务器内部错误 |

### 7.3 错误处理示例
```dart
// 客户端错误处理
try {
  final response = await Supabase.instance.client
    .from('ideas')
    .insert(newIdea);
  
  if (response.error != null) {
    switch (response.error!.code) {
      case 'AUTH_REQUIRED':
        // 重新登录
        await handleReauth();
        break;
      case 'VALIDATION_ERROR':
        // 显示验证错误
        showValidationError(response.error!.details);
        break;
      default:
        // 显示通用错误
        showError(response.error!.message);
    }
  }
} catch (err) {
  // 网络错误处理
  handleNetworkError(err);
}
```

## 8. 实时功能

### 8.1 实时订阅
```dart
// 订阅想法记录变化
final subscription = Supabase.instance.client
  .channel('ideas')
  .onPostgresChanges(
    event: PostgresChangeEvent.all,
    schema: 'public',
    table: 'ideas',
    filter: PostgresChangeFilter(type: PostgresChangeFilterType.eq, column: 'user_id', value: userId),
  ).listen((payload) {
    print('想法记录变化: $payload');
    // 更新UI
    updateIdeasList(payload);
  });
```

### 8.2 分析进度更新
```javascript
// 订阅分析进度
const analysisSubscription = supabase
  .channel('analysis_progress')
  .on('postgres_changes', {
    event: 'UPDATE',
    schema: 'public',
    table: 'ai_analyses',
    filter: `id=eq.${analysisId}`
  }, (payload) => {
    console.log('分析进度更新:', payload);
    // 更新进度条
    updateProgressBar(payload.new.progress);
  })
  .subscribe();
```

## 9. 性能优化

### 9.1 分页查询
```dart
// 分页获取想法列表
final response = await Supabase.instance.client
  .from('ideas')
  .select('*')
  .eq('user_id', userId)
  .order('created_at', ascending: false)
  .range(0, 19); // 每页20条
```

### 9.2 批量操作
```javascript
// 批量删除想法
const { data, error } = await supabase
  .from('ideas')
  .delete()
  .in('id', ['uuid1', 'uuid2', 'uuid3']);
```

### 9.3 缓存策略
```javascript
// 缓存配置
const cacheConfig = {
  ideas: {
    ttl: 300000, // 5分钟
    maxSize: 100
  },
  analysis: {
    ttl: 600000, // 10分钟
    maxSize: 50
  }
};
```

---

**文档版本**：v1.0  
**最后更新**：2024年12月  
**维护者**：开发团队 