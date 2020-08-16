# README

テーブル設定（仮）<br>
・user table
 > name:string<br>
 > email:string<br>
 > password_digest:string<br>

 ・task table
 > title:string<br>
 > content:text<br>
 > priority:string<br>
 > status:string<br>

 ・labe table
 > name:string


herokuデプロイ手順<br>
・アカウント作成（作成していない場合）<br>
・ログイン、ログアウト
 > heroku loguin<br>
 > heroku logout

 ・アセットファイルの生成
 > rails assets:precompile RAILS_ENV=production

 ・デプロイ
 > git add -A<br>
 > git commit -m "コメント内容"<br>
 > heroku create<br>
 > git push heroku master

 ・データベース設定
 > heroku run rails db:migrate

 ジェムバージョン
 > bootsnap (>= 1.1.0)  
 > byebug  
 > capybara (>= 2.15)  
 > coffee-rails (~> 4.2)  
 > factory_bot_rails  
 > jbuilder (~> 2.5)  
 > listen (>= 3.0.5, < 3.2)  
 > pg (>= 0.18, < 2.0)  
 > pry-rails  
 > puma (~> 3.11)  
 > rails (~> 5.2.4)  
 > rspec-rails (~> 3.8)  
 > sass-rails (~> 5.0)  
 > selenium-webdriver  
 > spring  
 > spring-commands-rspec  
 > spring-watcher-listen (~> 2.0.0)  
 > turbolinks (~> 5)  
 > tzinfo-data  
 > uglifier (>= 1.3.0)  
 > web-console (>= 3.3.0)  
 > webdrivers  

