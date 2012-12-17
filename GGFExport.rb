#!/bin/env ruby
# encoding: utf-8

require "fileutils"

includePlantform = ["ggf_4399","ggf_manyou","ggf_qq","ggf_rr"]
prefix = "主界面/bin"
ROOT = "ggf"


def makeFolder(path)
	if FileTest::directory?(path)
		return
	end
	Dir::mkdir(path)
end

makeFolder(Dir::pwd+"/"+ROOT)
for i in includePlantform
	
	makeFolder(Dir::pwd+"/"+ROOT+"/"+i)
	1.upto(6) do |j|
		#system("ruby #{Dir::pwd+"/"+ROOT+"/"+i+"/"+prefix+"/"+"SplitFile.rb"}")
		FileUtils.copy(Dir::pwd+"/"+i+"/"+prefix+"/"+"main"+j.to_s+".bin",Dir::pwd+"/"+ROOT+"/"+i+"/"+prefix+"/"+"main"+j.to_s+".bin")
	end
end
