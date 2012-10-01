.emacs
======

my emacs configuration


## 設定手順
1. 適当な場所にリポジトリのクローンを作る
2. Windowsの環境変数"HOME"に.emacsファイルが置かれたディレクトリのパスを通す
3. .emacsファイルの定数設定部分を環境に合わせて書き換える
4. Emacsをインストールする  
   ダウンロード - gnupack (cygwn + emacs package) - SourceForge.JP  
   http://sourceforge.jp/projects/gnupack/releases/?package_id=10839
5. 実行後、emacs\bin\runemacs.exeからemacsを起動する  

## 動作確認環境
- Windows7 32bit/64bit
- Emacs 24.2
- Cygwin 1.7.16

## 備考
主な設定ファイルは以下のディレクトリ下にあります。設定の詳細は各ファイルを参照してください。
- /.emacs.d/.emacs.d/init.d すべてのプラットフォームで共通の設定ファイル
- /.emacs.d/.emacs.d/init.d.w32 Windows専用の設定ファイル
- /.emacs.d/.emacs.d/init.d.linux Linux専用の設定ファイル


