# ShineStar 技术架构文档

## 1. 系统架构概览

### 1.1 整体架构
```
移动端 App (Flutter)
    ↓
Supabase Auth (认证)
    ↓
媒体输入 → 本地处理 → Supabase Storage (文件存储)
    ↓
AI处理服务
├── Google Speech-to-Text (语音转文字)
├── Google Vision API (图片OCR)
└── OpenAI GPT-4 (内容分析)
    ↓
Supabase Database (数据存储)
    ↓
实时同步 → 移动端展示
```

### 1.2 技术栈选择理由
| 技术 | 选择理由 | 替代方案 |
|------|----------|----------|
| Flutter | 跨平台开发，性能优秀，UI一致性好 | React Native, Ionic |
| Supabase | 快速开发，内置认证和实时功能 | Firebase, AWS |
| OpenAI GPT-4 | AI分析能力强，API稳定 | Claude, PaLM |
| Google Pay | 欧美用户偏好，集成简单 | Stripe, PayPal |

## 2. 前端架构

### 2.1 项目结构
```
lib/
├── components/        # 可复用组件
│   ├── voice_recorder.dart
│   ├── camera_capture.dart
│   ├── text_input.dart
│   └── idea_card.dart
├── pages/            # 页面组件
│   ├── home_page.dart
│   ├── record_page.dart
│   ├── detail_page.dart
│   ├── analysis_page.dart
│   └── settings_page.dart
├── navigation/       # 导航配置
│   └── app_navigator.dart
├── services/         # API服务
│   ├── supabase_service.dart
│   ├── auth_service.dart
│   ├── storage_service.dart
│   └── ai_service.dart
├── controllers/      # GetX状态管理
│   ├── auth_controller.dart
│   ├── ideas_controller.dart
│   └── analysis_controller.dart
├── utils/           # 工具函数
│   ├── constants.dart
│   ├── helpers.dart
│   └── permissions.dart
└── assets/          # 静态资源
    ├── images/
    └── icons/
```

### 2.2 状态管理
```dart
// GetX 状态管理结构
class AuthController extends GetxController {
  final user = Rxn<User>();
  final isAuthenticated = false.obs;
  final loading = false.obs;
}

class IdeasController extends GetxController {
  final items = <Idea>[].obs;
  final loading = false.obs;
  final error = Rxn<String>();
}

class AnalysisController extends GetxController {
  final currentAnalysis = Rxn<Analysis>();
  final loading = false.obs;
  final error = Rxn<String>();
}

class SettingsController extends GetxController {
  final language = 'en'.obs;
  final notifications = true.obs;
  final autoSync = true.obs;
}
```

## 3. 后端架构

### 3.1 Supabase 配置
```dart
// Supabase 客户端配置
class SupabaseService {
  static final SupabaseClient _client = SupabaseClient(
    'YOUR_SUPABASE_URL',
    'YOUR_SUPABASE_ANON_KEY',
  );
  
  static SupabaseClient get client => _client;
  
  static Future<void> initialize() async {
    await _client.auth.onAuthStateChange.listen((data, session) {
      // 处理认证状态变化
    });
  }
}
```

### 3.2 数据库设计
```sql
-- 启用行级安全策略
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE ideas ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_analyses ENABLE ROW LEVEL SECURITY;

-- 用户表策略
CREATE POLICY "Users can view own profile" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON users
  FOR UPDATE USING (auth.uid() = id);

-- 想法表策略
CREATE POLICY "Users can view own ideas" ON ideas
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own ideas" ON ideas
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own ideas" ON ideas
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own ideas" ON ideas
  FOR DELETE USING (auth.uid() = user_id);
```

## 4. AI服务架构

### 4.1 AI服务集成
```dart
// AI服务配置
class AIService {
  static const String _openaiApiKey = 'YOUR_OPENAI_API_KEY';
  static const String _googleSpeechApiKey = 'YOUR_GOOGLE_SPEECH_API_KEY';
  static const String _googleVisionApiKey = 'YOUR_GOOGLE_VISION_API_KEY';
  
  static final Map<String, dynamic> openaiConfig = {
    'apiKey': _openaiApiKey,
    'model': 'gpt-4',
    'maxTokens': 1000,
    'temperature': 0.7,
  };
  
  static final Map<String, dynamic> googleSpeechConfig = {
    'apiKey': _googleSpeechApiKey,
    'language': 'en-US',
    'autoLanguageDetection': true,
  };
  
  static final Map<String, dynamic> googleVisionConfig = {
    'apiKey': _googleVisionApiKey,
    'features': ['TEXT_DETECTION', 'DOCUMENT_TEXT_DETECTION'],
  };
}
```

### 4.2 AI分析流程
```dart
// AI分析流程
class AIAnalysisFlow {
  // 1. 内容预处理
  static String preprocess(String content) {
    return _cleanAndFormatContent(content);
  }

  // 2. 批量分析
  static Future<Map<String, dynamic>> batchAnalyze(List<Record> records) async {
    final combinedContent = records.map((record) => 
      '${record.contentType}: ${record.content ?? record.transcript ?? record.ocrText}'
    ).join('\n\n');
    
    return await _callOpenAI('comprehensive_analysis', combinedContent);
  }

  // 3. 结果后处理
  static Map<String, dynamic> postprocess(Map<String, dynamic> analysis) {
    return _structureAnalysisResults(analysis);
  }
  
  static String _cleanAndFormatContent(String content) {
    // 清理和格式化内容
    return content.trim();
  }
  
  static Future<Map<String, dynamic>> _callOpenAI(String type, String content) async {
    // 调用OpenAI API
    return {};
  }
  
  static Map<String, dynamic> _structureAnalysisResults(Map<String, dynamic> analysis) {
    // 结构化分析结果
    return analysis;
  }
}
```

## 5. 支付架构

### 5.1 Google Pay 集成
```dart
// Google Pay 配置
class GooglePayConfig {
  static const Map<String, dynamic> config = {
    'environment': 'TEST', // 或 'PRODUCTION'
    'merchantInfo': {
      'merchantName': 'ShineStar',
      'merchantId': 'your-merchant-id'
    },
    'paymentMethods': [
      {
        'type': 'CARD',
        'parameters': {
          'allowedAuthMethods': ['PAN_ONLY', 'CRYPTOGRAM_3DS'],
          'allowedCardNetworks': ['VISA', 'MASTERCARD', 'AMEX']
        }
      }
    ]
  };
}
```

### 5.2 订阅管理
```dart
// 订阅状态管理
class SubscriptionManager {
  // 检查订阅状态
  static Future<Map<String, dynamic>?> checkSubscription(String userId) async {
    final response = await SupabaseService.client
        .from('users')
        .select('subscription_status, subscription_end')
        .eq('id', userId)
        .single();
    
    return response;
  }

  // 更新订阅状态
  static Future<void> updateSubscription(String userId, String status, String endDate) async {
    await SupabaseService.client
        .from('users')
        .update({
          'subscription_status': status,
          'subscription_end': endDate
        })
        .eq('id', userId);
  }
}
```

## 6. 性能优化

### 6.1 前端优化
```dart
// 性能优化策略
class PerformanceOptimizations {
  // 图片懒加载
  static const Map<String, dynamic> lazyLoading = {
    'threshold': 0.1,
    'rootMargin': '50px'
  };

  // 内存管理
  static const Map<String, dynamic> memoryManagement = {
    'maxCacheSize': 100,
    'cleanupInterval': 300000 // 5分钟
  };

  // 网络优化
  static const Map<String, dynamic> networkOptimization = {
    'requestTimeout': 10000,
    'retryAttempts': 3,
    'offlineSupport': true
  };
}
```

### 6.2 后端优化
```dart
// 数据库优化
class DatabaseOptimizations {
  // 索引优化
  static const List<String> indexes = [
    'CREATE INDEX idx_ideas_user_date ON ideas(user_id, date)',
    'CREATE INDEX idx_ideas_created_at ON ideas(created_at)',
    'CREATE INDEX idx_ai_analyses_idea_id ON ai_analyses(idea_id)'
  ];

  // 查询优化
  static const Map<String, dynamic> queryOptimizations = {
    'limitResults': 50,
    'usePagination': true,
    'cacheQueries': true
  };
}
```

## 7. 安全架构

### 7.1 数据安全
```javascript
// 安全配置
const securityConfig = {
  // 数据加密
  encryption: {
    algorithm: 'AES-256-GCM',
    keyRotation: true
  },

  // 权限控制
  permissions: {
    userData: 'user_own_data',
    sharedData: 'user_shared_data',
    adminData: 'admin_only'
  },

  // API安全
  apiSecurity: {
    rateLimiting: true,
    requestValidation: true,
    corsPolicy: 'strict'
  }
};
```

### 7.2 隐私保护
```javascript
// GDPR合规配置
const privacyConfig = {
  dataRetention: {
    userData: '7 years',
    analyticsData: '2 years',
    logs: '90 days'
  },
  
  userRights: {
    rightToDelete: true,
    rightToPortability: true,
    rightToRectification: true
  },
  
  consentManagement: {
    tracking: false,
    marketing: false,
    analytics: true
  }
};
```

## 8. 部署架构

### 8.1 环境配置
```javascript
// 环境配置
const environments = {
  development: {
    supabaseUrl: 'dev-supabase-url',
    apiKeys: 'dev-api-keys',
    features: 'all-features'
  },
  
  staging: {
    supabaseUrl: 'staging-supabase-url',
    apiKeys: 'staging-api-keys',
    features: 'production-features'
  },
  
  production: {
    supabaseUrl: 'prod-supabase-url',
    apiKeys: 'prod-api-keys',
    features: 'production-features'
  }
};
```

### 8.2 CI/CD 流程
```yaml
# GitHub Actions 配置
name: Deploy
on:
  push:
    branches: [main]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run tests
        run: npm test
  
  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build app
        run: npm run build
      - name: Upload to Google Play
        run: npm run deploy
```

## 9. 监控和日志

### 9.1 应用监控
```javascript
// 监控配置
const monitoringConfig = {
  // 性能监控
  performance: {
    trackAppStart: true,
    trackScreenLoad: true,
    trackApiCalls: true
  },

  // 错误监控
  errorTracking: {
    captureErrors: true,
    captureUnhandledRejections: true,
    sendToService: true
  },

  // 用户行为分析
  analytics: {
    trackUserActions: true,
    trackFeatureUsage: true,
    privacyCompliant: true
  }
};
```

### 9.2 日志管理
```javascript
// 日志配置
const loggingConfig = {
  levels: ['error', 'warn', 'info', 'debug'],
  format: 'json',
  destination: 'remote',
  retention: '30 days',
  sensitiveData: {
    exclude: ['password', 'token', 'apiKey']
  }
};
```

---

**文档版本**：v1.0  
**最后更新**：2024年12月  
**维护者**：开发团队 