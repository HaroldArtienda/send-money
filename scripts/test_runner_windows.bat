@echo off
chcp 65001 > nul

:: Move to project root
cd ..

echo.
echo 📦 Running build_runner...
call flutter pub run build_runner build --delete-conflicting-outputs

IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo ❌ build_runner failed. Fix issues first.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ✅ build_runner complete.
echo.

echo 🧪 Running tests...
call flutter test

IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo ❌ Some tests failed.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ✅ All tests passed.
