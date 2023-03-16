classdef (Abstract) AbstractController < handle

    properties (Access = private)
        SingletonInstance
    end

    properties
        BaudRate = 19200
        ComPort = 'COM4'
        TimeOut = 1;
        serial_object;
    end

    %%Define an abstract and static method that Concrete Controller has to define
     methods(Abstract, Static)
      obj = instance();
     end

     methods
        %Overwrite setter for BaudRate
        function set.BaudRate(self, value)
            self.BaudRate = value;
            disp("Baud Rate Changed")
        end
        %Overwrite setter for ComPort
        function set.ComPort(self, value)
            self.ComPort = value;
            disp("COM Changed")
        end
        %Overwrite setter for TimeOut
        function set.TimeOut(self, value)
            self.TimeOut = value;
            disp("Time Out Settings Changed")
        end
     end
end