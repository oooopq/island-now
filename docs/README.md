# Island Now — リリース用ドキュメント

App Store 公開と法的表記用の文案です。

| ファイル | 用途 |
|---|---|
| [app-store-ja.md](./app-store-ja.md) | App Store Connect の説明文・キーワード等 |
| [privacy-policy-ja.md](./privacy-policy-ja.md) | プライバシーポリシー（Web 公開用） |
| [terms-of-service-ja.md](./terms-of-service-ja.md) | 利用規約（Web 公開用） |

## 公開前チェックリスト

1. `[連絡先メールアドレス]` を実際の連絡先に差し替える
2. プライバシーポリシー・利用規約を **HTTPS でアクセスできる URL** に公開する  
   （GitHub Pages、Notion 公開ページ、自サイト等）
3. App Store Connect に以下を入力  
   - 説明文・キーワード → `app-store-ja.md`  
   - プライバシーポリシー URL  
   - App のプライバシー（データ収集の申告）
4. （任意）アプリ内の設定画面から上記 URL へリンクする

## App Store Connect「App のプライバシー」

2026年6月時点のアプリ実装に基づく目安:

- **データを収集しない** に近い申告が可能（サーバーへの個人情報送信なし）
- 位置情報は端末内のみ → 「データにリンクされない」「追跡に使用しない」
- 第三者 SDK（Analytics 等）を追加した場合は **必ず再確認**

## 免責

これらの文案はテンプレートです。個別の事業形態・地域・機能追加により要件が変わる場合があります。
