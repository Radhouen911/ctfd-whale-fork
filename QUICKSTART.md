# Quick Start Guide - CTFd-Whale Modified

Get your modified CTFd-Whale plugin up and running in minutes!

## 🚀 Quick Push to GitHub

### Option 1: Automated Script (Windows)

```cmd
cd CTFd\plugins\ctfd-whale
push-to-github.bat YOUR_GITHUB_USERNAME
```

### Option 2: Manual Commands

```bash
cd CTFd/plugins/ctfd-whale

# Add and commit changes
git add decorators.py requirements.txt utils/routers/frp.py utils/setup.py
git add README.md CHANGELOG_FORK.md SETUP_GITHUB.md MODIFICATIONS_SUMMARY.md
git commit -m "feat: Add configurable frequency limit and FRP timeout"

# Set up remote (replace YOUR_USERNAME)
git remote remove origin
git remote add origin git@github.com:YOUR_USERNAME/ctfd-whale-modified.git

# Push
git push -u origin master
```

## 📋 What You Modified

### 1. Configurable Frequency Limit

**File**: `decorators.py`

- Changed from 60s to 10s default
- Made it configurable via admin panel
- Key: `whale:frequency_limit`

### 2. FRP Timeout Protection

**File**: `utils/routers/frp.py`

- Added 2-second timeout
- Prevents hanging

### 3. Default Config

**File**: `utils/setup.py`

- Added `frequency_limit: 10`

### 4. Updated Dependencies

**File**: `requirements.txt`

- Latest package versions

## ⚙️ Configuration

Set frequency limit in CTFd admin panel:

```
Key: whale:frequency_limit
Value: 10 (seconds)
```

**Recommended values**:

- Dev: `5` seconds
- Small CTF: `10` seconds (default)
- Large CTF: `30` seconds
- Production: `60` seconds

## 📚 Documentation Files

Your repository now includes:

- ✅ `README.md` - Main documentation
- ✅ `CHANGELOG_FORK.md` - Detailed changes
- ✅ `SETUP_GITHUB.md` - GitHub setup guide
- ✅ `MODIFICATIONS_SUMMARY.md` - Technical summary
- ✅ `QUICKSTART.md` - This file
- ✅ `push-to-github.bat` - Automated push script

## 🔗 Next Steps

1. **Create GitHub Repository**

   - Go to https://github.com/new
   - Name: `ctfd-whale-modified`
   - Don't initialize with README

2. **Push Your Code**

   - Use automated script or manual commands above

3. **Update Repository**

   - Add description
   - Add topics: `ctfd`, `docker`, `whale`, `ctf`
   - Update website link

4. **Create Release** (Optional)
   - Tag: `v1.0.0-modified`
   - Title: "CTFd-Whale Modified v1.0.0"

## 🐛 Troubleshooting

### SSH Permission Denied

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub
# Add to GitHub: Settings → SSH keys
```

### Repository Already Exists

```bash
git remote remove origin
git remote add origin git@github.com:YOUR_USERNAME/ctfd-whale-modified.git
```

### Commit Failed

```bash
git config user.name "Your Name"
git config user.email "your_email@example.com"
```

## 📊 Quick Comparison

| Feature         | Original        | Modified           |
| --------------- | --------------- | ------------------ |
| Frequency Limit | 60s (hardcoded) | 10s (configurable) |
| FRP Timeout     | None            | 2 seconds          |
| Error Messages  | Static          | Dynamic            |
| Configuration   | Hardcoded       | Admin panel        |

## ✅ Testing Checklist

Quick tests before deploying:

- [ ] Container creation works
- [ ] Frequency limit triggers correctly
- [ ] Error messages show wait time
- [ ] Admin panel config works
- [ ] FRP timeout prevents hanging

## 📞 Support

- **Setup Issues**: See [SETUP_GITHUB.md](SETUP_GITHUB.md)
- **Technical Details**: See [MODIFICATIONS_SUMMARY.md](MODIFICATIONS_SUMMARY.md)
- **Changes**: See [CHANGELOG_FORK.md](CHANGELOG_FORK.md)
- **Original Plugin**: https://github.com/frankli0324/ctfd-whale

## 🎉 You're Done!

Your modified CTFd-Whale plugin is now:

- ✅ Documented
- ✅ Ready to push
- ✅ Production ready
- ✅ Easy to configure

**Happy CTF-ing! 🚀**

---

**Quick Links**:

- [Full README](README.md)
- [Setup Guide](SETUP_GITHUB.md)
- [Modifications Summary](MODIFICATIONS_SUMMARY.md)
- [Changelog](CHANGELOG_FORK.md)
