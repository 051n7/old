#!/bin/bash

# 秘密鍵の内容を変数に保存
PRIVATE_KEY_CONTENT=$(cat <<'EOF'
-----BEGIN OPENSSH PRIVATE KEY-----
MIIEpAIBAAKCAQEA3EXAMPLEwRzTcxRQs9T24lBNzOcvVBSsKDk/Ps+K6vWE6WwA
+g7IEEXAMPLE7aIcAz82tmUI8mFEMPEXBvlxvD0fsd/UqMEXAMPLE+zgWih/xH10
/Q3OiyEXAMPLErFlUWX1rMiAIhx0RTYP+lv/PjTxexG2kEXAMPLE6YCPQIDAQAB
AoIBAEEXAMPLE5faImKUXRSb3EXAMPLEnRZm/fQ5A==
-----END OPENSSH PRIVATE KEY-----
EOF
)

# 一時ファイルに秘密鍵を書き込み
PRIVATE_KEY_FILE=$(mktemp)
echo "$PRIVATE_KEY_CONTENT" > "$PRIVATE_KEY_FILE"
chmod 600 "$PRIVATE_KEY_FILE"

# 設定
REMOTE_USER="username"                    # リモートサーバーのユーザー名
REMOTE_HOST="example.com"                 # リモートサーバーのホスト名またはIPアドレス
REMOTE_DIR="/path/to/remote/directory"    # リモートサーバーのディレクトリ
LOCAL_FILE="/path/to/local/file"          # 転送するローカルファイルのパス

# scpコマンドを実行
scp -i "$PRIVATE_KEY_FILE" "$LOCAL_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

# 実行結果を確認
if [ $? -eq 0 ]; then
    echo "File transferred successfully!"
else
    echo "File transfer failed."
fi

# 一時ファイルを削除
rm -f "$PRIVATE_KEY_FILE"
