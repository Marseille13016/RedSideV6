@echo off
%~dp0\FXServer +set citizen_dir %~dp0\citizen\ %*
+set onesync on +set onesync_enableInfinity 1 +set onesync_enableBeyond 1