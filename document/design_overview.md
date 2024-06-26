# 設計
## 1. 業務フロー
![image](https://github.com/rem0930/HobbyConnect/assets/83850299/7bae5b8f-79c4-4c71-a1d5-239a5136fb4b)

## テーブル定義書

### 1. users（ユーザーテーブル）

| カラム名           | データ型         | 制約                                | 初期値                    |
|------------------|------------------|------------------------------------|--------------------------|
| id               | INT              | PRIMARY KEY, AUTO_INCREMENT        | 　　　　                    |
| email            | VARCHAR(255)     | UNIQUE, NOT NULL                   | 　　　　　　                     |
| password_digest  | VARCHAR(255)     | NOT NULL                           |                      |
| user_name        | VARCHAR(30)      | NOT NULL                           | 'anonymous'              |
| profile_photo    | VARCHAR(255)     |                                    |                          |
| background_photo | VARCHAR(255)     |                                    |                          |
| bio              | VARCHAR(250)     |                                    | 'No bio available'       |
| created_at       | DATETIME         | NOT NULL                           | CURRENT_TIMESTAMP        |
| updated_at       | DATETIME         | NOT NULL                           | CURRENT_TIMESTAMP        |


### 2. teams（チームテーブル）

| カラム名          | データ型        | 制約              | 初期値                  |
|-------------------|-----------------|-------------------|-------------------------|
| id                | INT             | PRIMARY KEY, AUTO_INCREMENT | なし                   |
| user_id          | INT             | FOREIGN KEY       | なし                   |
| name              | VARCHAR(50)     | NOT NULL          | なし                   |
| details           | TEXT            |                   |                         |
| profile_photo    | VARCHAR(255)     |                                    |                          |
| background_photo | VARCHAR(255)     |                                    |                          |
| created_at        | DATETIME        | NOT NULL          | CURRENT_TIMESTAMP       |
| updated_at        | DATETIME        | NOT NULL          | CURRENT_TIMESTAMP       |

* FOREIGN KEY (user_id) REFERENCES users(id)


### 3. recruitments（投稿テーブル）

| カラム名       | データ型           | 制約                      | 初期値            | 説明             |
|---------------|--------------------|---------------------------|------------------|------------------|
| id            | INT                | PRIMARY KEY, AUTO_INCREMENT | なし             | 募集ID           |
| team_id       | INT                | FOREIGN KEY                | なし             | チームID          |
| type          | ENUM('member', 'opponent', 'helper') | NOT NULL | なし       | 募集タイプ       |
| title         | VARCHAR(255)       | NOT NULL                  | なし             | 募集タイトル     |
| description   | TEXT               | NOT NULL                  | なし             | 募集内容（bio風）|
| location_id   | INT                | FOREIGN KEY　　　　　　　　　　　　           | なし             | ロケーションID   |
| event_date    | DATETIME           | 　　　　　　　　                      |                  | 開催日時           |
| deadline      | DATETIME           | 　　　　　　　　                      |                  | 募集期限         |
| status        | ENUM('open', 'closed') | NOT NULL              | 'open'           | 募集状態         |
| created_at    | DATETIME           | NOT NULL                  | NOT NULL DEFAULT CURRENT_TIMESTAMP | 作成日時         |
| updated_at    | DATETIME           | NOT NULL                  | NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新日時         |


### 4. likes（いいねテーブル）

| カラム名    | データ型    | 制約                      | 初期値            | 説明         |
|------------|-------------|---------------------------|------------------|--------------|
| id         | INT         | PRIMARY KEY, AUTO_INCREMENT | なし           | いいねID     |
| user_id    | INT         | FOREIGN KEY                | なし           | ユーザーID   |
| post_id    | INT         | FOREIGN KEY                | なし           | 投稿ID       |
| created_at | DATETIME    | NOT NULL                  | CURRENT_TIMESTAMP | いいねした日時 |


### 5. notifications（通知テーブル）

| カラム名          | データ型        | 制約              | 初期値            | 説明                       |
|-------------------|-----------------|-------------------|------------------|----------------------------|
| id                | INT             | PRIMARY KEY, AUTO_INCREMENT | なし       | 通知ID                   |
| user_id           | INT             | FOREIGN KEY       | なし             | ユーザーID                 |
| message           | VARCHAR(255)    | NOT NULL          | なし             | 通知メッセージ             |
| read              | BOOLEAN         | NOT NULL          | FALSE            | 既読状態（既読、未読）     |
| created_at        | DATETIME        | NOT NULL          | CURRENT_TIMESTAMP | 通知日時                   |


### 6. messages テーブル

| カラム名          | データ型        | 制約              | 初期値            | 説明               |
|-------------------|-----------------|-------------------|------------------|--------------------|
| id                | INT             | PRIMARY KEY, AUTO_INCREMENT | なし           | メッセージID      |
| conversation_id   | INT             | FOREIGN KEY       | なし             | 会話ID             |
| sender_id         | INT             | FOREIGN KEY       | なし             | 送信者のユーザーID |
| message_text      | TEXT            | NOT NULL          | なし             | メッセージの内容   |
| created_at        | DATETIME        | NOT NULL          | CURRENT_TIMESTAMP | 作成日時           |

### 7. conversations テーブル

| カラム名       | データ型        | 制約              | 初期値            | 説明         |
|----------------|-----------------|-------------------|------------------|--------------|
| id             | INT             | PRIMARY KEY, AUTO_INCREMENT | なし       | 会話ID       |
| created_at     | DATETIME        | NOT NULL          | CURRENT_TIMESTAMP | 作成日時     |

### 8. participants テーブル

| カラム名          | データ型        | 制約              | 初期値            | 説明         |
|-------------------|-----------------|-------------------|------------------|--------------|
| conversation_id   | INT             | FOREIGN KEY       | なし             | 会話ID       |
| user_id           | INT             | FOREIGN KEY       | なし             | ユーザーID   |


### 9. locations テーブル

| カラム名       | データ型         | 制約                      | 初期値 | 説明               |
|----------------|------------------|---------------------------|--------|--------------------|
| id             | INT              | PRIMARY KEY, AUTO_INCREMENT | なし | ロケーションID     |
| name           | VARCHAR(255)     |                           |        | 地域の名称         |
| latitude       | DECIMAL(10, 8)   | NOT NULL                  |        | 緯度               |
| longitude      | DECIMAL(11, 8)   | NOT NULL                  |        | 経度               |
| address        | VARCHAR(255)     |                           |        | 完全な住所         |
| description    | TEXT             |                           |        | 位置に関する説明   |


## システム構成

### クライアントサイド
- **技術**: Next.js, React, Chakra UI
- **機能**:
  - ユーザーインターフェースの提供
  - サーバーからのデータのリクエストと表示
  - ユーザー入力の処理とバリデーション

### サーバーサイド
- **技術**: Rails 7
- **機能**:
  - REST APIの提供
  - ビジネスロジックの処理
  - 認証とセキュリティの管理
  - データベースとの通信
  - WebSocketサーバーのセットアップ

### データベース
- **技術**: MySQL
- **機能**:
  - ユーザー情報、チーム情報、イベントデータなどの永続化
  - データの整合性とセキュリティの保持

### 認証サービス
- **オプション**: AWS Cognito, Google Auth
- **機能**:
  - ユーザー認証
  - セキュアなアクセス制御

### ソーシャルログイン
- **技術**: Twitter Developer Platform
- **機能**:
  - Twitterを通じたユーザー認証のサポート

### 通信インフラ
- **技術**: WebSocket
- **機能**:
  - リアルタイムでのデータの交換（チャット、イベント更新など）

### コンテナ化
- **技術**: Docker
- **機能**:
  - 各サービスの環境一貫性と隔離
  - 開発、テスト、本番環境の一致

### バージョン管理とCI/CD
- **技術**: GitHub
- **機能**:
  - ソースコードのバージョン管理
  - 自動化されたビルドとデプロイメント

### セキュリティ対策
- HTTPSを通じた通信の暗号化
- データベースへのアクセスにはパラメータ化クエリを使用
- ユーザーパスワードのハッシュ化と安全なストレージ
