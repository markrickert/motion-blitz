# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'
require 'bundler/gem_tasks'
require 'bundler/setup'
require './lib/motion-blitz'

Bundler.require :default

Motion::Project::App.setup do |app|
  app.name = 'motion-blitz'

  app.pods do
    pod 'SVProgressHUD', '~> 1.1.3'
  end
end
