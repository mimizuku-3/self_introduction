# バージョンを指定してRubyイメージを取得
FROM ruby:2.7.7

# ＃必要なライブラリを取得
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

ENV RAILS_ROOT /self_introduction

# Railsアプリのルートディレクトリ作成
RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT

#ホストのGemfileとGemfile.lockをRailsコンテナにコピー
COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

#コピーされたGemfileを参照してbundle install
RUN bundle install --jobs 20 --retry 5 --without production

#ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
COPY . .

RUN mkdir -p tmp/sockets