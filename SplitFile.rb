# chunk file with special size block
# modified from  http://stackoverflow.com/questions/6150227/ruby-how-to-split-a-file-into-multiple-files-of-a-given-size
def chunker1 f_in, out_pref, chunksize = 100,startIndex = 1,indexSize = 5,isBinary = false,suffix = ""
  #"r#{isBinary?"b":""}" not work..
  readFlag = isBinary ? "rb":"r"
  writeFlag = isBinary ? "wb":"w"
  File.open(f_in,readFlag) do |fh_in|
    until fh_in.eof?
      File.open("#{out_pref}#{"%0#{indexSize}d"%(fh_in.pos/chunksize +startIndex)}#{suffix}",writeFlag) do |fh_out|
        fh_out << fh_in.read(chunksize)
      end
    end
  end
end

#chunk file with special file number
def chunker2 f_in,out_pref,chunkNum,startIndex,indexSize,isBinary,suffix
  readFlag = isBinary ? "rb":"r"
  f = File.open(f_in,readFlag)
  chunksize = (f.size.to_f/chunkNum).ceil
  f.close
  chunker1 f_in,out_pref,chunksize,startIndex,indexSize,isBinary,suffix
end

startIndex = 1
indexSize = 1
suffix = ".bin"
isBinary = true
prefix = "main"
fileSize = 700000
readFile = "main.swf"
fileblock = 6


#chunker1 readFile,prefix,fileSize,startIndex,indexSize,isBinary,suffix
chunker2 readFile,prefix,fileblock,startIndex,indexSize,isBinary,suffix
