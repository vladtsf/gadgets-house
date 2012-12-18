require "capistrano/node-deploy"

set :application, "gadgets-house"
set :repository,  "git@bitbucket.org:crimescene/gadgets-house.git"
set :user, "deploy"
set :scm, :git
set :git_enable_submodules, 1
set :deploy_to, "/home/deploy/gadgets-house"
set :node_binary, "/usr/bin/env node"
set :app_environment, "AMAZON_CLOUD_FRONT_URL=http://static.gadgets-house.net AMAZON_S3_BUCKET=gadgets-house AMAZON_S3_KEY=AKIAIXGSWTV5UYWWC2GA AMAZON_S3_SECRET=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 MONGODB=mongodb://127.0.0.1/gadgets-house"
set :app_command, "app.js"
set :node_user, "deploy"

role :app, "54.243.156.15"