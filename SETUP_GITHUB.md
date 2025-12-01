# GitHub Setup Guide

This guide will help you push your modified CTFd-Whale plugin to your own GitHub repository.

## Prerequisites

- Git installed on your system
- GitHub account
- SSH key configured with GitHub (or use HTTPS with personal access token)

## Step 1: Create a New GitHub Repository

1. Go to [GitHub](https://github.com)
2. Click the **+** icon in the top right → **New repository**
3. Repository settings:
   - **Name**: `ctfd-whale-modified` (or your preferred name)
   - **Description**: "Modified CTFd-Whale plugin with configurable frequency limits and improved stability"
   - **Visibility**: Public or Private (your choice)
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
4. Click **Create repository**

## Step 2: Update Git Remote

Open terminal/command prompt in the plugin directory:

```bash
cd CTFd/plugins/ctfd-whale

# Check current remote
git remote -v

# Remove old remote
git remote remove origin

# Add your new remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin git@github.com:YOUR_USERNAME/ctfd-whale-modified.git

# Or use HTTPS if you prefer
git remote add origin https://github.com/YOUR_USERNAME/ctfd-whale-modified.git
```

## Step 3: Commit Your Changes

```bash
# Check what files are modified
git status

# Add all modified files
git add decorators.py requirements.txt utils/routers/frp.py utils/setup.py

# Add new documentation files
git add README.md CHANGELOG_FORK.md SETUP_GITHUB.md

# Commit with descriptive message
git commit -m "feat: Add configurable frequency limit and FRP timeout

- Add whale:frequency_limit config option (default: 10s)
- Add 2-second timeout to FRP availability checks
- Update dependencies to latest versions
- Improve error messages with dynamic wait times
- Add comprehensive documentation"
```

## Step 4: Push to GitHub

```bash
# Push to your repository
git push -u origin master

# Or if you want to use 'main' as the default branch
git branch -M main
git push -u origin main
```

## Step 5: Update Repository Information

After pushing, update your GitHub repository:

1. Go to your repository on GitHub
2. Click **Settings**
3. Update:
   - **Description**: "Modified CTFd-Whale plugin with configurable frequency limits and improved stability"
   - **Website**: (optional) Link to your CTF platform or documentation
   - **Topics**: Add tags like `ctfd`, `ctf`, `docker`, `whale`, `ctfd-plugin`

## Step 6: Create a Release (Optional)

Create a release to mark this version:

1. Go to your repository → **Releases** → **Create a new release**
2. Tag version: `v1.0.0-modified`
3. Release title: "CTFd-Whale Modified v1.0.0"
4. Description:

   ```markdown
   ## What's New

   - ✨ Configurable frequency limit (default: 10 seconds)
   - 🔧 FRP timeout protection (2 seconds)
   - 📦 Updated dependencies
   - 🐛 Improved error handling
   - 📝 Comprehensive documentation

   ## Installation

   See [README.md](README.md) for installation instructions.

   ## Changes from Original

   See [CHANGELOG_FORK.md](CHANGELOG_FORK.md) for detailed changes.
   ```

5. Click **Publish release**

## Alternative: Fork and Pull Request

If you want to contribute back to the original project:

1. Fork the original repository: https://github.com/frankli0324/ctfd-whale
2. Clone your fork
3. Create a new branch: `git checkout -b feature/configurable-frequency-limit`
4. Make your changes
5. Push to your fork: `git push origin feature/configurable-frequency-limit`
6. Create a Pull Request on the original repository

## Troubleshooting

### Permission Denied (SSH)

If you get "Permission denied (publickey)":

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Copy public key
cat ~/.ssh/id_ed25519.pub

# Add to GitHub: Settings → SSH and GPG keys → New SSH key
```

### Authentication Failed (HTTPS)

If using HTTPS and authentication fails:

1. Create a Personal Access Token:
   - GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Generate new token with `repo` scope
2. Use token as password when pushing

### Already Exists Error

If you get "remote origin already exists":

```bash
# Remove existing remote
git remote remove origin

# Add new remote
git remote add origin git@github.com:YOUR_USERNAME/ctfd-whale-modified.git
```

## Repository Structure

Your repository should have this structure:

```
ctfd-whale-modified/
├── .git/
├── .gitignore
├── assets/
├── docs/
├── templates/
├── utils/
├── __init__.py
├── api.py
├── challenge_type.py
├── CHANGELOG.md              # Original changelog
├── CHANGELOG_FORK.md         # Your modifications changelog
├── decorators.py             # Modified
├── docker-compose.example.yml
├── LICENSE
├── models.py
├── README.md                 # Updated with your changes
├── README.zh-cn.md
├── requirements.txt          # Modified
└── SETUP_GITHUB.md          # This file
```

## Next Steps

After pushing to GitHub:

1. ✅ Update README.md with your repository URL
2. ✅ Add badges (optional): build status, license, version
3. ✅ Create issues for future improvements
4. ✅ Add GitHub Actions for CI/CD (optional)
5. ✅ Share with the CTF community!

## Maintenance

To keep your fork updated:

```bash
# Add original repository as upstream
git remote add upstream https://github.com/frankli0324/ctfd-whale.git

# Fetch updates from original
git fetch upstream

# Merge updates (be careful with conflicts)
git merge upstream/master

# Push to your repository
git push origin master
```

## License

Make sure to keep the original license and credit the original authors.

## Questions?

If you have questions about:

- **Git/GitHub**: Check [GitHub Docs](https://docs.github.com)
- **CTFd-Whale**: Check [original repository](https://github.com/frankli0324/ctfd-whale)
- **Your modifications**: Document in your repository's Issues section

---

**Happy coding! 🚀**
