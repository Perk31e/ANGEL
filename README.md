# ANGEL
This is a shell script used for collecting various information on Android devices

If you want to test on virtual environment you must prepare following steps

1-1) Nox Player:<br/>

1. Check option to get Root privilege<br/><br/>
![Nox-Root](https://github.com/S3xyG4y/ANGEL/assets/55012702/5655ff56-375b-4202-b507-c6d5375cbd2a)<br/>

2. connect your Nox player<br/><br/>
![adb connect](https://github.com/S3xyG4y/ANGEL/assets/55012702/e9dd43ce-59ea-4fd8-9fb2-5640bb4d8401)<br/>

3. execute shell<br/><br/>
![shell access](https://github.com/S3xyG4y/ANGEL/assets/55012702/23b243e6-aa76-48f6-a033-9aa610b6065a)<br/>

    
As you can see you accessed shell with root


2) Check your environment's architecture<br/><br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/2ff62415-eec0-49f4-a951-e988243087a4)<br/>
as command output shows up this architecture is x86<br/>
3) Now PUSH Android shell script to your environment<br/><br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/2fb7ef9d-9d13-4a02-aaa8-e84c2e522cf3)<br/>
push ANGEL scripts and frida server (you can download frida server from here - https://github.com/frida/frida/releases)<br/>
4) grant permission<br/>
![grant permission](https://github.com/S3xyG4y/ANGEL/assets/55012702/17bdbbc7-6103-4941-8814-4b1e0b9ba009)<br/>
[*] Error handling - after we grant permission to thesee files then when we execute Android_main.sh it can be looks like characters shattered that would be the text type is CRLF not LF in that case ypu can follow below step (execute below commands only for scripts by the way we already set .gitattribute to use LF)<br/>
![sed](https://github.com/S3xyG4y/ANGEL/assets/55012702/cc9a3300-85ca-4f3f-bdee-7805685414ec)<br/>
-command example-<br/>
sed -i 's/\r$//' [yourfilename]<br/>

(Detailed explanation is needed regarding the license and script)


