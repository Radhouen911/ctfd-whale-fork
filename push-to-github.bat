@echo off
REM Quick script to push CTFd-Whale modifications to GitHub
REM Usage: push-to-github.bat YOUR_GITHUB_USERNAME

echo ========================================
echo CTFd-Whale GitHub Push Script
echo ========================================
echo.

if "%1"=="" (
    echo ERROR: Please provide your GitHub username
    echo Usage: push-to-github.bat YOUR_GITHUB_USERNAME
    echo Example: push-to-github.bat Radhouen911
    exit /b 1
)

set USERNAME=%1
set REPO_NAME=ctfd-whale-modified

echo GitHub Username: %USERNAME%
echo Repository Name: %REPO_NAME%
echo.

REM Check if we're in the right directory
if not exist "decorators.py" (
    echo ERROR: Please run this script from the ctfd-whale directory
    exit /b 1
)

echo Step 1: Checking git status...
git status
echo.

echo Step 2: Adding modified files...
git add decorators.py requirements.txt utils/routers/frp.py utils/setup.py
git add README.md CHANGELOG_FORK.md SETUP_GITHUB.md
echo Files added!
echo.

echo Step 3: Committing changes...
git commit -m "feat: Add configurable frequency limit and FRP timeout

- Add whale:frequency_limit config option (default: 10s)
- Add 2-second timeout to FRP availability checks  
- Update dependencies to latest versions
- Improve error messages with dynamic wait times
- Add comprehensive documentation"
echo.

echo Step 4: Removing old remote...
git remote remove origin 2>nul
echo.

echo Step 5: Adding new remote...
git remote add origin git@github.com:%USERNAME%/%REPO_NAME%.git
echo Remote added: git@github.com:%USERNAME%/%REPO_NAME%.git
echo.

echo Step 6: Pushing to GitHub...
echo.
echo IMPORTANT: Make sure you have created the repository on GitHub first!
echo Repository URL: https://github.com/%USERNAME%/%REPO_NAME%
echo.
pause

git push -u origin master
echo.

if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo SUCCESS! Your code has been pushed to GitHub
    echo ========================================
    echo.
    echo Repository URL: https://github.com/%USERNAME%/%REPO_NAME%
    echo.
    echo Next steps:
    echo 1. Visit your repository on GitHub
    echo 2. Update the description and topics
    echo 3. Create a release (optional)
    echo 4. Share with the community!
    echo.
) else (
    echo ========================================
    echo ERROR: Push failed
    echo ========================================
    echo.
    echo Common issues:
    echo 1. Repository doesn't exist on GitHub - Create it first
    echo 2. SSH key not configured - Run: ssh-keygen -t ed25519
    echo 3. Permission denied - Add SSH key to GitHub
    echo.
    echo For help, see SETUP_GITHUB.md
)

pause
