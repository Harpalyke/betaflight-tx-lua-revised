return{filename="",file=nil,serialize=function(self,a)self.closeFile(self)self.openWrite(self)io.write(self.file,"return ")self.serializeObject(self,a)self.closeFile(self)end,serializeAppend=function(self,a)if self.file then self.serializeObject(self,a)end end,serializeObject=function(self,a)if type(a)=="number"then io.write(self.file,a)elseif type(a)=="string"then io.write(self.file,string.format("%q",a))elseif type(a)=="table"then io.write(self.file,"{")for b,c in pairs(a)do io.write(self.file,b,"=")self.serializeObject(self,c)io.write(self.file,",")end;io.write(self.file,"}")else error("cannot serialize a "..type(a))end end,openWrite=function(self)self.open(self,"w")end,openAppend=function(self)self.open(self,"a")end,open=function(self,d)self.file=io.open(self.filename,d)end,append=function(self,a)if type(a)=="string"or type(a)=="number"then io.write(self.file,a)end end,appendHex=function(self,a)if type(a)=="table"then for e=1,#a do self.append(self,string.format("%X ",a[e]))end elseif type(a)=="number"then self.append(self,string.format("%X ",a))end end,closeFile=function(self)if self.file then io.close(self.file)end end}
