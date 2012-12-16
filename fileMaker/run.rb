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
	paretntHash = {}
	counter = 0
	pre = 0
	current = 0
	parent = 0
	while (line = file.gets)
		current = getTabNum(line)
		if(!hash[current])
			hash[current] = [];
			paretntHash[current]
		end
		if(pre != current)
			if(!paretntHash[current])
				paretntHash[current] = 0
			else
				if(current - pre >0)
					paretntHash[current]+=1
				else
					puts ""
					paretntHash[current]
				end
				
			end
			pre = current
		end
		if(current == 0)
			parent = 0
		else
			parent = paretntHash[current]
		end
		line = line.gsub(/\s+/, "")
		#puts "#{current},#{line},#{paretntHash[current]}"
		hash[current].push({"value"=>line,"parent"=>parent});
		counter = counter+1
	end
	file.close
	#puts hash
	#assume key has sorted
	index = 0
	for arr in hash.values
		for obj in arr
			getFullPath(hash,obj,index-1)
		end
		index = index+1
	end
end

def getFullPath(hash,value,index)
	#deep = value.parent
	path = value["value"]
	puts path
	index.downto(0) do |i|
		#puts hash[i][value["parent"]]["value"]
		value = hash[i][value["parent"]]
		puts i 
		#value = hash[i][value.parent]
	end
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
