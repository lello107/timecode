require "timecode/version"

module Timecode

def self.addzero(val)
      newval=""
      if val.to_i <= 9 and not val == "ff"
        newval="0"+val.to_s
      else
        return val
      end
    return newval
end

def self.convert_to_frames(timecode)


        frames =0


        #Split the timecode string into it's component parts. NOTE: The string must
        #be in the form hh:mm:ss:ff otherwise an error will occur.
         tc = timecode.split(":")

        #The following are based on 25 fps.
        frames = (tc[0].to_i * 90000 + tc[1].to_i* 1500) + tc[2].to_i * 25 + tc[3].to_i



        return frames


    end

 def self.convert_from_frames(frames)

        intHours, intMins, intSecs, intFrames, intTmp=0
        timecode =""

        #Convert frames to hours, minutes and seconds.

        #Total number of seconds
        intSecs = (frames / 25).to_i

        #Total number of minutes
        intMins = (intSecs / 60).to_i

        #Total number of hours
        intHours = (intSecs / 3600).to_i

        #Number of secs remaining after subtracting  number of mins.
        intSecs = ((frames / 25) - (intMins * 60)).to_i

        #Number of mins remaining after subtracting number of hours.
        intMins = intMins - (intHours * 60)

        #Determine the number of frames remaining after subtracting hours,mins and secs
        intTmp = intSecs * 25
        intTmp = intTmp + (intMins * 60 * 25)
        intTmp = intTmp + (intHours * 60 * 60 * 25)
        intFrames = frames - intTmp

        #Convert to string, adding leading 0 where value is less than 10,and separating with ':'
        timecode = addzero(intHours.to_s)  + ":" + addzero(intMins.to_s) + ":" + addzero(intSecs.to_s) + ":" + addzero(intFrames.to_s)
        return timecode
    end

  def self.add_timecode(timecode1, timecode2)
        tc1 ,tc2 = 0
        tc1 = self.convert_to_frames(timecode1)
        tc2 = self.convert_to_frames(timecode2)
        return self.convert_from_frames(tc1 + tc2)
  end
    def self.diff_timecode(timecode1, timecode2)
        
        tc1 ,tc2 = 0
        tc1 = self.convert_to_frames(timecode1)
        tc2 = self.convert_to_frames(timecode2)
        return self.convert_from_frames(tc1 - tc2)
  end
end
