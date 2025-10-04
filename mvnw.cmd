@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements. See the NOTICE file for additional
@REM information regarding copyright ownership. The ASF licenses this file
@REM to you under the Apache License, Version 2.0.
@REM ----------------------------------------------------------------------------

@echo off
title %0

@REM Enable echoing if MAVEN_BATCH_ECHO is set
@if "%MAVEN_BATCH_ECHO%"=="on" echo MAVEN_BATCH_ECHO is on

@REM Set %HOME% if not already set
if "%HOME%"=="" set "HOME=%HOMEDRIVE%%HOMEPATH%"

@REM Execute pre-defined user scripts
if not "%MAVEN_SKIP_RC%"=="" goto skipRcPre
if exist "%USERPROFILE%\mavenrc_pre.bat" call "%USERPROFILE%\mavenrc_pre.bat" %*
if exist "%USERPROFILE%\mavenrc_pre.cmd" call "%USERPROFILE%\mavenrc_pre.cmd" %*
:skipRcPre

@setlocal
set ERROR_CODE=0

@REM ==== START JAVA_HOME VALIDATION ====
if not "%JAVA_HOME%"=="" goto OkJHome
echo.
echo Error: JAVA_HOME not found in your environment.
echo Please set JAVA_HOME to point to your Java installation.
echo.
goto error

:OkJHome
if exist "%JAVA_HOME%\bin\java.exe" goto init
echo.
echo Error: JAVA_HOME is set to an invalid directory.
echo JAVA_HOME = "%JAVA_HOME%"
echo Please set JAVA_HOME to point to your Java installation.
echo.
goto error
@REM ==== END VALIDATION ====

:init
@REM Find Maven project base directory
set MAVEN_PROJECTBASEDIR=%MAVEN_BASEDIR%
if not "%MAVEN_PROJECTBASEDIR%"=="" goto endDetectBaseDir

set EXEC_DIR=%CD%
set WDIR=%EXEC_DIR%
:findBaseDir
if exist "%WDIR%\.mvn" goto baseDirFound
cd ..
if "%WDIR%"=="%CD%" goto baseDirNotFound
set WDIR=%CD%
goto findBaseDir

:baseDirFound
set MAVEN_PROJECTBASEDIR=%WDIR%
cd "%EXEC_DIR%"
goto endDetectBaseDir

:baseDirNotFound
set MAVEN_PROJECTBASEDIR=%EXEC_DIR%
cd "%EXEC_DIR%"

