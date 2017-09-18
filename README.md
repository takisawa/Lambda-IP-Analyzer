# Lambda-IP-Analyzer

## 概要
AWS LambdaのグローバルIPがどのように割り振られるか調べるためのプログラム


## 構成
- index.js: AWS Lambda に登録する function
- driver.js: index.js のローカル確認に使用
- lambda_ip_analyzer.rb: LambdaにアクセスしてIPの結果を表示

## Lambda で参照する環境変数
- SLEEP_SEC: 処理開始前に sleep する秒数
- RETURN_CLIENT_IP_URL: クライアントIPを返すページのURL


## ruby で参照する環境変数
- LAMBDA_APIS: Lambda を公開している API のリスト
- THREAD_COUNT: API クライアントのスレッド数
- LOOP_COUNT: API クライアントのループ数

## 想定
1. クライアントIPを返すだけのページを用意する。
   - Amazon API Gatewayを使用する。
2. 上記の URL を RETURN_CLIENT_IP_URL に設定し、Lambda登録
3. lambda_ip_analyzer.rb で結果を表示
