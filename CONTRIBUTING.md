:mega: Pull requests are welcome on GitHub at https://github.com/shinosakarb/tebukuro .:mega:  
Tebukuroプロジェクトはレベルを問わず参加したい方を歓迎しています:smiley:  
ここでは参加を考えている方をサポートするために、プロジェクトへの参加方法やコントリビュート方法を説明しています。


###目次

- ####[Before Getting Started](#before-getting-started-1)

- ####[How to Contribute](#how-to-contribute-1)

- ####[Styleguides](#styleguides-1)


###Before Getting Started

- ####Tebukuroプロジェクトについて

  Tebukuroはモバイルフレンドリーなイベント運営管理サービスです。詳しくは[README](https://github.com/shinosakarb/tebukuro)を読んでみて下さい！  
  このプロジェクトは関西のRubyコミュニティの運営メンバーが中心となって立ち上げました。  
  失敗を恐れずに最新のアーキテクチャやツールを試したり、皆さんのスキルを向上することも目的としています:fist:

  >__*失敗自体が妨げになることはほとんどない。問題なのは失敗することへの恐れである。*__ -ジャック・レモン

- ####プロジェクトへの参加方法

  Github以外にも、コミュニティのイベントからもTebukuroに参加できます！

    - **[Github](https://github.com/shinosakarb/tebukuro)から**:octocat:

      現在挙がっているIssueの中で興味があるものがあればPull Requestしましょう。また試してみたい技術や欲しい機能があれば、Issueを立てて提案して下さい。議論のうえAcceptされれば実装します！


    - **関連コミュニティから**:two_men_holding_hands:

      プロジェクトメンバーには複数のコミュニティの設立者がおり、定期的に勉強会などのイベントを開催しています。イベント参加時やslackなどでも気軽に相談して下さい！

- ####Tebukuro関連コミュニティ

  プロジェクトメンバーが運営しているコミュニティを一部掲載します。  
  こちらにもぜひ参加して下さい:satisfied:

  - [Shinosaka.rb](https://shinosakarb.doorkeeper.jp/) - 新大阪を拠点に活動しているTebukuroの中心メンバーが主催のコミュニティです

  - [Rails follow up Osaka](https://rails-follow-up-osaka.doorkeeper.jp) - 大阪でRuby、Rails 初心者・初級者向けに有志でフォローする勉強会です

  - [Cherry.rb](https://cherryrb.doorkeeper.jp/) - RubyやRailsを始めたい、始めたばかりの人に向けたコミュニティです

  - [Ruby関西](https://rubykansai.doorkeeper.jp/) - 関西でのRubyに関するイベントの主体となるコミュニティです

###How to Contribute

- ####環境構築

  - **リポジトリのforkとclone**  

    [Githubのプロジェクトページ](https://github.com/shinosakarb/tebukuro)の最上段の右にある"Fork"をクリックして自アカウントにForkして下さい。  
    次にForkしたリポジトリをローカル環境にcloneして開発作業をして下さい。   
    cloneする時のコマンドは[wikiのtipsの手順の1～3](https://github.com/shinosakarb/tebukuro/wiki/Develop-tips#how-to-merge-pull-request)を参考にして下さい。

  - **Zenhub拡張機能のインストール**  

    Tebukuroではスクラム方式でプロジェクトを進めるため、Githubのページ上にBoardなどの機能をZenhubで拡張しています。  
    Zenhubのインストール方法・使い方は[こちらのページ](https://seleck.cc/670)などを参考にして下さい。

  - **Dockerによる開発環境構築**

    ローカルマシンでの環境構築を簡単に行えるよう、Dockerによる開発環境を提供しています。  
    [Dockerによる開発環境の構築手順](https://github.com/shinosakarb/tebukuro/wiki/Setup#setup-for-development)を参考にして構築してください。

- ####最新技術の導入・追加機能の提案  

  気になるけど本番のお仕事では試せないフレームワークやツール、既存のサービスで不満な事があれば、Tebukuroで実装しちゃいましょう:rocket:  
  Issueで提案してAcceptされれば次回リリースのRoadmapに追加します。  
  
- #### Sprint Backlog、Product Backlogにある機能の実装

  Issueで議論して導入を決定した機能はGithubのBoard上のProduct Backlogに追加します。  
  さらに優先順位の高いものはSprint Backlogに追加します。  
  特にこれらのBacklogに挙がっている機能はどしどしPull Requestして下さい:grin:

- #### Pull Request

    - **作業ブランチの作成**
    
      cloneしたリポジトリでmaster以外の作業用ブランチを作成し、そのブランチ内で作業してください。 
    
    - **作業時のcommitをまとめる**
    
      開発を完了してPull Requestを送る前にcommitをまとめるため、下記コマンド等でrebaseして下さい。最初の画面で最上段以外のコミットにsquashを指定し、次の画面でコミットメッセージを編集して下さい。  
      
      `$ git rebase -i`  

    - **最新版の取り込み**

      下記コマンドで作業ブランチに最新版のリポジトリを取り込んで下さい。

      ```
      $ git fetch upstream
      $ git rebase upstream/master
      ```
  
    - **Pull Requestの送付**

      自リポジトリのページ最上段の左にある"New pull request"をクリックしてPull Request画面を開いてください。  
      テンプレートの項目を記入して、Pull Requestを送付してください:email:  
  
    - **自動テストとレビュー**

      Pull Request送付後はCIツールによる自動テストが実行されます。  
      自動テストをパスした後にレビューして問題が無ければそのままmergeし、必要に応じてコメントで指摘します:writing_hand:  
  
    - **修正作業**

      自動テストに失敗したり、レビューで指摘された点は作業ブランチで修正してcommit、pushして下さい。  
      修正作業中のcommitはrebaseする必要はありません。  
      修正を完了してレビューを通過したら、再度rebaseしてコミットをまとめて下さい。
      
      :tada: **mergeされると開発した機能がTebukuroに実装されます** :clap:  

###Styleguides
  :construction:準備中:construction_worker:

  - Ruby
  - javascript
  - commit messages

###Addtional Notes
  ここではプロジェクト内で役立つ情報をまとめています。

  - ####[Tables](https://github.com/shinosakarb/tebukuro/wiki/Tables)

  - ####[Troubleshooting](https://github.com/shinosakarb/tebukuro/wiki/Troubleshooting)
