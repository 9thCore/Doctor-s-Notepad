local extension = function(_level)
	_level.initqueue.queue(9,function(level,beat) --the number is in what order your extension will be loaded. lower = sooner
		
		--all of the functions you are adding to the level table go up here
		
		--typewriter effect
		local function roomwrite(self, beat,text,speed,duration,x,y,size,angle,mode,color,outlineColor,anchor)
			mode = mode or 'HideAbruptly'
			--split text up
			local length = #text
			local oldtext = text
			
			text = ''
			local timetable = {}
			
			for i=1,length do
				local ch = string.sub(oldtext,i,i)
				text = text .. ch
				if i ~= length then
					text = text .. '/'
					table.insert(timetable,i*speed)
				end
			end
			local fadeout = duration - timetable[#timetable]
			
			self:floatingtext(beat,text,timetable,x,y,size,angle,mode,true,color,outlineColor,anchor,fadeout)
			return timetable[#timetable]
		end
		
		function level:write(self,beat,room,text,speed,duration,x,y,size,angle,mode,color,outlineColor,anchor)
			return self.rooms[self:parseroom(room)]:write(beat,text,speed,duration,x,y,size,angle,mode,color,outlineColor,anchor)
		end
		
		
	
		--if you need to initialize anything, do it here.

		--add room specific functions
		if #level.rooms == 4 then
			for i,v in ipairs(level.rooms) do 
				v.write = roomwrite
			end
		else
			error('tried to add advanced text to nonexistent room objects!')
		end
		
		
		-- fake event handlers
		
		--add event type condensers
		
	end)
end

return extension