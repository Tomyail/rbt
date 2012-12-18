def makeFolder(path)
	if FileTest::directory?(path)
		return
	end
	Dir::mkdir(path)
end

def makeFile(path)
	if FileTest::exist?(path)
		return
	end
	file = File.new(path,"w")
	file.close
end


def readConfig()
	file = File.new("struct.txt","r");
	hash = {}
	paretntHash = {0=>0}
	counter = 0
	pre = 0
	current = 0
	parent = 0
	while (line = file.gets)
		current = getTabNum(line)
		if(!hash[current])
			hash[current] = [];
		end
		if(pre != current)
			if(current - pre >0)
				paretntHash[current] = hash[current-1].length-1
			end
			pre = current
		end
		parent = paretntHash[current]
		line = line.gsub(/\s+/, "")
		#puts "#{current},#{line},#{paretntHash[current]}"
		hash[current].push({"value"=>line,"parent"=>parent});
		counter = counter+1
	end
	file.close
	#assume key has sorted
	index = 0
	for arr in hash.values
		for obj in arr
			make(getFullPath(hash,obj,index-1))
		end
		index = index+1
	end
end

def make(str)
	result = []
	arr = str.split("/").reverse
	for i in arr
		result.push(i)
		break if isFile(i)
	end
	if(isFile(result[result.length-1]))
		makeFile(getRealName(result))
	else
		makeFolder(getRealName(result))
	end
end

def getFullPath(hash,value,index)
	#deep = value.parent
	path = value["value"]
	index.downto(0) do |i|
		path += "/"+hash[i][value["parent"]]["value"]
		value = hash[i][value["parent"]]
	end
	return path
end

def getRealName(arr)
	return Dir::pwd+"/"+arr.join("/").gsub(/d:/,"").gsub(/f:/,"")
end
def isFile(value)
	return value.split(":")[0] == "f"
end

def isDir(value)
	return value.split(":")[0] == "d"
end

def getTabNum(str)
	count = 0;
	for i in str.split("")
		break if i != "\t"
		count = count+1
	end
	return count
end

readConfig();

#10.downto(1) do |i|
#	break if i== 8
#	puts i
#end
