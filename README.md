# RestaurantSearchApp

## 開発環境
- Xcode 15.0
- iOS 17.0
- Swift 5.9
- SwiftUI 5.0

## 開発期間
7日間

## HotPepperAPI
1. [HotPepperAPIキーの取得](https://webservice.recruit.co.jp/register/)
2. 以下のコードを追加し、xxxxxxxxxxxxを自身のAPIキーに変更する
```APIKey.swift
let apiKey = "xxxxxxxxxxxx"
```
## アプリケーション機能

### 機能一覧
- レストラン検索：ホットペッパーグルメサーチAPIを使用して、現在地周辺の飲食店を検索する。
- レストラン情報取得：ホットペッパーグルメサーチAPIを使用して、飲食店の詳細情報を取得する。

### 画面一覧
- 検索・結果一覧画面：キーワードと現在地の範囲を指定してレストランを検索する。
- 店舗詳細画面：検索結果の飲食店の詳細情報を一覧表示する。

### 使用しているAPI,SDK,ライブラリなど
- ホットペッパーグルメサーチAPI
- Nuke

### コンセプト
- 近くのお店がすぐに見つかる。

### こだわったポイント
- Nukeライブラリを使用して画像の表示速度を上げた。
- 引っ張って検索結果を更新することが出来るリフレッシュ機能を追加した。
- サーバーエラーや位置情報取得できない場合にアラートを表示するようにした。

## スクリーンショット UIKit
<table>
  <tr>
    <td>
      <img src="https://github.com/k20rs141/OmikujiApp/assets/90810018/453aac02-ef1e-4903-abda-ee10c8927293" width="20%">
      <img src="https://github.com/k20rs141/OmikujiApp/assets/90810018/1e069063-a8d1-42d3-a9cc-3f33e4602d43" width="20%">
      <img src="https://github.com/k20rs141/OmikujiApp/assets/90810018/234cc774-f0cc-40f9-a27b-0f07cbd02b0a" width="20%">
    </td>
  </tr>
</table>

## スクリーンショット SwiftUI
