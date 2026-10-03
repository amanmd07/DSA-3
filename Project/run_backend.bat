@echo off
title Project Flow - Java Backend Engine
echo ===============================================================================
echo   PROJECT FLOW: GRAPH ALGORITHMS & CRITICAL PATH METHOD (CPM) ENGINE
echo ===============================================================================
echo.
cd /d "%~dp0backend"
java -cp "bin;lib/*" com.projectscheduler.Main
echo.
pause
