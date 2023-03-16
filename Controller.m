classdef Controller < AbstractController

    properties (SetAccess = protected)
        Com_Connected = false;
        Com_Callback;
        Com_lastMessage;
    end

    events
        message
    end

    properties (Access = private)
        SingletonInstance
    end

    methods (Static) %This method has to be static since it must be run before the obj is created.
        function obj = instance()
            %Define persistent variable to store instance
            persistent uniqueInstance;
            if isempty(uniqueInstance) || ~isvalid(uniqueInstance) %if empty
                obj = Controller(); %create obj and store it
                uniqueInstance = obj;
                try
                    obj.connect()
                catch e
                    disp("There was an error initially connecting, it is as follows:")
                    disp(e.message)
                end
            else
                obj = uniqueInstance; %Instance already exists so define the obj as the instance.
            end 
        end %eoFun
    end %eo Static methods

    methods (Access=private)
        function obj = Controller()
            disp("Controller Initiated")
        end
    end

    methods
        
        function connect(obj)
            if isempty(obj.serial_object) %Connect to serial port
                obj.serial_object = serialport(obj.ComPort,obj.BaudRate);
                configureTerminator(s,13,13); %Change Terminator to LF
                obj.Com_Callback = configureCallback(s,"terminator",@obj.readData);
            end
            fopen(obj.serial_object); %Start reading to memory
        end

        function disconnect(obj)
            fclose(obj.serial_object); %Stop reading to memory
        end

        function readData(obj)
            data = readline(obj.serial_object);
            data = strtrim(data);
            disp(data);
            obj.Com_lastMessage = data;
            notify(obj,'message');
        end

        function test(obj)
            notify(obj,'message');
        end

    end
end