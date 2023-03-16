classdef Motor < handle
    %MOTOR Class to initialize MG Nanomotion 2 motor
    %   Detailed explanation goes here
    
    properties(Access = private)
        
    end

    properties
        id;
        position = 0;
        isMoving = 0;
        isParked = 0;
        Controller;
        listenerHandle;
    end

    methods

        function obj = Motor(id)
            %MOTOR Construct an instance of this class
            %   Detailed explanation goes here
            obj.id = id;
            obj.Controller = Controller.instance();
            obj.createListener();
        end

        function createListener(obj)
            lh = addlistener(obj.Controller, 'message', @obj.statusChange);
            disp('Listener created');
            obj.listenerHandle = lh;
        end
        
        function statusChange(obj,~)
            disp('Something Changed')
        end

%         function disp(obj)
% %             disp('Controller Properties:');
% %             disp([' BaudRate: ', num2str(obj.BaudRate)]);
% %             disp([' ComPort: ', obj.ComPort]);
% %             disp([' TimeOut: ', num2str(obj.TimeOut)]);
% %             disp([' Com_Connected: ', num2str(obj.Com_Connected)]);
%             disp(' ');
%             disp('Motor Properties:');
%             disp([' Id: ', num2str(obj.id)]);
%             disp([' Position: ', num2str(obj.position)]);
%             disp([' Controller:'])
%         end

    end
end

